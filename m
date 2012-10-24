From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 14:27:22 +0200
Subject: [PATCH 2/2] arm: mvebu: Add hardware I/O Coherency support
In-Reply-To: <1351065841-18654-3-git-send-email-gregory.clement@free-electrons.com>
References: <1351065841-18654-1-git-send-email-gregory.clement@free-electrons.com>
 <1351065841-18654-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121024142722.46c0f456@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 24 Oct 2012 10:04:01 +0200, Gregory CLEMENT wrote:
> Armada 370 and XP come with an unit called coherency fabric. This unit
> allows to use the Armada XP as a nearly coherent architecture. The

the Armada 370/XP

> coherency mechanism uses snoop filters to ensure the coherency between
> caches, DRAM and devices. This mechanism needs a synchronization
> barrier which guarantees that all memory write initiated by the

write -> writes

> devices has reached their target and do not reside in intermediate

has -> have

> write buffers. That's why the architecture is not totally coherent and
> we need to provide our own functions for some DMA operations.
> 
> Beside the use of the coherency fabric, the device units will have to
> set the attribute flag to select the accurate coherency process for

the attribute flag of what?

> the memory transaction. This is done each device driver programs the
> DRAM address windows. The value of the attribute set by the driver is
> retrieved through the orion_addr_map_cfg struct filled during the
> early initialization of the platform.


> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 18ba60b..af22e53 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -38,7 +38,8 @@
>  
>  	coherency-fabric at d0020200 {
>  		compatible = "marvell,coherency-fabric";
> -		reg = <0xd0020200 0xb0>;
> +		reg = <0xd0020200 0xb0>,
> +		      <0xd0021010 0x1c>;
>  	};

As others mentioned, documentation update needed.

>  
>  	soc {
> diff --git a/arch/arm/mach-mvebu/addr-map.c b/arch/arm/mach-mvebu/addr-map.c
> index fe454a4..595f6b7 100644
> --- a/arch/arm/mach-mvebu/addr-map.c
> +++ b/arch/arm/mach-mvebu/addr-map.c
> @@ -108,6 +108,9 @@ static int __init armada_setup_cpu_mbus(void)
>  
>  	addr_map_cfg.bridge_virt_base = mbus_unit_addr_decoding_base;
>  
> +	if (of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
> +		addr_map_cfg.hw_io_coherency = 1;
> +

I don't really like to have this of_find_compatible_node(NULL, NULL,
"marvell,coherency-fabric") test in two places, but I don't see a way
around it since armada_setup_cpu_mbus() is called as an initcall, so we
can't pass arguments to it.

> +struct dma_map_ops armada_xp_dma_ops;

static

> +static inline void armada_xp_sync_io_barrier(void)
> +{
> +	writel(0x1, coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET);
> +	while (readl(coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET) & 0x1);
> +}
> +
> +dma_addr_t armada_xp_dma_map_page(struct device *dev, struct page *page,
> +				  unsigned long offset, size_t size,
> +				  enum dma_data_direction dir,
> +				  struct dma_attrs *attrs)
> +{
> +	if (dir != DMA_TO_DEVICE)
> +		armada_xp_sync_io_barrier();
> +	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
> +}
> +
> +
> +void armada_xp_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +			      size_t size, enum dma_data_direction dir,
> +			      struct dma_attrs *attrs)
> +{
> +	if (dir != DMA_TO_DEVICE)
> +		armada_xp_sync_io_barrier();
> +}
> +
> +void armada_xp_dma_sync(struct device *dev, dma_addr_t dma_handle,
> +			size_t size, enum dma_data_direction dir)
> +{
> +	if (dir != DMA_TO_DEVICE)
> +		armada_xp_sync_io_barrier();
> +}

As others said, the prefix is wrong. Since the file is named coherency,
maybe just "coherency_" as the prefix? Not sure, though. Shouldn't the
file be named coherency-armada-370-xp.c, as we have done for the irq
controller file? In that case, the armada_370_xp prefix would make
sense.

