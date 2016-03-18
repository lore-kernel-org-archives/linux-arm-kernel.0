From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 18 Mar 2016 10:32:48 +0100 (CET)
Subject: [RESEND PATCH v4 5/5] clocksource: add memory-mapped timer
 support in arm_arch_timer.c
In-Reply-To: <1458288053-29031-6-git-send-email-fu.wei@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
 <1458288053-29031-6-git-send-email-fu.wei@linaro.org>
Message-ID: <alpine.DEB.2.11.1603181031280.3978@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Mar 2016, fu.wei at linaro.org wrote:
> +static u32 __init arch_timer_mem_cnttidr(struct acpi_gtdt_timer_block *gt_block)
> +{
> +	phys_addr_t cntctlbase_phy;
> +	void __iomem *cntctlbase;
> +	u32 cnttidr;
> +
> +	cntctlbase_phy = (phys_addr_t)gtdt_gt_cntctlbase(gt_block);
> +	if (!cntctlbase_phy) {
> +		pr_err("Can't find CNTCTLBase.\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * According to ARMv8 Architecture Reference Manual(ARM),
> +	 * the size of CNTCTLBase frame of memory-mapped timer
> +	 * is SZ_4K(Offset 0x000 ? 0xFFF).
> +	 */
> +	cntctlbase = ioremap(cntctlbase_phy, SZ_4K);
> +	if (!cntctlbase) {
> +		pr_err("Can't map CNTCTLBase\n");
> +		return 0;
> +	}

Why are you continuing when you can't find a base address or the remap fails?

> +	/*
> +	 * Get Generic Timer Counter-timer Timer ID Register
> +	 * for Virtual Timer Capability info
> +	 */
> +	cnttidr = arch_timer_mem_cnttidr(gt_block);

Thanks,

	tglx
