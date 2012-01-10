From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 10 Jan 2012 12:04:02 +0000
Subject: [PATCH 3/6] ARM: vexpress: remove incorrect BSYM usage
In-Reply-To: <1326149146-19756-4-git-send-email-robherring2@gmail.com>
References: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
 <1326149146-19756-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120110120402.GB2336@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 04:45:43PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> BSYM macro is only needed for assembly files and its usage in c files is
> wrong, so remove it. The linker will correctly set bit 0 for Thumb2
> kernels.

Pawel posted a patch to do this for realview and vexpress:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/077014.html

I don't know whether this is currently headed for merge.  Without the
ENDPROC additions in plat-versatile/platsmp.S, taking the BSYM away
causes breakage.  (The missing ENDPROC is the true bug here.)


The changes look sensible, but break realview and vexpress as-is.
I suggest you coordinate with Pawel and either add the ENDPROC stuff
into your series, or drop those patches (but then you'll have to wait
to merge your series, otherwise the removal of the BSYM() macro for
C code will cause the realview/vexpress code to break).

If you've not already done so, double-check that the target function is
either C or properly-annotated assembler in each case.  However, so far
as I can see, all the cases are correct, except for realview and
vexpress.


After all these changes, BSYM will only be used in:

boot/compressed/head.S
include/asm/entry-macro-multi.S
include/asm/unified.h
kernel/entry-armv.S
kernel/entry-common.S
kernel/head-nommu.S
kernel/head.S
kernel/sleep.S
lib/call_with_stack.S

... so providing it only for assembler ought to be OK.

Cheers
---Dave

> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/mach-vexpress/platsmp.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index 2b5f7ac..124ffb1 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -13,8 +13,6 @@
>  #include <linux/smp.h>
>  #include <linux/io.h>
>  
> -#include <asm/unified.h>
> -
>  #include <mach/motherboard.h>
>  #define V2M_PA_CS7 0x10000000
>  
> @@ -46,6 +44,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
>  	 * secondary CPU branches to this address.
>  	 */
>  	writel(~0, MMIO_P2V(V2M_SYS_FLAGSCLR));
> -	writel(BSYM(virt_to_phys(versatile_secondary_startup)),
> +	writel(virt_to_phys(versatile_secondary_startup),
>  		MMIO_P2V(V2M_SYS_FLAGSSET));
>  }
> -- 
> 1.7.5.4
> 
