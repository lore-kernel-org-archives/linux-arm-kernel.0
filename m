From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Aug 2012 17:53:59 +0100
Subject: [PATCH 0/3] New algorithm for ASID allocation and rollover
Message-ID: <1345049642-29704-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Following some investigation into preempt-rt Linux, it became apparent
that ASID rollover can happen fairly regularly under certain heavy
scheduling workloads. Each time this happens, we broadcast an interrupt
to the secondary CPUs so that we can reset the global ASID numberspace
without assigning duplicate ASIDs to different tasks or accidentally
assigning different ASIDs to threads of the same process.

This leads to a large number of expensive IPIs between cores:

           CPU0       CPU1
IPI0:          0          0  Timer broadcast interrupts
IPI1:      23165     115888  Rescheduling interrupts
IPI2:          0          0  Function call interrupts
IPI3:       6619       1123  Single function call interrupts <---- IPIs
IPI4:          0          0  CPU stop interrupts

Digging deeper, this also leads to an extremely varied waittime on the
cpu_asid_lock. Granted this is only contended for <1% of the time, but
the waittime varies between 0.5 and 734 us!

After some discussion, it became apparent that tracking the ASIDs
currently active on the cores in the system means that, on rollover, we
can automatically reserve those that are in use without having to stop
the world.

This patch series develops that idea so that:

  - We can support cores without hardware broadcasting of TLB maintenance
    operations without resorting to IPIs.
  - The fastpath (that is, the task already has a valid ASID) remains
    lockless.
  - Assuming that the number of CPUs is less than the number of ASIDs,
    the algorithm scales as they increase (using a bitmap for searching).
  - Generation overflow is not a problem (we use a u64).

With these patches applied, I saw ~2% improvement in hackbench scores on
my dual-core Cortex-A15 board and the interrupt statistics now appear as:

           CPU0       CPU1
IPI0:          0          0  Timer broadcast interrupts
IPI1:      64888      74560  Rescheduling interrupts
IPI2:          0          0  Function call interrupts
IPI3:          1          3  Single function call interrupts <--- Much better!
IPI4:          0          0  CPU stop interrupts

Finally, the waittime on cpu_asid_lock reduced to 0.5 - 4.6 us.

All feedback welcome.

Will


Will Deacon (3):
  ARM: mm: remove IPI broadcasting on ASID rollover
  ARM: mm: avoid taking ASID spinlock on fastpath
  ARM: mm: use bitmap operations when allocating new ASIDs

 arch/arm/include/asm/mmu.h         |   11 +--
 arch/arm/include/asm/mmu_context.h |   82 +--------------
 arch/arm/mm/context.c              |  207 +++++++++++++++++++-----------------
 3 files changed, 115 insertions(+), 185 deletions(-)

-- 
1.7.4.1
