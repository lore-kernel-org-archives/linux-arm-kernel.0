From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Jan 2010 10:51:41 +0000
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch and burston
	Scorpion.
In-Reply-To: <20100111234540.GN7925@n2100.arm.linux.org.uk>
References: <20100111234540.GN7925@n2100.arm.linux.org.uk>
Message-ID: <1263293501.29654.40.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 23:45 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 11, 2010 at 02:47:27PM -0800, Daniel Walker wrote:
> > From: Larry Bassel <lbassel@quicinc.com>
> >
> > This change improves the following LMBench benchmarks
> > by over 15%:
> 
> Is this something that could be done in the platform initialisation code
> rather than the processor code?  It's clearly not specific to all ARMv7
> CPUs.

We discussed in the past but the thread died. There are various bits
that may need to be enabled before the CPU is initialised but it is
highly dependent on the hardware configuration and not only the CPU
type. For example, Cortex-A8/A9 may have some bits in the ACTLR register
which are fine to set on RealView but not on OMAP because the kernel
there is running in non-secure mode. Now Scorpion has other needs.

Since such initialisation would run before the MMU is enabled, should we
add an additional per-platform macro to be invoked before the CPU is set
up? A pointer in the machine_desc structure to an asm routine would also
work assuming that care is taken to calculate the phys address and the
code is position independent.

An alternative would be to briefly enable the MMU for the initialisation
(using a temporary page table) than disable it and switch to the proper
one built via create_mapping(). This would allow some initialisation
code to be written in C (though I'm not sure it's worth the effort).

-- 
Catalin
