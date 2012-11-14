From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2012 00:07:36 +0000
Subject: [PATCH V2 2/5] arm: mvebu: Added initial support for power
 managmement service unit
In-Reply-To: <20121105140558.GP3351@mudshark.cambridge.arm.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-3-git-send-email-gregory.clement@free-electrons.com>
 <20121105140558.GP3351@mudshark.cambridge.arm.com>
Message-ID: <20121114000736.GE3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 02:05:58PM +0000, Will Deacon wrote:
> On Mon, Oct 29, 2012 at 09:11:45PM +0000, Gregory CLEMENT wrote:
> > +#ifdef CONFIG_SMP
> > +int armada_xp_boot_cpu(unsigned int cpu_id, void __iomem *boot_addr)
> > +{
> > +	int reg, hw_cpu;
> > +
> > +	if (!pmsu_mp_base || !pmsu_reset_base) {
> > +		pr_warn("Can't boot CPU. PMSU is uninitialized\n");
> > +		return 1;
> > +	}
> > +
> > +	hw_cpu = cpu_logical_map(cpu_id);
> > +
> > +	writel(virt_to_phys(boot_addr), pmsu_mp_base +
> > +			PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
> 
> virt_to_phys on an __iomem * doesn't feel right to me...

It isn't correct - I suspect the __iomem there is just wrong - and it
needs the callsite also checking.

> > +	/* Make sure value hits memory before reset */
> > +	dsb();
> 
> writel has barrier semantics -- you shouldn't need this dsb.

writel has a barrier before the write (to ensure that DMA agents see data
that was written to memory when they are enabled by the write).  There
isn't a barrier after the write.
