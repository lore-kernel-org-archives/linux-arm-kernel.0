From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Nov 2016 14:24:43 +0100
Subject: [PATCH 2/2] ARM: rename is_smp()
In-Reply-To: <E1c6GpW-0008DO-BD@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Mon, 14 Nov 2016 12:57:46 +0000")
References: <E1c6GpW-0008DO-BD@rmk-PC.armlinux.org.uk>
Message-ID: <878tsmchyc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On lun., nov. 14 2016, Russell King <rmk+kernel@armlinux.org.uk> wrote:

> is_smp() is causing some confusion - rename it to indicate that it's a
> property of the CPU that we're running on, which is not the same as the
> system.  Document what and why it is being used at most sites.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Some people are reporting that "is_smp()" is broken wrt Cortex-A15 CPUs
> when they integrate a single Cortex-A15 SMP capable CPU into a
> uniprocessor system.  This is most likely because of a misunderstanding
> about what is_smp() is really detected from: it's detected from the CPU
> capabilities, not from the system capabilities.  If the CPU says that it
> is SMP capable (and it's not a broken Cortex-A9 core) we will make use
> of various instructions which appear on SMP cores, and we set is_smp()
> to follow that.  So, is_smp() is more of a CPU capability rather than a
> system capability.
>
> Trying to use it as a system capability will lead to problems.
> Arguably, the use of it in arch_irq_work_has_interrupt() is wrong,
> because we don't know whether the GIC is SMP capable or not, but it's
> currently the best we can do.
>
> I felt the other two sites I left undocumented (which read the MPIDR)
> were rather obvious - a uniprocessor only capable CPU doesn't have a
> MPIDR.
>
> Really, !cpu_smp() is an indication that the CPU is UP-only, not that
> it is _S_MP capable, so even this is lightly misleading.  I suppose
> we could replace it with cpu_up_only() but I think that makes the code
> harder to understand (due to double-negatives appearing in places.)
>
>  arch/arm/include/asm/cputype.h  |  2 +-
>  arch/arm/include/asm/irq_work.h |  2 +-
>  arch/arm/include/asm/smp_plat.h | 11 +++++++----
>  arch/arm/kernel/devtree.c       |  2 +-
>  arch/arm/kernel/module.c        | 10 +++++++++-
>  arch/arm/kernel/setup.c         |  7 ++++---
>  arch/arm/mach-mvebu/coherency.c |  4 ++--
>  arch/arm/mm/mmu.c               | 13 ++++++++++++-
>  8 files changed, 37 insertions(+), 14 deletions(-)

[...]

> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index ae2a018b9305..fe4b1e15ebb8 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -216,7 +216,7 @@ static int coherency_type(void)
>  	 *
>  	 * Note that this means that on Armada 370, there is currently
>  	 * no way to use hardware I/O coherency, because even when
> -	 * CONFIG_SMP is enabled, is_smp() returns false due to the
> +	 * CONFIG_SMP is enabled, cpu_smp() returns false due to the
>  	 * Armada 370 being a single-core processor. To lift this
>  	 * limitation, we would have to find a way to make the cache
>  	 * policy set to write-allocate (on all Armada SoCs), and to
> @@ -226,7 +226,7 @@ static int coherency_type(void)
>  	 * where we don't know yet on which SoC we are running.
>  
>  	 */
> -	if (!is_smp())
> +	if (!cpu_smp())
>  		return COHERENCY_FABRIC_TYPE_NONE;
>  
>  	np = of_find_matching_node_and_match(NULL, of_coherency_table, &match);

Unless I am wrong I don't see any modification of the code behavior:
just renaming the function and adding more comments. So it won't affect
our platform and I am OK with the new name which also match our
comments.

So, for this chunk:

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4001dd15818d..d3dc758d5391 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -449,11 +449,22 @@ static void __init build_mem_type_table(void)
>  		ecc_mask = 0;
>  	}
>  
> -	if (is_smp()) {
> +	if (cpu_smp()) {
> +		/*
> +		 * SMP requires a write-allocate cache policy for proper
> +		 * functioning of the coherency protocol.  If the CPU supports
> +		 * MP extensions, assume we are part of a SMP system.
> +		 */
>  		if (cachepolicy != CPOLICY_WRITEALLOC) {
>  			pr_warn("Forcing write-allocate cache policy for SMP\n");
>  			cachepolicy = CPOLICY_WRITEALLOC;
>  		}
> +
> +		/*
> +		 * SMP systems depend on the S bit being shared for coherency
> +		 * between the CPUs.  However, setting this for non-SMP CPUs
> +		 * may result in the mappings being treated as uncached.
> +		 */
>  		if (!(initial_pmd_value & PMD_SECT_S)) {
>  			pr_warn("Forcing shared mappings for SMP\n");
>  			initial_pmd_value |= PMD_SECT_S;
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
