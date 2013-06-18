From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 18 Jun 2013 14:26:42 +0100
Subject: [PATCH] arm: versatile: don't mark pen as __INIT
In-Reply-To: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
References: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1371562002.5375.27.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-06-10 at 16:07 +0100, Mark Rutland wrote:
> When booting fewer cores than are physically present on a versatile
> platform (e.g. when passing maxcpus=N on the command line), some
> secondary cores may remain in the holding pen, which is marked __INIT.
> Late in the boot process, the memory comprising the holding pen will be
> released to the kernel for more general use, and may be overwritten with
> arbitrary data, which can cause the held secondaries to start behaving
> unpredictably. This can lead to all manner of odd behaviour from the
> kernel.
> 
> Instead don't mark the section as __INIT. This means we can't reuse the
> pen memory, but we won't get secondaries corrupting the rest of the
> kernel.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Pawel Moll <pawel.moll@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---

This gives section mismatch warnings when compiling with
vexpress_defconfig:

        WARNING: vmlinux.o(.text+0x14128): Section mismatch in reference from the variable pen to the function .cpuinit.text:secondary_startup()
        The function pen() references
        the function __cpuinit secondary_startup().
        This is often because pen lacks a __cpuinit 
        annotation or the annotation of secondary_startup is wrong.
        
        WARNING: vmlinux.o(.text+0x14130): Section mismatch in reference from the variable pen to the variable .cpuinit.data:pen_release
        The function pen() references
        the variable __cpuinitdata pen_release.
        This is often because pen lacks a __cpuinitdata 
        annotation or the annotation of pen_release is wrong.

wonder if this is opening up a small can of worms...?


>  arch/arm/plat-versatile/headsmp.S | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
> index b178d44..2677bc3 100644
> --- a/arch/arm/plat-versatile/headsmp.S
> +++ b/arch/arm/plat-versatile/headsmp.S
> @@ -11,8 +11,6 @@
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>  
> -	__INIT
> -
>  /*
>   * Realview/Versatile Express specific entry point for secondary CPUs.
>   * This provides a "holding pen" into which all secondary cores are held

-- 
Tixy
