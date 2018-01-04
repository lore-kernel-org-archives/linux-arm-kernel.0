From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Thu, 4 Jan 2018 13:13:02 +0200
Subject: [PATCH 01/10] soc: qcom: Separate kryo l2 accessors from PMU
 driver
In-Reply-To: <20171212140302.au4wart4uhwm7lfq@lakrids.cambridge.arm.com>
References: <1513081897-31612-1-git-send-email-ilialin@codeaurora.org>
 <1513081897-31612-2-git-send-email-ilialin@codeaurora.org>
 <20171212140302.au4wart4uhwm7lfq@lakrids.cambridge.arm.com>
Message-ID: <027b01d3854c$ff085060$fd18f120$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is address in the V2: https://patchwork.kernel.org/patch/10144473/

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Tuesday, December 12, 2017 4:03 PM
> To: Ilia Lin <ilialin@codeaurora.org>
> Cc: linux-clk at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
linux-
> arm-msm at vger.kernel.org; sboyd at codeaurora.org;
> devicetree at vger.kernel.org; will.deacon at arm.com;
> rnayak at codeaurora.org; qualcomm-lt at lists.linaro.org;
> celster at codeaurora.org; tfinkel at codeaurora.org
> Subject: Re: [PATCH 01/10] soc: qcom: Separate kryo l2 accessors from PMU
> driver
> 
> Hi,
> 
> On Tue, Dec 12, 2017 at 02:31:28PM +0200, Ilia Lin wrote:
> > The driver provides kernel level API for other drivers to access the
> > MSM8996 L2 cache registers.
> > Separating the L2 access code from the PMU driver and making it public
> > to allow other drivers use it.
> > The accesses must be separated with a single spinlock, maintained in
> > this driver.
> 
> > -static void set_l2_indirect_reg(u64 reg, u64 val) -{
> > -	unsigned long flags;
> > -
> > -	raw_spin_lock_irqsave(&l2_access_lock, flags);
> > -	write_sysreg_s(reg, L2CPUSRSELR_EL1);
> > -	isb();
> > -	write_sysreg_s(val, L2CPUSRDR_EL1);
> > -	isb();
> > -	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
> > -}
> 
> > +/**
> > + * set_l2_indirect_reg: write value to an L2 register
> > + * @reg: Address of L2 register.
> > + * @value: Value to be written to register.
> > + *
> > + * Use architecturally required barriers for ordering between system
> > +register
> > + * accesses, and system registers with respect to device memory  */
> > +void set_l2_indirect_reg(u64 reg, u64 val) {
> > +	unsigned long flags;
> > +	mb();
> 
> We didn't need this for the PMU driver, so it's unfortuante that it now
has to
> pay the cost.
> 
> Can we please factor this mb() into the callers that need it?
> 
> > +	raw_spin_lock_irqsave(&l2_access_lock, flags);
> > +	write_sysreg_s(reg, L2CPUSRSELR_EL1);
> > +	isb();
> > +	write_sysreg_s(val, L2CPUSRDR_EL1);
> > +	isb();
> > +	raw_spin_unlock_irqrestore(&l2_access_lock, flags); }
> > +EXPORT_SYMBOL(set_l2_indirect_reg);
> 
> [...]
> 
> > +#ifdef CONFIG_ARCH_QCOM
> > +void set_l2_indirect_reg(u64 reg_addr, u64 val);
> > +u64 get_l2_indirect_reg(u64 reg_addr); #else static inline void
> > +set_l2_indirect_reg(u32 reg_addr, u32 val) {} static inline u32
> > +get_l2_indirect_reg(u32 reg_addr) {
> > +	return 0;
> > +}
> > +#endif
> > +#endif
> 
> Are there any drivers that will bne built for !CONFIG_ARCH_QCOM that
> reference this?
> 
> It might be better to not have the stub versions, so that we get a
build-error
> if they are erroneously used.
> 
> Thannks,
> Mark.
