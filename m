From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Dec 2017 14:03:03 +0000
Subject: [PATCH 01/10] soc: qcom: Separate kryo l2 accessors from PMU
 driver
In-Reply-To: <1513081897-31612-2-git-send-email-ilialin@codeaurora.org>
References: <1513081897-31612-1-git-send-email-ilialin@codeaurora.org>
 <1513081897-31612-2-git-send-email-ilialin@codeaurora.org>
Message-ID: <20171212140302.au4wart4uhwm7lfq@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 12, 2017 at 02:31:28PM +0200, Ilia Lin wrote:
> The driver provides kernel level API for other drivers
> to access the MSM8996 L2 cache registers.
> Separating the L2 access code from the PMU driver and
> making it public to allow other drivers use it.
> The accesses must be separated with a single spinlock,
> maintained in this driver.

> -static void set_l2_indirect_reg(u64 reg, u64 val)
> -{
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&l2_access_lock, flags);
> -	write_sysreg_s(reg, L2CPUSRSELR_EL1);
> -	isb();
> -	write_sysreg_s(val, L2CPUSRDR_EL1);
> -	isb();
> -	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
> -}

> +/**
> + * set_l2_indirect_reg: write value to an L2 register
> + * @reg: Address of L2 register.
> + * @value: Value to be written to register.
> + *
> + * Use architecturally required barriers for ordering between system register
> + * accesses, and system registers with respect to device memory
> + */
> +void set_l2_indirect_reg(u64 reg, u64 val)
> +{
> +	unsigned long flags;
> +	mb();

We didn't need this for the PMU driver, so it's unfortuante that it now
has to pay the cost.

Can we please factor this mb() into the callers that need it?

> +	raw_spin_lock_irqsave(&l2_access_lock, flags);
> +	write_sysreg_s(reg, L2CPUSRSELR_EL1);
> +	isb();
> +	write_sysreg_s(val, L2CPUSRDR_EL1);
> +	isb();
> +	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
> +}
> +EXPORT_SYMBOL(set_l2_indirect_reg);

[...]

> +#ifdef CONFIG_ARCH_QCOM
> +void set_l2_indirect_reg(u64 reg_addr, u64 val);
> +u64 get_l2_indirect_reg(u64 reg_addr);
> +#else
> +static inline void set_l2_indirect_reg(u32 reg_addr, u32 val) {}
> +static inline u32 get_l2_indirect_reg(u32 reg_addr)
> +{
> +	return 0;
> +}
> +#endif
> +#endif

Are there any drivers that will bne built for !CONFIG_ARCH_QCOM that
reference this?

It might be better to not have the stub versions, so that we get a
build-error if they are erroneously used.

Thannks,
Mark.
