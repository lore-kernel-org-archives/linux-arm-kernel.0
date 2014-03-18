From: mporter@linaro.org (Matt Porter)
Date: Tue, 18 Mar 2014 16:15:37 -0400
Subject: [V2] arm: pj4: check cpu id for pj4 cp0 access
In-Reply-To: <1371200637-20850-1-git-send-email-chao.xie@marvell.com>
References: <1371200637-20850-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20140318201537.GA20942@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:03:57AM -0400, Chao Xie wrote:
> Check cpu id in pj4_cp0_init. So for no-PJ4 V7 cpus,
> pj4_cpu0_init just return.
> This fix will help to make the all the V7 cpus(pj4 and no-PJ4)
> use same platform code.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

This patch fixes a boot failure in next now that ARCH_DOVE (and thus
CPU_PJ4) are enabled in multi_v7_defconfig. I verified that boot works
again in next with the BCM28155-AP board.

Tested-by: Matt Porter <mporter@linaro.org>

> arch/arm/kernel/pj4-cp0.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
> index 679cf4d..bf658d3 100644
> --- a/arch/arm/kernel/pj4-cp0.c
> +++ b/arch/arm/kernel/pj4-cp0.c
> @@ -17,6 +17,10 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <asm/thread_notify.h>
> +#include <asm/cputype.h>
> +
> +#define CORE_PJ4_MASK	0xfffffff0
> +#define CORE_PJ4_ID	0x562f5840
>  
>  static int iwmmxt_do(struct notifier_block *self, unsigned long cmd, void *t)
>  {
> @@ -79,6 +83,13 @@ static void __init pj4_cp_access_write(u32 value)
>  static int __init pj4_cp0_init(void)
>  {
>  	u32 cp_access;
> +	unsigned int cpuid;
> +
> +	cpuid = read_cpuid_id();
> +
> +	/* If it is not a pj4 core, skip it. */
> +	if ((cpuid & CORE_PJ4_MASK) != CORE_PJ4_ID)
> +		return 0;
>  
>  	cp_access = pj4_cp_access_read() & ~0xf;
>  	pj4_cp_access_write(cp_access);
