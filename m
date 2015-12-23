From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 23 Dec 2015 10:05:34 +0000
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move
 rockchip to use it
In-Reply-To: <20151223103906.2aae53595345240d57d57b41@free.fr>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <20151222173800.GU960@e106497-lin.cambridge.arm.com>
 <20151223103906.2aae53595345240d57d57b41@free.fr>
Message-ID: <20151223100534.GW960@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 10:39:06AM +0100, Jean-Francois Moine wrote:
> On Tue, 22 Dec 2015 17:38:00 +0000
> Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> 
> > On Fri, Nov 20, 2015 at 02:22:03PM +0000, Liviu Dudau wrote:
> > > Hello,
> > > 
> > > This is v2 of the patchset trying to make drm_of_component_probe() cope with finding
> > > both local crtc ports and remote encoder ones. Heiko St?bner was nice enough to test
> > > an earlier version that was patched following Russell's suggestions on rk3288, but
> > > I haven't seen any reports from iMX or Armada users.
> > > 
> > > Changelog:
> > >  v2: Updated the drm_of_component_probe() comment to explain why the reference count
> > >      is not dropped. Fixed the compare_port() function for rockchip as described by
> > >      Russell.
> > >  v1: Original submission. http://lists.freedesktop.org/archives/dri-devel/2015-November/094546.html
> > 
> > Gentle ping, this has now been tested by Rockchip people and fixes the earlier version
> > that had to be reverted in mainline. Can it be included in the -next somewhere?
> 
> Hi Liviu,
> 
> Sorry for being a bit late.
> 
> I wanted to use drm_of_component_probe() for a new DRM driver, but I
> could not find any way to do it: you add the "ports" nodes as
> components while, usually, the components are the device nodes
> themselves.
> 
> With this simple patch:
> 
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 493c05c..dbd2921 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -101,7 +101,7 @@ int drm_of_component_probe(struct device *dev,
>  			continue;
>  		}
>  
> -		component_match_add(dev, &match, compare_of, port);
> +		component_match_add(dev, &match, compare_of, port->parent);
>  		of_node_put(port);
>  	}
>  
> everything is easy, my DT being like:
> 
> 	de_controller {
> 		...
> 		ports = <&lcd0_p>;
> 	};
> 
> 	lcd_controller {
> 		...
> 		lcd0_p: port {
> 			lcd0_ep: endpoint {
> 				remote-endpoint = <&hdmi_ep>;
> 			};
> 		};
> 	};
> 
> What was the reason to keep the "ports" node instead of the device?

The function is an extract of common code sprinkled through a few DRM drivers,
they all used port rather than port->parent.

Have a look at my v2 where I've introduced two compare functions and also
modified the Rockchip compare_port() to use port->parent in the comparison. I
guess that should solve your problem.

Best regards,
Liviu

> 
> -- 
> Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
> Jef		|		http://moinejf.free.fr/
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
