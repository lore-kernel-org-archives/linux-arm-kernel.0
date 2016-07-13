From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 13 Jul 2016 14:55:51 -0600
Subject: [PATCH V8 7/9] vfio, platform: make reset driver a requirement
 by default
In-Reply-To: <4d95e48a-b5a1-c3eb-8aed-ddd307e1b028@codeaurora.org>
References: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
 <1466437879-32182-8-git-send-email-okaya@codeaurora.org>
 <20160623125955.647008cb@t450s.home>
 <4d95e48a-b5a1-c3eb-8aed-ddd307e1b028@codeaurora.org>
Message-ID: <20160713145551.2e544361@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jul 2016 16:12:35 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> On 6/23/2016 2:59 PM, Alex Williamson wrote:
> >> >  static struct resource *get_platform_resource(struct vfio_platform_device *vdev,
> >> > @@ -66,6 +70,7 @@ static int vfio_platform_probe(struct platform_device *pdev)
> >> >  	vdev->get_resource = get_platform_resource;
> >> >  	vdev->get_irq = get_platform_irq;
> >> >  	vdev->parent_module = THIS_MODULE;
> >> > +	vdev->reset_required = reset_required;  
> > 
> > Do you see value in making the global reset_required changeable, with
> > the behavior of any given device dependent on the setting of this
> > variable at the time of probe?  It seems like a bit of a support issue
> > to me.  Also, we're breaking existing users if there are any with this
> > change.  Should we introduce a CONFIG option to set the default?  I
> > think we can get away with changing the default that way, but I'm not
> > so sure otherwise.
> >   
> 
> We have two groups of existing users.
> 
> 1. AMBA based drivers
> 2. DT based drivers
> 
> and now we are trying to add the ACPI based drivers in this series.
> 
> The AMBA based drivers do not have reset function implemented. Based on
> previous conversation with Eric, these devices were mostly used for
> bringing up the VFIO framework and were not intended for production. 
> If we want to maintain existing functionality, I can change reset_required to
> false by default for the AMBA based drivers.

I think we need to consider them to be in production at this point, so
probably better to make such a change.
 
> The DT based drivers all have reset functions implemented. They shouldn't be
> impacted by the reset_required flag. 

Ok, so we're fine there.

> The reset_required flag is again useful for testing purposes when the reset
> driver is broken or the ACPI _RST method is missing.

I don't doubt that, but it doesn't need to be mode 644 for that, which
allows changing the default dynamically.  We could make it 444 so that
it can be set at module load time and not modified.  I just don't want
to try to guess the state of that variable at the time the device was
probed.

> The previously agreed approach was to force the reset required by default
> for production environment and be able to clear it for testing purposes.
> When I was implementing HIDMA, I never realized that I needed a reset driver
> until Arnd told me during the review. We want to avoid this for the long
> term for DT and ACPI based implementations.

I agree, but we don't need to make it dynamically changeable for that.
Also, nothing prevents us from printing a warning when a device is
probed w/o a reset function, it's just a matter of whether that causes
a probe failure or a complain and continue.

> The reset_required command line parameter would be useful if somebody suspects
> that the ACPI _RST implementation is broken or the DT based reset driver is
> broken or you quickly want to test the virtualization without having a reset
> driver ready yet.
> 
> Let us know which way you want to go. I can also add a Kconfig option and
> set it by default. But then I have to recompile the kernel when I want to
> test without the reset stuff.

Seems like we don't need a Kconfig, but I don't see why the option
needs to be settable except at module load time and we can complain
either way to clue in developers and catch such things in testing.
Thanks,

Alex
