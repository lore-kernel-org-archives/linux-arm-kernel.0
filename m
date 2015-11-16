From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 16 Nov 2015 16:49:07 +0000
Subject: [PATCH 1/2] drm: Improve drm_of_component_probe() to correctly
 handle ports and remote ports.
In-Reply-To: <20151116162241.GN8644@n2100.arm.linux.org.uk>
References: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
 <1447685093-26129-2-git-send-email-Liviu.Dudau@arm.com>
 <20151116162241.GN8644@n2100.arm.linux.org.uk>
Message-ID: <20151116164907.GA4158@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 04:22:41PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 16, 2015 at 02:44:52PM +0000, Liviu Dudau wrote:
> > Rockchip DRM driver cannot use the same compare_of() function to match
> > ports and remote ports (aka encoders) as their OF sub-trees look different.
> > Add a second compare function to be used when encoders are added to the
> > component framework and patch the existing users of the function
> > accordingly.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > ---
> >  drivers/gpu/drm/armada/armada_drv.c |  3 ++-
> >  drivers/gpu/drm/drm_of.c            | 23 ++++++++++++++++++-----
> >  drivers/gpu/drm/imx/imx-drm-core.c  |  3 ++-
> >  include/drm/drm_of.h                |  6 ++++--
> >  4 files changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> > index 77ab93d..3a2a929 100644
> > --- a/drivers/gpu/drm/armada/armada_drv.c
> > +++ b/drivers/gpu/drm/armada/armada_drv.c
> > @@ -274,7 +274,8 @@ static int armada_drm_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	int ret;
> >  
> > -	ret = drm_of_component_probe(dev, compare_dev_name, &armada_master_ops);
> > +	ret = drm_of_component_probe(dev, compare_dev_name, compare_dev_name,
> > +				     &armada_master_ops);
> >  	if (ret != -EINVAL)
> >  		return ret;
> >  
> > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > index 493c05c..58fafd7 100644
> > --- a/drivers/gpu/drm/drm_of.c
> > +++ b/drivers/gpu/drm/drm_of.c
> > @@ -77,7 +77,8 @@ EXPORT_SYMBOL(drm_of_find_possible_crtcs);
> >   * Returns zero if successful, or one of the standard error codes if it fails.
> >   */
> >  int drm_of_component_probe(struct device *dev,
> > -			   int (*compare_of)(struct device *, void *),
> > +			   int (*compare_port)(struct device *, void *),
> > +			   int (*compare_encoder)(struct device *, void *),
> >  			   const struct component_master_ops *m_ops)
> >  {
> >  	struct device_node *ep, *port, *remote;
> > @@ -101,8 +102,14 @@ int drm_of_component_probe(struct device *dev,
> >  			continue;
> >  		}
> >  
> > -		component_match_add(dev, &match, compare_of, port);
> > -		of_node_put(port);
> > +		component_match_add(dev, &match, compare_port, port);
> > +		/*
> > +		 * component_match_add keeps a reference to the port
> > +		 * variable but does not do proper reference counting,
> > +		 * so we cannot release the reference here. If that
> > +		 * gets fixed, the following line should be uncommented
> > +		 */
> > +		/* of_node_put(port); */
> 
> Even if it is fixed, this line should _never_ be uncommented.  This is
> totally the wrong place to drop the reference.

What if (as implied by the comment) component_match_add() does some reference counting
of sorts? (I know it doesn't get used only with OF nodes, it is more generic). I feel
that holding onto a reference to a counted resource without incrementing the use count
is not the right way of doing things, or at least it should be clearly documented in
the interface of component_match_add() so that people understand the mess they are
getting into.


> 
> >  	}
> >  
> >  	if (i == 0) {
> > @@ -140,8 +147,14 @@ int drm_of_component_probe(struct device *dev,
> >  				continue;
> >  			}
> >  
> > -			component_match_add(dev, &match, compare_of, remote);
> > -			of_node_put(remote);
> > +			component_match_add(dev, &match, compare_encoder, remote);
> > +			/*
> > +			 * component_match_add keeps a reference to the port
> > +			 * variable but does not do proper reference counting,
> > +			 * so we cannot release the reference here. If that
> > +			 * gets fixed, the following line should be uncommented
> > +			 */
> > +			/* of_node_put(remote); */
> 
> Ditto.
> 
> The component helper retains a reference (by pointer value) to the 'port'
> or 'remote', which is then subsequently passed into the supplied
> 'compare_encoder' or 'compare_port' method.
> 
> If you drop the reference after adding the match, then that pointer can
> go away and be re-used for something else - and that means it's totally
> useless to the compare functions, since the memory pointed to by it may
> not contain an device_node struct anymore.
> 
> So, it _never_ makes sense to drop the reference at this point.

See my comment above. Keeping a reference to a resource and passing it
on to other functions (even if they are callbacks) should clearly flag the
component framework as one of the refcounters.

> 
> Where it does make sense is when the array of matches is destroyed.  For
> that, we'd need to add a callback to the master ops struct so that the
> master driver can properly release these pointers.
> 
> I'd keep most of the big comments though (up to "... varable") to
> explain why we don't drop the reference.

Sorry, if I understand you correctly, you're saying that we should keep
the following comment:

			/*
			 * component_match_add keeps a reference to the port
			 * variable.
			 */

How does that explain why we don't drop the reference? Did you mean the comment
should be truncated somewhere else by chance (like including the fact the
reference counting is not done)?

Best regards,
Liviu

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
