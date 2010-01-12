From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 11:44:41 +0000
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch and burston
	Scorpion.
In-Reply-To: <1263293501.29654.40.camel@pc1117.cambridge.arm.com>
References: <20100111234540.GN7925@n2100.arm.linux.org.uk>
	<1263293501.29654.40.camel@pc1117.cambridge.arm.com>
Message-ID: <20100112114441.GB27771@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 10:51:41AM +0000, Catalin Marinas wrote:
> We discussed in the past but the thread died. There are various bits
> that may need to be enabled before the CPU is initialised but it is
> highly dependent on the hardware configuration and not only the CPU
> type. For example, Cortex-A8/A9 may have some bits in the ACTLR register
> which are fine to set on RealView but not on OMAP because the kernel
> there is running in non-secure mode. Now Scorpion has other needs.
> 
> Since such initialisation would run before the MMU is enabled, should we
> add an additional per-platform macro to be invoked before the CPU is set
> up? A pointer in the machine_desc structure to an asm routine would also
> work assuming that care is taken to calculate the phys address and the
> code is position independent.

What you're asking for is bith platform and CPU dependent - which makes
it much more difficult to generalize.  It also throws a spanner in the
works for the DT people.

> An alternative would be to briefly enable the MMU for the initialisation
> (using a temporary page table) than disable it and switch to the proper
> one built via create_mapping(). This would allow some initialisation
> code to be written in C (though I'm not sure it's worth the effort).

How would that work?  You're saying on one hand that there's initialization
which needs to be done before the MMU is initialized, and in this paragraph
you're saying it can be done while the MMU is initialized and enabled.

Well, if it can be done while the MMU is initialized and enabled, why can't
it be done later?

Actually, what you describe is what's already being done by the head.S
code - we already build a temporary page table and enable the MMU so that
we can get the C code running to setup the page tables properly.

It strikes me that things are just becoming excessively complicated with
these seemingly "catch-22" issues.  Maybe a totally different approach is
needed - such as requiring some of this low level setup to be done by the
platform's boot loader?
