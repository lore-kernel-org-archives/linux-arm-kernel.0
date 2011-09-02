From: inki.dae@samsung.com (Inki Dae)
Date: Fri, 02 Sep 2011 21:00:21 +0900
Subject: [RFC][PATCH v3] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
In-Reply-To: <CAF6AEGuZb1nhMJwc+k-cwPTPLHTiO1PkHcpGN899Yq3pEMUwkA@mail.gmail.com>
References: <1314359274-21585-1-git-send-email-inki.dae@samsung.com>
	<CAF6AEGu3ss-rJC28H1rm2GWLm1bAZnHLftXfMLJQNeqjBt3umQ@mail.gmail.com>
	<001001cc67aa$72760460$57620d20$%dae@samsung.com>
	<CAF6AEGsqbFcS_QwihrjpVLQK1Y+h1iJSyu+GFV0Govp3XHYbOw@mail.gmail.com>
	<003501cc68a7$e8935aa0$b9ba0fe0$%dae@samsung.com>
	<CAF6AEGuZb1nhMJwc+k-cwPTPLHTiO1PkHcpGN899Yq3pEMUwkA@mail.gmail.com>
Message-ID: <001401cc6967$e41f3460$ac5d9d20$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob.
Below is my comments.

> -----Original Message-----
> From: Rob Clark [mailto:robdclark at gmail.com]
> Sent: Friday, September 02, 2011 10:18 AM
> To: Inki Dae
> Cc: airlied at linux.ie; dri-devel at lists.freedesktop.org;
> sw0312.kim at samsung.com; linux-kernel at vger.kernel.org;
> kyungmin.park at samsung.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [RFC][PATCH v3] DRM: add DRM Driver for Samsung SoC
> EXYNOS4210.
> 
> On Thu, Sep 1, 2011 at 8:06 AM, Inki Dae <inki.dae@samsung.com> wrote:
> >> >> > +struct samsung_drm_gem_obj *
> >> >> > + ? ? ? ? ? ? ? find_samsung_drm_gem_object(struct drm_file
> > *file_priv,
> >> >> > + ? ? ? ? ? ? ? ? ? ? ? struct drm_device *dev, unsigned int
handle)
> >> >> > +{
> >> >> > + ? ? ? struct drm_gem_object *gem_obj;
> >> >> > +
> >> >> > + ? ? ? gem_obj = drm_gem_object_lookup(dev, file_priv, handle);
> >> >> > + ? ? ? if (!gem_obj) {
> >> >> > + ? ? ? ? ? ? ? DRM_LOG_KMS("a invalid gem object not registered
to
> >> >> lookup.\n");
> >> >> > + ? ? ? ? ? ? ? return NULL;
> >> >> > + ? ? ? }
> >> >> > +
> >> >> > + ? ? ? /**
> >> >> > + ? ? ? ?* unreference refcount of the gem object.
> >> >> > + ? ? ? ?* at drm_gem_object_lookup(), the gem object was
> referenced.
> >> >> > + ? ? ? ?*/
> >> >> > + ? ? ? drm_gem_object_unreference(gem_obj);
> >> >>
> >> >> this doesn't seem right, to drop the reference before you use the
> >> >> buffer elsewhere..
> >> >>
> >> > No, see drm_gem_object_lookup fxn. at this function, if there is a
> >> object
> >> > found then drm_gem_object_reference is called to increase refcount of
> >> this
> >> > object. if there is any missing point, give me any comment please.
> thank
> >> > you.
> >>
> >>
> >> Right, but I think there is a reason it takes a reference... so that
> >> the object doesn't get free'd from under your feet. ?So pattern
> >> should, I think, be:
> >>
> >> ? obj = lookup(...);
> >> ? ... do stuff w/ obj ...
> >> ? unreference(obj)
> >>
> >> so the caller who is using the looked up obj should unref it when done
> >>
> >> Instead, you have:
> >>
> >> ? obj = lookup(...);
> >> ? unreference(obj);
> >> ? ... do stuff w/ obj ...
> >>
> >>
> >
> > Generally right, but in this case, it is just used to get specific gem
> > object through find_samsung_drm_gem_object() so doesn't reference this
> gem
> > object anywhere.
> > therefore reference and unreference should be done within
> > find_samsung_drm_gem_object(). if there is any point I missed then let
> me
> > know please. thank you.
> >
> 
> Still, it seems like find_samsung_drm_gem_object() is encouraging the
> wrong usage-pattern, even if it works fine today because you know
> somewhere else is holding a reference to the object.  Later if you
> expand your use of GEM objects, this fxn might come back to bite you.
> There is a good reason that drm_gem_object_lookup() takes a reference
> to the object, and it feels wrong to intentionally subvert that.
> 
> (I'm perfectly willing to be overridden on the subject.. there are
> plenty of folks on this list who have been doing the GEM thing longer
> than I have.  But it just seems better to use APIs like
> drm_gem_object_lookup() the way they were intended.)
> 

Ah, you are right. I misunderstanded it. as you pointed out, a gem object
should be unreferenced after doing something with the gem object. so I will
remove find_samsung_drm_gem_object() and use drm_gem_object_lookup()
directly to get a gem object instead. of course, the gem object will be
unreferenced after doing something with it. thank you for your explanation.
:)

> BR,
> -R
