From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed, 08 Dec 2010 19:41:47 -0800
Subject: [PATCH v2 6/6] msm: add SMP support for msm
In-Reply-To: <20101208152142.GH9777@n2100.arm.linux.org.uk>
References: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>	<1291782501-3909-7-git-send-email-johlstei@codeaurora.org>
	<20101208152142.GH9777@n2100.arm.linux.org.uk>
Message-ID: <4D004FFB.80100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Dec 07, 2010 at 08:28:21PM -0800, Jeff Ohlstein wrote:
>> +int get_core_count(void)
>> +{
>> +#ifdef CONFIG_NR_CPUS
>> +	return CONFIG_NR_CPUS;
>> +#else
>> +	return 1;
>> +#endif
>>     
>
> When would CONFIG_NR_CPUS not be set when SMP is available?
>
> Note that linux/threads.h defines this to 1 if it's not already defined
> anyway.  Does this really need to be a separate function?
>
>   
Removed.
>> +int boot_secondary(unsigned int cpu, struct task_struct *idle)
>> +{
>> +	static int cold_boot_done;
>> +	int cnt = 0;
>> +	printk(KERN_DEBUG "Starting secondary CPU %d\n", cpu);
>> +
>> +	if (cold_boot_done == false) {
>> +		prepare_cold_cpu(cpu);
>> +		cold_boot_done = true;
>> +	}
>> +
>> +	pen_release = cpu;
>> +	dmac_flush_range((void *)&pen_release,
>> +			 (void *)(&pen_release + sizeof(pen_release)));
>>     
>
> Abuse of the DMA API.  See how other platforms deal with this.
>
>   
Fixed to use __cpuc_flush_dcache_area and outer_clean_range.
>> +	__asm__("sev");
>> +	dsb();
>> +
>> +	/* Use smp_cross_call() to send a soft interrupt to wake up
>> +	 * the other core.
>> +	 */
>> +	smp_cross_call(cpumask_of(cpu));
>> +
>> +	while (pen_release != 0xFFFFFFFF) {
>>     
>
> Why 0xFFFFFFFF rather than -1 like everyone else does?
>
>   
Removed due to below.
>> +		smp_rmb();
>> +		msleep_interruptible(1);
>> +		if (cnt++ >= SECONDARY_CPU_WAIT_MS)
>> +			break;
>> +	}
>>     
>
> And why not use the same loop as everyone else does?
>
>         timeout = jiffies + (1 * HZ);
>         while (time_before(jiffies, timeout)) {
>                 smp_rmb();
>                 if (pen_release == -1)
>                         break;
>
>                 udelay(10);
>         }
>
> IOW, what's the point of being different when you're trying to do the
> same task?
>
>   
Done.
>> +
>> +	return 0;
>> +}
>> +
>> +/* Mask for edge trigger PPIs except AVS_SVICINT and AVS_SVICINTSWDONE */
>> +#define GIC_PPI_EDGE_MASK 0xFFFFD7FF
>> +
>> +/* Initialization routine for secondary CPUs after they are brought out of
>> + * reset.
>> +*/
>> +void platform_secondary_init(unsigned int cpu)
>> +{
>> +	printk(KERN_DEBUG "%s: cpu:%d\n", __func__, cpu);
>> +
>> +	trace_hardirqs_off();
>>     
>
> This has been moved into the generic SMP code.
>
>   
I've rebased onto your gic patches and your smp series, and removed this.
>> +	if (!machine_is_msm8x60_sim())
>> +		writel(0x0000FFFF, MSM_QGIC_DIST_BASE + GIC_DIST_ENABLE_SET);
>>     
>
> The gic secondary CPU initialization now takes care of this in my tree.
>
>   
Removed.
>> +
>> +	/*
>> +	 * setup GIC (GIC number NOT CPU number and the base address of the
>> +	 * GIC CPU interface
>> +	 */
>> +	gic_cpu_init(0, MSM_QGIC_CPU_BASE);
>>     
>
> This has been renamed to gic_secondary_init() for 2.6.38.
>
>   
Done.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
