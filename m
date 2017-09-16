From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 16 Sep 2017 19:14:11 +0100
Subject: [PATCH] irqchip/gicv3: Add support for Range Selector (RS) feature
In-Reply-To: <1505488136-26335-1-git-send-email-shankerd@codeaurora.org>
 (Shanker Donthineni's message of "Fri, 15 Sep 2017 10:08:56 -0500")
References: <1505488136-26335-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <86h8w2pl3g.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 15 2017 at 10:08:56 am BST, Shanker Donthineni <shankerd@codeaurora.org> wrote:

Hi Shanker,

> A new feature Range Selector (RS) has been added to GIC specification
> in order to support more than 16 CPUs at affinity level 0. New fields
> are introduced in SGI system registers (ICC_SGI0R_EL1, ICC_SGI1R_EL1
> and ICC_ASGI1R_EL1) to relax an artificial limit of 16 at level 0.
>
> - A new RSS field in ICC_CTLR_EL3, ICC_CTLR_EL1 and ICV_CTLR_EL1:
>   [18] - Range Selector Support (RSS)
>   0b0 = Targeted SGIs with affinity level 0 values of 0-15 are supported.
>   0b1 = Targeted SGIs with affinity level 0 values of 0-255 are supported.
>
> - A new RS field in ICC_SGI0R_EL1, ICC_SGI1R_EL1 and ICC_ASGI1R_EL1:
>   [47:44] - RangeSelector (RS) which group of 16 TargetList[n] field
>             TargetList[n] represents aff0 value ((RS*16)+n)
>             When ICC_CTLR_EL3.RSS==0 or ICC_CTLR_EL1.RSS==0, RS is RES0.
>
> - A new RSS field in GICD_TYPER:
>   [26] - Range Selector Support (RSS)
>   0b0 = Targeted SGIs with affinity level 0 values of 0-15 are supported.
>   0b1 = Targeted SGIs with affinity level 0 values of 0-255 are supported.
>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  drivers/irqchip/irq-gic-v3.c       | 79 ++++++++++++++++++++------------------
>  include/linux/irqchip/arm-gic-v3.h |  4 ++
>  2 files changed, 46 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 984c3ec..ba98c94 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -56,6 +56,7 @@ struct gic_chip_data {
>  	u64			redist_stride;
>  	u32			nr_redist_regions;
>  	unsigned int		irq_nr;
> +	bool			has_rss;
>  	struct partition_desc	*ppi_descs[16];
>  };
>  
> @@ -483,6 +484,9 @@ static int gic_populate_rdist(void)
>  
>  static void gic_cpu_sys_reg_init(void)
>  {
> +	int cpu = smp_processor_id();
> +	bool rss;
> +
>  	/*
>  	 * Need to check that the SRE bit has actually been set. If
>  	 * not, it means that SRE is disabled at EL2. We're going to
> @@ -514,6 +518,15 @@ static void gic_cpu_sys_reg_init(void)
>  
>  	/* ... and let's hit the road... */
>  	gic_write_grpen1(1);
> +
> +	/* GIC CPU interface has RSS capability? */
> +	rss = !!(read_sysreg_s(SYS_ICC_CTLR_EL1) & ICC_CTLR_EL1_RSS);
> +
> +	if (gic_data.has_rss != rss)
> +		pr_info("Broken hardware, mismatch RSS, SGIs may not work\n");

I disagree with this statement. The architecture allows for a non-RSS
GIC to be matched with RSS-aware CPUs, and vice-versa. This doesn't mean
the system is broken.

> +	else if ((cpu_logical_map(cpu) & 0xf0) && (!rss))
> +		pr_crit("MPIDR bits[7..4] must be zero, cpu=%d\n", cpu);

That's the real "Gotcha". Finding an MPIDR_EL1.Aff0 >= 16 on any CPU if
any of the CPUs or the distributor doesn't support RSS is an integration
blunder. Anything else is perfectly acceptable.

Unfortunately, this is not something you can decide by looking at a
single CPU, so you'll need to accumulate some state somehow.

> +
>  }
>  
>  static int gic_dist_supports_lpis(void)
> @@ -554,43 +567,13 @@ static int gic_starting_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
> -				   unsigned long cluster_id)
> -{
> -	int next_cpu, cpu = *base_cpu;
> -	unsigned long mpidr = cpu_logical_map(cpu);
> -	u16 tlist = 0;
> -
> -	while (cpu < nr_cpu_ids) {
> -		/*
> -		 * If we ever get a cluster of more than 16 CPUs, just
> -		 * scream and skip that CPU.
> -		 */
> -		if (WARN_ON((mpidr & 0xff) >= 16))
> -			goto out;
> -
> -		tlist |= 1 << (mpidr & 0xf);
> -
> -		next_cpu = cpumask_next(cpu, mask);
> -		if (next_cpu >= nr_cpu_ids)
> -			goto out;
> -		cpu = next_cpu;
> -
> -		mpidr = cpu_logical_map(cpu);
> -
> -		if (cluster_id != (mpidr & ~0xffUL)) {
> -			cpu--;
> -			goto out;
> -		}
> -	}
> -out:
> -	*base_cpu = cpu;
> -	return tlist;
> -}
> -
>  #define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
>  	(MPIDR_AFFINITY_LEVEL(cluster_id, level) \
>  		<< ICC_SGI1R_AFFINITY_## level ##_SHIFT)
> +#define MPIDR_RS(mpidr)			(((mpidr) & 0xF0) >> 4)
> +#define MPIDR_TO_SGI_TARGETLIST(mpidr)	(1 << ((mpidr) & 0xF))
> +#define MPIDR_TO_SGI_CLUSTER_ID(mpidr)	(mpidr & ~0xF)
> +#define MPIDR_TO_SGI_RS(mpidr)		(MPIDR_RS(mpidr) << ICC_SGI1R_RS_SHIFT)
>  
>  static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
>  {
> @@ -600,6 +583,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
>  	       MPIDR_TO_SGI_AFFINITY(cluster_id, 2)	|
>  	       irq << ICC_SGI1R_SGI_ID_SHIFT		|
>  	       MPIDR_TO_SGI_AFFINITY(cluster_id, 1)	|
> +	       MPIDR_TO_SGI_RS(cluster_id)		|
>  	       tlist << ICC_SGI1R_TARGET_LIST_SHIFT);
>  
>  	pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
> @@ -620,10 +604,27 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	smp_wmb();
>  
>  	for_each_cpu(cpu, mask) {
> -		unsigned long cluster_id = cpu_logical_map(cpu) & ~0xffUL;
> -		u16 tlist;
> +		u64 mpidr = cpu_logical_map(cpu);
> +		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(mpidr);
> +		u16 tlist = 0;
> +		int next_cpu;
> +
> +		if (WARN_ON((!gic_data.has_rss) && MPIDR_RS(mpidr)))
> +			continue;
> +
> +		/* Prepare TARGETLIST which have the same cluster_id */
> +		do {
> +			tlist |= MPIDR_TO_SGI_TARGETLIST(mpidr);
> +			next_cpu = cpumask_next(cpu, mask);
> +			if (next_cpu >= nr_cpu_ids)
> +				break;
> +
> +			mpidr = cpu_logical_map(next_cpu);
> +			if (cluster_id != MPIDR_TO_SGI_CLUSTER_ID(mpidr))
> +				break;
> +			cpu = next_cpu;
> +		} while (true);

I really dislike this. Why can't you just adapt the function we already
have instead of making the patch pointlessly hard to review? How about
something like this (completely untested and probably buggy, but you'll
get the idea):

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c4bec908ccea..d0539155ebae 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -603,13 +603,6 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 	u16 tlist = 0;
 
 	while (cpu < nr_cpu_ids) {
-		/*
-		 * If we ever get a cluster of more than 16 CPUs, just
-		 * scream and skip that CPU.
-		 */
-		if (WARN_ON((mpidr & 0xff) >= 16))
-			goto out;
-
 		tlist |= 1 << (mpidr & 0xf);
 
 		next_cpu = cpumask_next(cpu, mask);
@@ -633,7 +626,7 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 	(MPIDR_AFFINITY_LEVEL(cluster_id, level) \
 		<< ICC_SGI1R_AFFINITY_## level ##_SHIFT)
 
-static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
+static void gic_send_sgi(u64 cluster_id, u64 rs, u16 tlist, unsigned int irq)
 {
 	u64 val;
 
@@ -641,6 +634,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	       MPIDR_TO_SGI_AFFINITY(cluster_id, 2)	|
 	       irq << ICC_SGI1R_SGI_ID_SHIFT		|
 	       MPIDR_TO_SGI_AFFINITY(cluster_id, 1)	|
+	       rs << ICC_SGI1R_RS_SHIFT		|
 	       tlist << ICC_SGI1R_TARGET_LIST_SHIFT);
 
 	pr_debug("CPU%d: ICC_SGI1R_EL1 %llx\n", smp_processor_id(), val);
@@ -662,10 +656,11 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 	for_each_cpu(cpu, mask) {
 		unsigned long cluster_id = cpu_logical_map(cpu) & ~0xffUL;
+		u64 rs = (cpu_logical_map(cpu) >> 4) & 0xfUL;
 		u16 tlist;
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
-		gic_send_sgi(cluster_id, tlist, irq);
+		gic_send_sgi(cluster_id, rs, tlist, irq);
 	}
 
 	/* Force the above writes to ICC_SGI1R_EL1 to be executed */

It'd definitely look much better and would be easier to review.

>  
> -		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
>  		gic_send_sgi(cluster_id, tlist, irq);
>  	}
>  
> @@ -959,6 +960,10 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  		goto out_free;
>  	}
>  
> +	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
> +	pr_info("Distributor has %s Range Selector support\n",
> +		gic_data.has_rss ? "" : "no");
> +
>  	set_handle_irq(gic_handle_irq);
>  
>  	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index 6a1f87f..eb9ff9b 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -68,6 +68,7 @@
>  #define GICD_CTLR_ENABLE_SS_G1		(1U << 1)
>  #define GICD_CTLR_ENABLE_SS_G0		(1U << 0)
>  
> +#define GICD_TYPER_RSS			(1U << 26)
>  #define GICD_TYPER_LPIS			(1U << 17)
>  #define GICD_TYPER_MBIS			(1U << 16)
>  
> @@ -377,6 +378,7 @@
>  #define ICC_CTLR_EL1_SEIS_MASK		(0x1 << ICC_CTLR_EL1_SEIS_SHIFT)
>  #define ICC_CTLR_EL1_A3V_SHIFT		15
>  #define ICC_CTLR_EL1_A3V_MASK		(0x1 << ICC_CTLR_EL1_A3V_SHIFT)
> +#define ICC_CTLR_EL1_RSS		(0x1 << 18)
>  #define ICC_PMR_EL1_SHIFT		0
>  #define ICC_PMR_EL1_MASK		(0xff << ICC_PMR_EL1_SHIFT)
>  #define ICC_BPR0_EL1_SHIFT		0
> @@ -465,6 +467,8 @@
>  #define ICC_SGI1R_AFFINITY_2_SHIFT	32
>  #define ICC_SGI1R_AFFINITY_2_MASK	(0xffULL << ICC_SGI1R_AFFINITY_2_SHIFT)
>  #define ICC_SGI1R_IRQ_ROUTING_MODE_BIT	40
> +#define ICC_SGI1R_RS_SHIFT		44
> +#define ICC_SGI1R_RS_MASK		(0xfULL << ICC_SGI1R_RS_SHIFT)
>  #define ICC_SGI1R_AFFINITY_3_SHIFT	48
>  #define ICC_SGI1R_AFFINITY_3_MASK	(0xffULL << ICC_SGI1R_AFFINITY_3_SHIFT)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
