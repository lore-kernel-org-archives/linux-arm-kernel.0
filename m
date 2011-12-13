From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Dec 2011 23:01:30 -0500 (EST)
Subject: arm and patch phys offset
In-Reply-To: <201112130108.25337.michael@walle.cc>
References: <201112112255.32534.michael@walle.cc>
 <20111212222157.GG20178@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112121746330.2907@xanadu.home>
 <201112130108.25337.michael@walle.cc>
Message-ID: <alpine.LFD.2.02.1112122256580.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Dec 2011, Michael Walle wrote:

> Am Montag 12 Dezember 2011, 23:56:38 schrieb Nicolas Pitre:
> > I just compiled vanilla v3.2-rc5 using kirkwood_defconfig and
> > successfully booted it on a SheevaPlug and a DB-88F6281-BP development
> > board.  And I do have CONFIG_ARM_PATCH_PHYS_VIRT=y.  Both platforms are
> > using u-Boot which booted the default uImage produced by the kernel
> > build system.
> > 
> > So at this point I wouldn't think the issue is Kirkwood related as I
> > can't reproduce it on two different Kirkwood targets.
> 
> Seems like the l2 cache is enabled after uboot starts the linux kernel. I'll 
> dig deeper into that tomorrow.
> 
> For now, i appended
>   l2_cache_disable();
> to uboots cleanup_before_linux() and all stubs seems to be patched correctly.

Strange.  Having l2 enabled shouldn't cause such trouble.

> void l2_cache_disable(void)
> {
> 	struct kwcpu_registers *cpureg =
> 		(struct kwcpu_registers *)KW_CPU_REG_BASE;
> 	writel(readl(&cpureg->l2_cfg) & ~0x18, &cpureg->l2_cfg);
> }
> 
> l2_cfg is 0xf1020128.
> 
> But i don't know if that is correct way of disabling the cache.

I don't remember the details, but I wouldn't think it is that simple.  
The Kirkwood manual would tell you.  It is publicly available.

> Nico, what uboot are you using for your SheeavaPlug? Vanilla uboot?

No, it's whatever u-Boot that shipped with it.  It says:

U-Boot 1.1.4 (Jan 20 2009 - 12:05:46) Marvell version: 3.4.11


Nicolas
