From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 29 Oct 2012 08:00:29 +0000
Subject: [PATCH v4 3/5] zynq: remove use of CLKDEV_LOOKUP
In-Reply-To: <079dc4cc1d0abd19cef111045ba305c474eb0e4c.1351466765.git.josh.cartwright@ni.com>
References: <cover.1351466765.git.josh.cartwright@ni.com>
 <079dc4cc1d0abd19cef111045ba305c474eb0e4c.1351466765.git.josh.cartwright@ni.com>
Message-ID: <0d24b66c-f001-4b67-89c0-abd3cd06c03a@VA3EHSMHS004.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Sunday, October 21, 2012 6:17 PM
> To: arm at kernel.org; Arnd Bergmann
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; John
> Linn; Nick Bowler; Michal Simek
> Subject: [PATCH v4 3/5] zynq: remove use of CLKDEV_LOOKUP
> 
> The Zynq support in mainline does not (yet) make use of any of the generic clk
> or clk lookup functionality.  Remove what is upstream for now, until the out-of-
> tree implementation is in suitable form for merging.
> 
> An important side effect of this patch is that it allows the building of a Zynq
> kernel without running into unresolved symbol problems:
> 
>    drivers/built-in.o: In function `amba_get_enable_pclk':
>    clkdev.c:(.text+0x444): undefined reference to `clk_enable'
>    drivers/built-in.o: In function `amba_remove':
>    clkdev.c:(.text+0x488): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `amba_probe':
>    clkdev.c:(.text+0x540): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `amba_device_add':
>    clkdev.c:(.text+0x77c): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `enable_clock':
>    clkdev.c:(.text+0x29738): undefined reference to `clk_enable'
>    drivers/built-in.o: In function `disable_clock':
>    clkdev.c:(.text+0x29778): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `__pm_clk_remove':
>    clkdev.c:(.text+0x297f8): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `pm_clk_suspend':
>    clkdev.c:(.text+0x29bc8): undefined reference to `clk_disable'
>    drivers/built-in.o: In function `pm_clk_resume':
>    clkdev.c:(.text+0x29c28): undefined reference to `clk_enable'
>    make[2]: *** [vmlinux] Error 1
>    make[1]: *** [sub-make] Error 2
>    make: *** [all] Error 2
> 
> In addition, eliminate Zynq's "use" of the versatile platform, as it is no longer
> needed.  As Nick Bowler points out:
> 
> 	For the record, I think this was introduced by commit 56a34b03ff427
> 	("ARM: versatile: Make plat-versatile clock optional") which forgot to
> 	select PLAT_VERSATILE_CLOCK on Zynq.  This is not all that surprising,
> 	because the fact that Zynq "uses" PLAT_VERSATILE is secretly hidden in
> 	the Makefile.
> 
> 	Nevertheless, the only feature from versatile that Zynq needed was the
> 	clock support, so this patch should *also* delete the secret use of
> 	plat-versatile by removing this line from arch/arm/Makefile:
> 
> 	  plat-$(CONFIG_ARCH_ZYNQ)      += versatile
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: John Linn <john.linn@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  arch/arm/Kconfig                         |  1 -
>  arch/arm/Makefile                        |  1 -
>  arch/arm/mach-zynq/common.c              |  1 -
>  arch/arm/mach-zynq/include/mach/clkdev.h | 32 --------------------------------
>  4 files changed, 35 deletions(-)
>  delete mode 100644 arch/arm/mach-zynq/include/mach/clkdev.h
> 

Applied to http://git.xilinx.com/?p=linux-xlnx.git;a=shortlog;h=refs/heads/arm-next

Thanks,
Michal
