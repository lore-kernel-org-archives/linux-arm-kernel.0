From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Jun 2011 09:51:27 +0100
Subject: [PATCH 09/11] ARM: perf: add PMUv2 common event definitions
In-Reply-To: <BANLkTinL_arEKuu9XvnF43PrZ+rv2+dNrg@mail.gmail.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>	<1307379355-13802-10-git-send-email-will.deacon@arm.com>
	<BANLkTinL_arEKuu9XvnF43PrZ+rv2+dNrg@mail.gmail.com>
Message-ID: <001b01cc24f0$16a6e890$43f4b9b0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

Thanks for looking at this bag of hex values!

> On Mon, Jun 6, 2011 at 6:55 PM, Will Deacon <will.deacon@arm.com> wrote:
> > The PMUv2 specification reserves a number of event encodings
> > for common events.
> >
> > This patch adds these events to the common event enumeration
> > in preparation for PMUv2 cores, such as Cortex-A15.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > ?arch/arm/kernel/perf_event_v7.c | ? 35 +++++++++++++++++++++++++----------
> > ?1 files changed, 25 insertions(+), 10 deletions(-)

[...]

> > ?enum armv7_perf_types {
> > ? ? ? ?ARMV7_PERFCTR_PMNC_SW_INCR ? ? ? ? ? ? ?= 0x00,
> > ? ? ? ?ARMV7_PERFCTR_IFETCH_MISS ? ? ? ? ? ? ? = 0x01,
> > ? ? ? ?ARMV7_PERFCTR_ITLB_MISS ? ? ? ? ? ? ? ? = 0x02,
> > - ? ? ? ARMV7_PERFCTR_DCACHE_REFILL ? ? ? ? ? ? = 0x03,
> > - ? ? ? ARMV7_PERFCTR_DCACHE_ACCESS ? ? ? ? ? ? = 0x04,
> > + ? ? ? ARMV7_PERFCTR_DCACHE_REFILL ? ? ? ? ? ? = 0x03, /* L1 */
> > + ? ? ? ARMV7_PERFCTR_DCACHE_ACCESS ? ? ? ? ? ? = 0x04, /* L1 */
> > ? ? ? ?ARMV7_PERFCTR_DTLB_REFILL ? ? ? ? ? ? ? = 0x05,
> > ? ? ? ?ARMV7_PERFCTR_DREAD ? ? ? ? ? ? ? ? ? ? = 0x06,
> > ? ? ? ?ARMV7_PERFCTR_DWRITE ? ? ? ? ? ? ? ? ? ?= 0x07,
> > -
> > + ? ? ? ARMV7_PERFCTR_INSTR_EXECUTED ? ? ? ? ? ?= 0x08,
> > ? ? ? ?ARMV7_PERFCTR_EXC_TAKEN ? ? ? ? ? ? ? ? = 0x09,
> > ? ? ? ?ARMV7_PERFCTR_EXC_EXECUTED ? ? ? ? ? ? ?= 0x0A,
> > ? ? ? ?ARMV7_PERFCTR_CID_WRITE ? ? ? ? ? ? ? ? = 0x0B,
> > @@ -39,21 +45,30 @@ enum armv7_perf_types {
> > ? ? ? ? */
> > ? ? ? ?ARMV7_PERFCTR_PC_WRITE ? ? ? ? ? ? ? ? ?= 0x0C,
> > ? ? ? ?ARMV7_PERFCTR_PC_IMM_BRANCH ? ? ? ? ? ? = 0x0D,
> > + ? ? ? ARMV7_PERFCTR_PC_PROC_RETURN ? ? ? ? ? ?= 0x0E,
> Will ARMV7_PERFCTR_INSTR_EXECUTED and ARMV7_PERFCTR_PC_PROC_RETURN
> work for all v7 implementations? For example they are not defined for
> A9.

Correct, A9 doesn't support these and in general they are not mandatory.
The useful part is that this event space cannot be reused for different
events, so if an event of encoding 0x08 *is* supported, it absolutely
must be ARMV7_PERFCTR_INSTR_EXECUTED.

PMUv2 does define some feature registers (bitmaps) in the co-processor
space, which tell you the supported events out of the common encodings.
I don't think this is much use for the kernel, but it might be for
userspace. If somebody decides they want it then I'll happily expose it
through debugfs.
 
> > ? ? ? ?ARMV7_PERFCTR_UNALIGNED_ACCESS ? ? ? ? ?= 0x0F,
> > +
> > + ? ? ? /* These events are defined by the PMUv2 supplement (ARM DDI 0457A). */
> > ? ? ? ?ARMV7_PERFCTR_PC_BRANCH_MIS_PRED ? ? ? ?= 0x10,
> > ? ? ? ?ARMV7_PERFCTR_CLOCK_CYCLES ? ? ? ? ? ? ?= 0x11,
> > -
> > - ? ? ? ARMV7_PERFCTR_PC_BRANCH_MIS_USED ? ? ? ?= 0x12,
> > + ? ? ? ARMV7_PERFCTR_PC_BRANCH_PRED ? ? ? ? ? ?= 0x12,
> > + ? ? ? ARMV7_PERFCTR_MEM_ACCESS ? ? ? ? ? ? ? ?= 0x13,
> > + ? ? ? ARMV7_PERFCTR_L1_ICACHE_ACCESS ? ? ? ? ?= 0x14,
> > + ? ? ? ARMV7_PERFCTR_L1_DCACHE_WB ? ? ? ? ? ? ?= 0x15,
> > + ? ? ? ARMV7_PERFCTR_L2_DCACHE_ACCESS ? ? ? ? ?= 0x16,
> > + ? ? ? ARMV7_PERFCTR_L2_DCACHE_REFILL ? ? ? ? ?= 0x17,
> > + ? ? ? ARMV7_PERFCTR_L2_DCACHE_WB ? ? ? ? ? ? ?= 0x18,
> > + ? ? ? ARMV7_PERFCTR_BUS_ACCESS ? ? ? ? ? ? ? ?= 0x19,
> > + ? ? ? ARMV7_PERFCTR_MEMORY_ERROR ? ? ? ? ? ? ?= 0x1A,
> > + ? ? ? ARMV7_PERFCTR_INSTR_SPEC ? ? ? ? ? ? ? ?= 0x1B,
> > + ? ? ? ARMV7_PERFCTR_TTBR_WRITE ? ? ? ? ? ? ? ?= 0x1C,
> > + ? ? ? ARMV7_PERFCTR_BUS_CYCLES ? ? ? ? ? ? ? ?= 0x1D,
> Same question for those new events that are not defined for A8 and A9.

Same response actually. The core may implement a subset of these, but the
encodings remain reserved otherwise.

Thanks for taking a look,

Will
