From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 28 Nov 2016 20:13:49 -0600
Subject: [PATCH v2] irqchip/gicv3-its: Enable cacheable attribute
 Read-allocate hints
In-Reply-To: <1478589498-17696-1-git-send-email-shankerd@codeaurora.org>
References: <1478589498-17696-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <fcb413c6-1369-3481-11bf-4934cbb7f1d6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Please comment on this patch. I'm seeing ~1000 cpu cycles interrupt 
latency improvement on Qualcomm server platforms if the ITS tables are 
not in L1/L2/L3 cache. You can find the test code at 
https://patchwork.kernel.org/patch/9416793 which I used to validate my 
code changes.

Thanks,
Shanker

On 11/08/2016 01:18 AM, Shanker Donthineni wrote:
> Read-allocation hints are not enabled for both the GIC-ITS and GICR
> tables. This forces the hardware to always read the table contents
> from an external memory (DDR) which is slow compared to cache memory.
> Most of the tables are often read by hardware. So, it's better to
> enable Read-allocate hints in addition to Write-allocate hints in
> order to improve the GICR_PEND, GICR_PROP, Collection, Device, and
> vCPU tables lookup time.
>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> Implemented a test case to prove that enabling Read Allocation hints
> improves ITS lookup time ~15% while delivering a LPI event. Used the
> ITS command INV to analyze time spent in device, collection, prop and
> pending table lookups.
>    
> Pseudo code:
>      Create a fake ITS device.
>      Record PMU cycle counter before sending INV command.
>      Build and send ITS INT command.
>           ITS hardware triggers device table lookup.
>                ITTE table & collection table lookup.
>            ITS property table lookup.
>            ITS pending table lookup.
>            Deliver interrupt to CPU interface.
>      do_IRQ() called.
>      Measure the total CPU cycle spent to reach this point.
>
> Without ReadAllocation hints:
> /sys/kernel/debug # echo 100 > lpitest
> [   94.693968] CPU[1] niter=100 cycles=0x8dfc0 avg=0x16b7 min=0x1652
>
> With ReadAllocation hints:
> /sys/kernel/debug # echo 100 > lpitest
> [   98.617873] CPU[1] niter=100 cycles=0x7df49 avg=0x1427 min=0x1388
>
>   drivers/irqchip/irq-gic-v3-its.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> b/drivers/irqchip/irq-gic-v3-its.c
> index c5dee30..227a1eb 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -961,7 +961,7 @@ static bool its_parse_baser_device(struct its_node
> *its, struct its_baser *baser
>   				   u32 psz, u32 *order)
>   {
>   	u64 esz = GITS_BASER_ENTRY_SIZE(its_read_baser(its, baser));
> -	u64 val = GITS_BASER_InnerShareable | GITS_BASER_WaWb;
> +	u64 val = GITS_BASER_InnerShareable | GITS_BASER_RaWaWb;
>   	u32 ids = its->device_ids;
>   	u32 new_order = *order;
>   	bool indirect = false;
> @@ -1026,7 +1026,7 @@ static int its_alloc_tables(struct its_node *its)
>   	u64 typer = gic_read_typer(its->base + GITS_TYPER);
>   	u32 ids = GITS_TYPER_DEVBITS(typer);
>   	u64 shr = GITS_BASER_InnerShareable;
> -	u64 cache = GITS_BASER_WaWb;
> +	u64 cache = GITS_BASER_RaWaWb;
>   	u32 psz = SZ_64K;
>   	int err, i;
>   
> @@ -1123,7 +1123,7 @@ static void its_cpu_init_lpis(void)
>   	/* set PROPBASE */
>   	val = (page_to_phys(gic_rdists->prop_page) |
>   	       GICR_PROPBASER_InnerShareable |
> -	       GICR_PROPBASER_WaWb |
> +	       GICR_PROPBASER_RaWaWb |
>   	       ((LPI_NRBITS - 1) & GICR_PROPBASER_IDBITS_MASK));
>   
>   	writeq_relaxed(val, rbase + GICR_PROPBASER);
> @@ -1148,7 +1148,7 @@ static void its_cpu_init_lpis(void)
>   	/* set PENDBASE */
>   	val = (page_to_phys(pend_page) |
>   	       GICR_PENDBASER_InnerShareable |
> -	       GICR_PENDBASER_WaWb);
> +	       GICR_PENDBASER_RaWaWb);
>   
>   	writeq_relaxed(val, rbase + GICR_PENDBASER);
>   	tmp = readq_relaxed(rbase + GICR_PENDBASER);
> @@ -1712,7 +1712,7 @@ static int __init its_probe_one(struct resource
> *res,
>   		goto out_free_tables;
>   
>   	baser = (virt_to_phys(its->cmd_base)	|
> -		 GITS_CBASER_WaWb		|
> +		 GITS_CBASER_RaWaWb		|
>   		 GITS_CBASER_InnerShareable	|
>   		 (ITS_CMD_QUEUE_SZ / SZ_4K - 1)	|
>   		 GITS_CBASER_VALID);

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
