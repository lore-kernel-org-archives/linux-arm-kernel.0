From: slash.tmp@free.fr (Mason)
Date: Tue, 3 Nov 2015 17:51:40 +0100
Subject: Cortex-A9 SCU + ARM_ERRATA_764369
Message-ID: <5638E61C.30406@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm using a dual Cortex-A9 MPCore r3p0 setup.
Thus, I have selected the following ERRATA work-arounds:

	select ARM_ERRATA_754322
	select ARM_ERRATA_764369 if SMP
	select ARM_ERRATA_775420

(I hope I didn't miss any.)

config ARM_ERRATA_764369
	bool "ARM errata: Data cache line maintenance operation by MVA may not succeed"
	depends on CPU_V7 && SMP
	help
	  This option enables the workaround for erratum 764369
	  affecting Cortex-A9 MPCore with two or more processors (all
	  current revisions). Under certain timing circumstances, a data
	  cache line maintenance operation by MVA targeting an Inner
	  Shareable memory region may fail to proceed up to either the
	  Point of Coherency or to the Point of Unification of the
	  system. This workaround adds a DSB instruction before the
	  relevant cache maintenance functions and sets a specific bit
	  in the diagnostic control register of the SCU.

I'm confused by some code in scu_enable() introduced by commit f630c1bdfbf8f

#ifdef CONFIG_ARM_ERRATA_764369
	/* Cortex-A9 only */
	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
		scu_ctrl = readl_relaxed(scu_base + 0x30);
		if (!(scu_ctrl & 1))
			writel_relaxed(scu_ctrl | 0x1, scu_base + 0x30);
	}
#endif

<confused>
What is scu_base + 0x30? (SCU diagnostic control register?)
I don't see this register/offset documented in
Cortex-A9 MPCore r3p0 Technical Reference Manual (2.2 SCU registers)

And what is bit0 in this register?

Regards.
