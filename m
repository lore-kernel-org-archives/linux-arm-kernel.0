From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 23:37:35 +0530
Subject: [PATCH 08/16] ARM: bL_platsmp.c: make sure the GIC interface
 of a dying CPU is disabled
In-Reply-To: <1357777251-13541-9-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-9-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <50F054E7.9000004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> Otherwise there might be some interrupts or IPIs becoming pending and the
> CPU will not enter low power mode when doing a WFI.  The effect of this
> is a CPU that loops back into the kernel, go through the first man
> election, signals itself as alive,  and prevent the cluster from being
> shut down.
>
> This could benefit from a better solution.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>   arch/arm/common/bL_platsmp.c        | 1 +
>   arch/arm/common/gic.c               | 6 ++++++
>   arch/arm/include/asm/hardware/gic.h | 2 ++
>   3 files changed, 9 insertions(+)
>
> diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
> index 0ae44123bf..6a3b251b97 100644
> --- a/arch/arm/common/bL_platsmp.c
> +++ b/arch/arm/common/bL_platsmp.c
> @@ -68,6 +68,7 @@ static void __ref bL_cpu_die(unsigned int cpu)
>   	pcpu = mpidr & 0xff;
>   	pcluster = (mpidr >> 8) & 0xff;
>   	bL_set_entry_vector(pcpu, pcluster, NULL);
> +	gic_cpu_if_down();

So for a case where CPU still don't power down for some reason even
after CPU interface is disabled, can not listen to and SGI or PPI.
Not sure if this happens on big.LITTLE but i have seen one such issue
on Cortex-A9 based SOC.

Regards
Santosh
