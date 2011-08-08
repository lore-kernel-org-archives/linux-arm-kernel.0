From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:10:22 +0100
Subject: [PATCH 4/6] ARM: smp: set thread_info->cpu to hardware CPU number for
	boot thread
In-Reply-To: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823424-9654-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, Linux assumes that the boot CPU has ID 0. If this ends up being
out of sync with the hardware CPU number, we will configure the GIC
incorrectly and route interrupts to the CPU with hardware ID 0.

This patch implements smp_setup_processor_id for ARM, using the MPIDR to
set the CPU of the boot thread.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/smp.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d88ff02..8e60a4f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -259,6 +259,22 @@ void __ref cpu_die(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+void __init smp_setup_processor_id(void)
+{
+	u32 mpidr;
+
+	/* Read the MPIDR to find the hardware ID of the current CPU. */
+	asm("1:		mrc	p15, 0, %0, c0, c0, 5\n"
+	    "		.pushsection \".alt.smp.init\", \"a\"\n"
+	    "		.long	1b\n"
+	    "		mov	%0, #0\n"
+	    "		.popsection"
+	    : "=r" (mpidr));
+
+	current_thread_info()->cpu = mpidr & 0xff;
+	printk("Booting Linux on CPU %d\n", current_thread_info()->cpu);
+}
+
 /*
  * Called by both boot and secondaries to move global data into
  * per-processor storage.
-- 
1.7.0.4
