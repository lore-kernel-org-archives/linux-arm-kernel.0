From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 10 Jan 2015 12:43:57 +0000
Subject: [PATCH v2 06/21] ARM: tegra: remove old LIC support
In-Reply-To: <20150108112954.GK1987@ulmo.nvidia.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-7-git-send-email-marc.zyngier@arm.com>
 <20150108112954.GK1987@ulmo.nvidia.com>
Message-ID: <843e60a77fd4b40c60c6c9d1b395a2af@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-01-08 11:29, Thierry Reding wrote:
> On Wed, Jan 07, 2015 at 05:42:41PM +0000, Marc Zyngier wrote:
> [...]
>> diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
> [...]
>>  void __init tegra_init_irq(void)
>>  {
>> -	int i;
>> -	void __iomem *distbase;
>> -
>> -	if (of_find_matching_node(NULL, tegra_ictlr_match))
>> -		goto skip_extn_setup;
>> -
>> -	tegra_legacy_irq_syscore_init();
>> -
>> -	distbase = IO_ADDRESS(TEGRA_ARM_INT_DIST_BASE);
>> -	num_ictlrs = readl_relaxed(distbase + GIC_DIST_CTR) & 0x1f;
>> -
>> -	if (num_ictlrs > ARRAY_SIZE(ictlr_reg_base)) {
>> -		WARN(1, "Too many (%d) interrupt controllers found. Maximum is 
>> %d.",
>> -			num_ictlrs, ARRAY_SIZE(ictlr_reg_base));
>> -		num_ictlrs = ARRAY_SIZE(ictlr_reg_base);
>> -	}
>> -
>> -	for (i = 0; i < num_ictlrs; i++) {
>> -		void __iomem *ictlr = ictlr_reg_base[i];
>> -		writel(~0, ictlr + ICTLR_CPU_IER_CLR);
>> -		writel(0, ictlr + ICTLR_CPU_IEP_CLASS);
>> -	}
>> -
>> -	gic_arch_extn.irq_ack = tegra_ack;
>> -	gic_arch_extn.irq_eoi = tegra_eoi;
>> -	gic_arch_extn.irq_mask = tegra_mask;
>> -	gic_arch_extn.irq_unmask = tegra_unmask;
>> -	gic_arch_extn.irq_retrigger = tegra_retrigger;
>> -	gic_arch_extn.irq_set_wake = tegra_set_wake;
>> -	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
>> +	if (!of_find_matching_node(NULL, tegra_ictlr_match))
>> +		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
>
> I'm not very happy about the ABI breakage here, but I also realize 
> that
> we need this change to properly describe the hardware. To make it 
> more
> obvious that people really should update their DTBs, maybe turn this
> into a WARN()?

Sure, done.

>> -skip_extn_setup:
>>  	tegra114_gic_cpu_pm_registration();
>
> I'm not intimately familiar with the GIC, but is this really SoC
> specific? Doesn't anybody else need this? Comparing to the GIC spec 
> the
> write of 0x1e0 to the GIC_CPU_CTRL register (which I assume 
> corresponds
> to GICC_CTLR in the spec), this simply disables the IRQ and FIQ 
> bypass
> signals for both group 0 and group 1.

This seems to be a Tegra special, at least in mainline. But yes, I'd 
very much like to be able to remove this from platform code and make it 
part of the GIC driver if we can.

Something for a subsequent patch series, I guess.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
