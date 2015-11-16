From: liviu@dudau.co.uk (Liviu Dudau)
Date: Mon, 16 Nov 2015 21:17:35 +0000
Subject: [PATCH 1/2] drm: Improve drm_of_component_probe() to correctly
 handle ports and remote ports.
In-Reply-To: <20151116172248.GP8644@n2100.arm.linux.org.uk>
References: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
 <1447685093-26129-2-git-send-email-Liviu.Dudau@arm.com>
 <20151116162241.GN8644@n2100.arm.linux.org.uk>
 <20151116164907.GA4158@e106497-lin.cambridge.arm.com>
 <20151116172248.GP8644@n2100.arm.linux.org.uk>
Message-ID: <20151116211735.GA12564@bart.dudau.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 05:22:48PM +0000, Russell King - ARM Linux wrote:
> Please sensibly wrap your messages.  Your lines are longer than 80 characters which makes it exceedingly difficult for some people to reply to your very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very long lines without first reformatting them manually - and why should they bother to reply if they have that kind of additional work?  Thanks.

I usually follow the text above and type in text mode. I am made to suffer
a Microsoft Exchange server in between me and the open world and I have
no control if it decides to reformat the message. It is by no means
my intent to type everything in one line but I also choose sometime to
have longer lines if I believe that it helps the readability of the text.

