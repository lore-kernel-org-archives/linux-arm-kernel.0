From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Apr 2018 19:15:37 +0100
Subject: [PATCH v3 5/6] Initialize the mapping of KASan shadow memory
In-Reply-To: <nycvar.YSQ.7.76.1804021402521.28462@knanqh.ubzr>
References: <20180402120440.31900-1-liuwenliang@huawei.com>
 <20180402120440.31900-6-liuwenliang@huawei.com>
 <nycvar.YSQ.7.76.1804021402521.28462@knanqh.ubzr>
Message-ID: <20180402181536.GJ16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2018 at 02:08:13PM -0400, Nicolas Pitre wrote:
> On Mon, 2 Apr 2018, Abbott Liu wrote:
> 
> > index c79b829..20161e2 100644
> > --- a/arch/arm/kernel/head-common.S
> > +++ b/arch/arm/kernel/head-common.S
> > @@ -115,6 +115,9 @@ __mmap_switched:
> >  	str	r8, [r2]			@ Save atags pointer
> >  	cmp	r3, #0
> >  	strne	r10, [r3]			@ Save control register values
> > +#ifdef CONFIG_KASAN
> > +	bl	kasan_early_init
> > +#endif
> >  	mov	lr, #0
> >  	b	start_kernel
> >  ENDPROC(__mmap_switched)
> 
> Would be better if lr was cleared before calling kasan_early_init.

No.  The code is correct - please remember that "bl" writes to LR.

The point of clearing LR here is to ensure that start_kernel is called
with a zero link register, which it won't be if kasan_early_init is
moved after it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
