From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 17:08:36 +0200
Subject: [PATCH 08/37] ARM: mach-omap2: remove mach/memory.h
In-Reply-To: <1309923021-23487-8-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
	<1309923021-23487-8-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <201107071708.36668.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Nicolas Pitre wrote:
> -/*
> - * Physical DRAM offset.
> - */
> -#if defined(CONFIG_ARCH_OMAP1)
> -#error "OMAP1 should not be including this"
> -#else
> -#define PLAT_PHYS_OFFSET               UL(0x80000000)
> -#endif
> -
> -#endif

This breaks if you disable ARM_PATCH_PHYS_VIRT and don't know
enter the correct PHYS_OFFSET in Kconfig, right?

I wonder if it's worth adding defaults for CONFIG_PHYS_OFFSET
based on the platform, like

config PHYS_OFFSET
	depends on !ARM_PATCH_PHYS_VIRT && NO_MACH_MEMORY_H
	default 0x80000000 if ARCH_OMAP2 || ARCH_PNX4008 || ARCH_NETX || ARCH_LPC32XX
	default 0xa0000000 if ARCH_IOP32X
	default 0x10000000 if ARCH_GEMINI && !GEMINI_MEM_SWAP
	default 0x00000000

	Arnd
