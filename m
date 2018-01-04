From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Thu, 4 Jan 2018 13:15:51 +0200
Subject: [PATCH 01/10] soc: qcom: Separate kryo l2 accessors from PMU
 driver
In-Reply-To: <20171222020636.GG7997@codeaurora.org>
References: <1513081897-31612-1-git-send-email-ilialin@codeaurora.org>
 <1513081897-31612-2-git-send-email-ilialin@codeaurora.org>
 <20171212140302.au4wart4uhwm7lfq@lakrids.cambridge.arm.com>
 <20171222020636.GG7997@codeaurora.org>
Message-ID: <028101d3854d$63e14500$2ba3cf00$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested COMPILE_TEST and found OK.

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: Friday, December 22, 2017 4:07 AM
> To: Mark Rutland <mark.rutland@arm.com>
> Cc: Ilia Lin <ilialin@codeaurora.org>; linux-clk at vger.kernel.org;
linux-arm-
> kernel at lists.infradead.org; linux-arm-msm at vger.kernel.org;
> devicetree at vger.kernel.org; will.deacon at arm.com;
> rnayak at codeaurora.org; qualcomm-lt at lists.linaro.org;
> celster at codeaurora.org; tfinkel at codeaurora.org
> Subject: Re: [PATCH 01/10] soc: qcom: Separate kryo l2 accessors from PMU
> driver
> 
> On 12/12, Mark Rutland wrote:
> > On Tue, Dec 12, 2017 at 02:31:28PM +0200, Ilia Lin wrote:
> > > + * accesses, and system registers with respect to device memory  */
> > > +void set_l2_indirect_reg(u64 reg, u64 val) {
> > > +	unsigned long flags;
> > > +	mb();
> >
> > We didn't need this for the PMU driver, so it's unfortuante that it
> > now has to pay the cost.
> >
> > Can we please factor this mb() into the callers that need it?
> 
> +1
> 
> >
> > > +	raw_spin_lock_irqsave(&l2_access_lock, flags);
> > > +	write_sysreg_s(reg, L2CPUSRSELR_EL1);
> > > +	isb();
> > > +	write_sysreg_s(val, L2CPUSRDR_EL1);
> > > +	isb();
> > > +	raw_spin_unlock_irqrestore(&l2_access_lock, flags); }
> > > +EXPORT_SYMBOL(set_l2_indirect_reg);
> >
> > [...]
> >
> > > +#ifdef CONFIG_ARCH_QCOM
> > > +void set_l2_indirect_reg(u64 reg_addr, u64 val);
> > > +u64 get_l2_indirect_reg(u64 reg_addr); #else static inline void
> > > +set_l2_indirect_reg(u32 reg_addr, u32 val) {} static inline u32
> > > +get_l2_indirect_reg(u32 reg_addr) {
> > > +	return 0;
> > > +}
> > > +#endif
> > > +#endif
> >
> > Are there any drivers that will bne built for !CONFIG_ARCH_QCOM that
> > reference this?
> >
> > It might be better to not have the stub versions, so that we get a
> > build-error if they are erroneously used.
> >
> 
> Does that approach make COMPILE_TEST break?
> 
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