> 
> On Mon, Nov 16, 2015 at 04:49:07PM +0000, Liviu Dudau wrote:
> > On Mon, Nov 16, 2015 at 04:22:41PM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Nov 16, 2015 at 02:44:52PM +0000, Liviu Dudau wrote:
> > > > Rockchip DRM driver cannot use the same compare_of() function to match
> > > > ports and remote ports (aka encoders) as their OF sub-trees look different.
> > > > Add a second compare function to be used when encoders are added to the
> > > > component framework and patch the existing users of the function
> > > > accordingly.
> > > > 
> > > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > > > ---
> > > >  drivers/gpu/drm/armada/armada_drv.c |  3 ++-
> > > >  drivers/gpu/drm/drm_of.c            | 23 ++++++++++++++++++-----
> > > >  drivers/gpu/drm/imx/imx-drm-core.c  |  3 ++-
> > > >  include/drm/drm_of.h                |  6 ++++--
> > > >  4 files changed, 26 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> > > > index 77ab93d..3a2a929 100644
> > > > --- a/drivers/gpu/drm/armada/armada_drv.c
> > > > +++ b/drivers/gpu/drm/armada/armada_drv.c
> > > > @@ -274,7 +274,8 @@ static int armada_drm_probe(struct platform_device *pdev)
> > > >  	struct device *dev = &pdev->dev;
> > > >  	int ret;
> > > >  
> > > > -	ret = drm_of_component_probe(dev, compare_dev_name, &armada_master_ops);
> > > > +	ret = drm_of_component_probe(dev, compare_dev_name, compare_dev_name,
> > > > +				     &armada_master_ops);
> > > >  	if (ret != -EINVAL)
> > > >  		return ret;
> > > >  
> > > > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > > > index 493c05c..58fafd7 100644
> > > > --- a/drivers/gpu/drm/drm_of.c
> > > > +++ b/drivers/gpu/drm/drm_of.c
> > > > @@ -77,7 +77,8 @@ EXPORT_SYMBOL(drm_of_find_possible_crtcs);
> > > >   * Returns zero if successful, or one of the standard error codes if it fails.
> > > >   */
> > > >  int drm_of_component_probe(struct device *dev,
> > > > -			   int (*compare_of)(struct device *, void *),
> > > > +			   int (*compare_port)(struct device *, void *),
> > > > +			   int (*compare_encoder)(struct device *, void *),
> > > >  			   const struct component_master_ops *m_ops)
> > > >  {
> > > >  	struct device_node *ep, *port, *remote;
> > > > @@ -101,8 +102,14 @@ int drm_of_component_probe(struct device *dev,
> > > >  			continue;
> > > >  		}
> > > >  
> > > > -		component_match_add(dev, &match, compare_of, port);
> > > > -		of_node_put(port);
> > > > +		component_match_add(dev, &match, compare_port, port);
> > > > +		/*
> > > > +		 * component_match_add keeps a reference to the port
> > > > +		 * variable but does not do proper reference counting,
> > > > +		 * so we cannot release the reference here. If that
> > > > +		 * gets fixed, the following line should be uncommented
> > > > +		 */
> > > > +		/* of_node_put(port); */
> > > 
> > > Even if it is fixed, this line should _never_ be uncommented.  This is
> > > totally the wrong place to drop the reference.
> > 
> > What if (as implied by the comment) component_match_add() does some
> > reference counting of sorts? (I know it doesn't get used only with
> > OF nodes, it is more generic).
> 
> Put those two sentences together and please think about it.  If the
> pointer type is unknown to component_match_add(), how could it ever
> use of_node_get() on it?  What if it's a string?  Or a struct device?
> Or something else.

I did not say of_node_get() I said "some reference counting of sorts".
One option would be to have (yet) another callback that the user of the
components framework has to provide that does resource management. And for
the record, I did thought about it and not for just a few minutes. I also
came out of the thought process with the conclusion that while the components
framework is doing the job it was coded for, it needs serious improvements
in terms of documentation.

> 
> > I feel that holding onto a reference to a counted resource without
> > incrementing the use count is not the right way of doing things, or
> > at least it should be clearly documented in the interface of
> > component_match_add() so that people understand the mess they are
> > getting into.
> 
> That's just crap.  You're not thinking before you hit your keyboard.

Russell, I have no idea what do I need to do in order to gain your respect
and for you to start treating me like a human being. Maybe *I* need to
lower my expectations and stop hoping to have a civilised discussion with
you.

> Why should component_match_add(), which has _zero_ knowledge about
> what it's being used with, have documentation attached to it which
> would be:
> 
> "If you use component_match_add() with X, you need to do X'.  If you
> use it with Y, you need to do Y'.  If you use it with Z, you need to
> do Z'."
> 
> No, that's utterly insane.

No. It is utterly insane not to have documentation when using the framework
or the function leads to memory leaks. You can say "If you use
component_match_add() you need to provide a callback for resource management
if your X or Y or Z needs such operations". The current components framework
is seriously in need of documentation. To borrow your language, look at the
crap one needs to put up with when starting to use the framework: to be a
component one needs to fill the component_ops structure. This is its
definition:

struct component_ops {
	int (*bind)(struct device *, struct device *, void *);
	void (*unbind)(struct device *, struct device *, void *);
};

Note that there are no names associated with the parameters and no documentation
to allow one to distinguish between the two struct device pointers. You have
to look at component_bind() to learn that first parameter is a component's
dev part and the second is the master's dev part.

You might think that the code is the proper documentation and ultimately that
is right, but even code is wrong sometimes and (as we discovered with the
component_match_add() discussion here) its side effects are not easy to spot
even to the authors of the code.

So, yes, we do need documentation, even if it is insane, because it tells us
how insanely fragile the code is. Even God, through Moses, has tersely
documented his Operating System through the 10 commandments.

Another example: of the 6 commits for drivers/base/component.c, 3 of them
have "fixed ... handling/cleanup/bug". So it is not easy to get it right.

> 
> > > Where it does make sense is when the array of matches is destroyed.  For
> > > that, we'd need to add a callback to the master ops struct so that the
> > > master driver can properly release these pointers.
> > > 
> > > I'd keep most of the big comments though (up to "... varable") to
> > > explain why we don't drop the reference.
> > 
> > Sorry, if I understand you correctly, you're saying that we should keep
> > the following comment:
> > 
> > 			/*
> > 			 * component_match_add keeps a reference to the port
> > 			 * variable.
> > 			 */
> 
> Exactly.
> 
> > How does that explain why we don't drop the reference? Did you mean the
> > comment should be truncated somewhere else by chance (like including the
> > fact the reference counting is not done)?
> 
> I'm sorry, I totally fail to understand what's soo difficult for you to
> understand about the above comment.  I can only conclude that there's
> something wrong in your understanding of memory pointers, aka addresses.

No, I was operating under the belief that if some framework holds a pointer
to a resource it should also do the management of that resource. Your
choice for the component framework has been different and you have decided
that it is just a conduit for data gathering and binding, without any deep
knowledge of what that data is. But that is not documented anywhere, so I
don't feel too bad about having a different view.

> 
> Each and every memory pointer is a _reference_ to a piece of data - just
> like your home address is a _reference_ to the location where you live.
> 
> Some references we explicitly count, other references we implicitly count,
> and others we don't bother.
> 
> In this case, of_parse_phandle() looks up the reference to the requested
> device_node struct - and of_parse_phandle() knows that the reference is
> going to be passed to the caller, outside it's control, so it increments
> the count of references.
> 
> So, the code in drm_of_component_probe() gains a reference _and_ a count
> against the device_node, the count being a tool to ensure that the
> reference doesn't become invalid.
> 
> We then store _our_ reference to this inside the component helper by
> means of calling component_add_match().  We don't care about how or
> where it's stored, only that it is stored.
> 
> Hence, because we want to _store_ that away, it would now be incorrect
> to drop the count against the reference.  We have stored a reference
> to it inside a helper which knows nothing about the refcounting of this
> structure.
> 
> When the helper gets fixed, it will have a callback to release the stored
> data, which becomes the responsibility of the creator to provide.  In
> this case, the reference to the device node by way of pointer value is
> passed back to the creating code, at which point the refcount is dropped.
> 
> There is no need what so ever for the component stuff to mess around
> with reference counts itself - and adding it will only make things
> more messy.  I can't see why anyone would even suggest crap like that.
> 
> Whenever something takes an opaque object, refcounting has to be done
> by the code using the opaque object, which has to ensure that the
> lifetime of the references stored in the opaque object are longer than
> the opaque object itself.  That's exactly what's going on here.
> 
> Please bear in mind that a _reference_ and a _refcount_ are two totally
> separate things.  A reference would be a copy of your home postal
> address.  A refcounter would be a box kept at your home address which
> indicates how many references there are out there.
> 
> If you gave me your home postal address on a piece of paper, and I then
> photocopied it, stored it in a safe, and then destroyed the original
> copy you gave me, why should I have to increment the refcounter and
> then immediately decrement it again...
> 
> That's exactly what's going on here: we're _temporarily_ transferring
> the responsibility for the held refcount to the opaque component
> helper.  The fact that the component helper has no way to transfer
> responsibility for that held refcount back to us is neither here nor
> there...
> 
> To rephrase using the example above - the reference is stored in the
> safe, but the safe has been destroyed without regard for its contents.
> That's where the problem lies: the safe should have been opened, the
> address obtained, and the refcounter for the address decremented.
> 
> If you separate the concept of "reference" from "refcount" and realise
> that a reference is merely a pointer to something, then I don't see
> what the issue is with understanding what's going on here.

I understand your point. You have also written some excellent piece of
documentation for the behaviour of the component framework that I feel
should be included in the kernel rather than being lost in the sea of emails.

Best regards,
Liviu

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
