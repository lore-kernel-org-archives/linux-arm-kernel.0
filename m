From: michael@walle.cc (Michael Walle)
Date: Tue, 13 Dec 2011 01:08:25 +0100
Subject: arm and patch phys offset
In-Reply-To: <alpine.LFD.2.02.1112121746330.2907@xanadu.home>
References: <201112112255.32534.michael@walle.cc>
 <20111212222157.GG20178@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112121746330.2907@xanadu.home>
Message-ID: <201112130108.25337.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag 12 Dezember 2011, 23:56:38 schrieb Nicolas Pitre:
> I just compiled vanilla v3.2-rc5 using kirkwood_defconfig and
> successfully booted it on a SheevaPlug and a DB-88F6281-BP development
> board.  And I do have CONFIG_ARM_PATCH_PHYS_VIRT=y.  Both platforms are
> using u-Boot which booted the default uImage produced by the kernel
> build system.
> 
> So at this point I wouldn't think the issue is Kirkwood related as I
> can't reproduce it on two different Kirkwood targets.

Seems like the l2 cache is enabled after uboot starts the linux kernel. I'll 
dig deeper into that tomorrow.

For now, i appended
  l2_cache_disable();
to uboots cleanup_before_linux() and all stubs seems to be patched correctly.

void l2_cache_disable(void)
{
	struct kwcpu_registers *cpureg =
		(struct kwcpu_registers *)KW_CPU_REG_BASE;
	writel(readl(&cpureg->l2_cfg) & ~0x18, &cpureg->l2_cfg);
}

l2_cfg is 0xf1020128.

But i don't know if that is correct way of disabling the cache.

Nico, what uboot are you using for your SheeavaPlug? Vanilla uboot?

-- 
michael
