From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Oct 2017 22:41:31 +0100
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <b53b3281-5eef-7cbd-c7d3-5417d764667b@gmail.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <b53b3281-5eef-7cbd-c7d3-5417d764667b@gmail.com>
Message-ID: <20171011214131.GV20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 12:39:39PM -0700, Florian Fainelli wrote:
> On 10/11/2017 01:22 AM, Abbott Liu wrote:
> > diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> > index 8733012..c17f4a2 100644
> > --- a/arch/arm/kernel/head-common.S
> > +++ b/arch/arm/kernel/head-common.S
> > @@ -101,7 +101,11 @@ __mmap_switched:
> >  	str	r2, [r6]			@ Save atags pointer
> >  	cmp	r7, #0
> >  	strne	r0, [r7]			@ Save control register values
> > +#ifdef CONFIG_KASAN
> > +	b	kasan_early_init
> > +#else
> >  	b	start_kernel
> > +#endif
> 
> Please don't make this "exclusive" just conditionally call
> kasan_early_init(), remove the call to start_kernel from
> kasan_early_init and keep the call to start_kernel here.

iow:

#ifdef CONFIG_KASAN
	bl	kasan_early_init
#endif
	b	start_kernel

This has the advantage that we don't leave any stack frame from
kasan_early_init() on the init task stack.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
