From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 3 Jul 2013 17:04:57 +0100
Subject: [Xen-devel] [PATCH RFC] xen/arm: domain kernel: Small fixes for
 making suspendable for arm
In-Reply-To: <alpine.DEB.2.02.1307031440350.5067@kaball.uk.xensource.com>
References: <1372842988-27547-1-git-send-email-jaeyong.yoo@samsung.com>
 <alpine.DEB.2.02.1307031440350.5067@kaball.uk.xensource.com>
Message-ID: <1372867497.27768.282.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-03 at 16:59 +0100, Stefano Stabellini wrote:

> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 2c3bdce..77309f7 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1469,6 +1469,9 @@ config ARCH_NO_VIRT_TO_BUS
> >  config ISA_DMA_API
> >  	bool
> >  
> > +config ARCH_HIBERNATION_POSSIBLE
> > +        def_bool y
> > +
> 
> This could be an issue because if you introduce this symbol you allow
> users to compile hibernation code on all arm platforms.
> At the very least it should have "depends on XEN".
> 
[...]
> > +void save_processor_state(void)
> > +{
> > +	printk(KERN_ERR"%s: function not implemented\n", __func__);
> > +}
> > +
> > +void restore_processor_state(void)
> > +{
> > +	printk(KERN_ERR"%s: function not implemented\n", __func__);
> > +}
> > +
> > +int swsusp_arch_suspend(void)
> > +{
> > +	printk(KERN_ERR"%s: function not implemented\n", __func__);
> > +	return 0;
> > +}
> > +
> > +int swsusp_arch_resume(void)
> > +{
> > +	printk(KERN_ERR"%s: function not implemented\n", __func__);
> > +	return 0;
> > +}
> > +
> > +int pfn_is_nosave(unsigned long pfn)
> > +{
> > +	printk(KERN_ERR"%s: function not implemented\n", __func__);
> > +	return 0;
> > +}
> 
> These functions are not Xen specific, they should not be under
> arch/arm/xen.
> Maybe we could put them under arch/arm/power or drivers/xen?

Together with the spurious config symbol this suggests that perhaps the
hibernation interface is not the right one to be using for Xen on ARM.

How does this work on native ARM I wonder?

Ian.
