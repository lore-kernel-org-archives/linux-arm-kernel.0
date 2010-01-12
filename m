From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 17:06:22 +0000
Subject: question about ARM11MP cpu architecture identification
In-Reply-To: <1263315302.29654.110.camel@pc1117.cambridge.arm.com>
References: <c70ff3ad1001120821u1f546480nd0229e560d84293@mail.gmail.com>
	<1263313572.29654.105.camel@pc1117.cambridge.arm.com>
	<20100112164220.GJ27771@n2100.arm.linux.org.uk>
	<1263315302.29654.110.camel@pc1117.cambridge.arm.com>
Message-ID: <20100112170622.GB5633@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 04:55:01PM +0000, Catalin Marinas wrote:
> On Tue, 2010-01-12 at 16:42 +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 12, 2010 at 04:26:12PM +0000, Catalin Marinas wrote:
> > > On Tue, 2010-01-12 at 16:21 +0000, saeed bishara wrote:
> > > >     The ARM11MP (rev r2p0) cpu architecture is ARMv6, and according to
> > > > the http://infocenter.arm.com, its Main ID register is 0x410FB024, and
> > > > the MMFR[3:0] is 3. but it looks to me that the cpu_architecture()
> > > > will identify it as ARMv7, and if the kernel was configured with
> > > > CPU_V7 only, then the lookup_processor_type() function also will
> > > > identify it as ARMv7. Am I missing something here?
> > >
> > > cpu_architecture() returns the architecture version of the supported MMU
> > > which on ARM11MPCore is the same as on ARMv7.
> > >
> > > Even if it is possible to configure both v6 and v7 in the same kernel, I
> > > don't think it is currently possible to successfully run such kernel.
> > 
> > What makes you think that?  I've been building v6+v7 kernels for Realview
> > (with a patch to provide the right build options for the ARMv7 arch/arm/mm
> > files) and ISTR it works fine on my Realview board.
> 
> I don't remember exactly but it didn't work for me some time ago. I
> think it failed to build (though I could have worked around this with
> something like -march=all).
> 
> If you have a clean patch, please push it upstream.

This is what I use, as part of my patches for running the kernel on the
model.  I have a similar patch for ARMv6 as well.

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 055cb2a..35b889c 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -39,6 +39,8 @@ obj-$(CONFIG_CPU_CACHE_V6)	+= cache-v6.o
 obj-$(CONFIG_CPU_CACHE_V7)	+= cache-v7.o
 obj-$(CONFIG_CPU_CACHE_FA)	+= cache-fa.o
 
+AFLAGS_cache-v7.o	:=-march=armv7-a
+
 obj-$(CONFIG_CPU_COPY_V3)	+= copypage-v3.o
 obj-$(CONFIG_CPU_COPY_V4WT)	+= copypage-v4wt.o
 obj-$(CONFIG_CPU_COPY_V4WB)	+= copypage-v4wb.o
@@ -58,6 +60,8 @@ obj-$(CONFIG_CPU_TLB_V6)	+= tlb-v6.o
 obj-$(CONFIG_CPU_TLB_V7)	+= tlb-v7.o
 obj-$(CONFIG_CPU_TLB_FA)	+= tlb-fa.o
 
+AFLAGS_tlb-v7.o		:=-march=armv7-a
+
 obj-$(CONFIG_CPU_ARM610)	+= proc-arm6_7.o
 obj-$(CONFIG_CPU_ARM710)	+= proc-arm6_7.o
 obj-$(CONFIG_CPU_ARM7TDMI)	+= proc-arm7tdmi.o
@@ -84,6 +88,8 @@ obj-$(CONFIG_CPU_FEROCEON)	+= proc-feroceon.o
 obj-$(CONFIG_CPU_V6)		+= proc-v6.o
 obj-$(CONFIG_CPU_V7)		+= proc-v7.o
 
+AFLAGS_proc-v7.o	:=-march=armv7-a
+
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