>  int armada_xp_get_cpu_count(void)
>  {
>  	int reg, cnt;

static?

> @@ -74,6 +115,42 @@ int armada_370_xp_set_cpu_coherent(unsigned int hw_cpu_id, int smp_group_id)
>  	return 0;
>  }
>  
> +static int armada_xp_platform_notifier(struct notifier_block *nb,
> +				       unsigned long event, void *__dev)
> +{
> +	struct device *dev = __dev;
> +
> +	if (event != BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_DONE;
> +	set_dma_ops(dev, &armada_xp_dma_ops);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block armada_xp_platform_nb = {
> +	.notifier_call = armada_xp_platform_notifier,
> +};
> +
> +void __init armada_370_xp_coherency_iocache_init(void)
> +{
> +	/* When the coherency fabric is available, the Armada XP and
> +	 * Aramada 370 are close to a coherent architecture, so we based
> +	 * our dma ops on the coherent one, and just changes the
> +	 * operations which need a arch io sync */
> +	if (of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric")) {
> +		struct dma_map_ops *dma_ops = &armada_xp_dma_ops;
> +		memcpy(dma_ops, &arm_coherent_dma_ops, sizeof(*dma_ops));
> +		dma_ops->map_page = armada_xp_dma_map_page;
> +		dma_ops->unmap_page = armada_xp_dma_unmap_page;
> +		dma_ops->unmap_sg = arm_dma_ops.unmap_sg;
> +		dma_ops->sync_single_for_cpu = armada_xp_dma_sync;
> +		dma_ops->sync_single_for_device = armada_xp_dma_sync;
> +		dma_ops->sync_sg_for_cpu = arm_dma_ops.sync_sg_for_cpu;
> +		dma_ops->sync_sg_for_device = arm_dma_ops.sync_sg_for_device;
> +	}
> +	bus_register_notifier(&platform_bus_type, &armada_xp_platform_nb);

As Arnd said, I would prefer a lot to have the armada_xp_dma_ops
structure be initialized statically, even though it means that if the
arm_coherent_dma_ops structure is changed, we'll have to update here as
well. But I think it's cleaner.

Also, the bus notifier should be registered only if we have the
coherency fabric, otherwise it is anyway going to be called, setting
invalid DMA operations for all the platform devices.

So:

static dma_map_ops armada_370_xp_dma_ops = {
	...
};

void __init armada_370_xp_coherency_iocache_init(void)
{
	if (! of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
		return;

	bus_register_notifier(&platform_bus_type, &armada_370_xp_platform_nb);
}

>  int __init armada_370_xp_coherency_init(void)
>  {
>  	struct device_node *np;
> @@ -82,7 +159,17 @@ int __init armada_370_xp_coherency_init(void)
>  	if (np) {
>  		pr_info("Initializing Coherency fabric\n");
>  		coherency_base = of_iomap(np, 0);
> +		coherency_cpu_base = of_iomap(np, 1);
> +	}
> +#ifndef CONFIG_SMP
> +	if (coherency_base) {
> +		/* In UP case, cpu coherency is enabled here, in SMP case cpu
> +		 * coherency is enabled for each CPU by
> +		 * armada_xp_smp_prepare_cpus() in platsmp.c */
> +		int hw_cpuid = cpu_logical_map(smp_processor_id());
> +		armada_370_xp_set_cpu_coherent(hw_cpuid, 0);
>  	}
> +#endif

I really don't like this part of the code. First, the test is done on
"coherency_base", while armada_370_xp_coherency_iocache_init() is
checking the existence of the DT node to find if we have a coherency
fabric or not. It should be consistent.

Then, I don't see why the code patch for SMP and UP should be
different. The code in platsmp.c:armada_xp_smp_prepare_cpus() only
enables the coherency unit for the boot CPU. The other CPUs are
enabling the mechanism in the assembly code in headsmp.S. In other
words, I think you can remove the call to
armada_370_xp_set_cpu_coherent() in armada_xp_smp_prepare_cpus(), and
make the call unconditionally here in coherency.c for the boot CPU.

It seems like there is a better way to do this.

> diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
> index 86484bb..fff952e 100644
> --- a/arch/arm/mach-mvebu/common.h
> +++ b/arch/arm/mach-mvebu/common.h
> @@ -23,6 +23,8 @@ void armada_370_xp_handle_irq(struct pt_regs *regs);
>  
>  void armada_xp_cpu_die(unsigned int cpu);
>  
> +void armada_370_xp_coherency_iocache_init(void);
> +
>  int armada_370_xp_coherency_init(void);
>  int armada_370_xp_pmsu_init(void);
>  void armada_xp_secondary_startup(void);

Do we have a good reason for having
armada_370_xp_coherency_iocache_init() separate from
armada_370_xp_coherency_iocache_init() ? I.e, what prevents us from
registering the bus notifier directly in armada_370_xp_coherency_init()
if the coherency unit is available?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
