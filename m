From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 May 2012 19:45:06 +0100
Subject: [PATCH] Prevent process migration during vfp_init()
In-Reply-To: <CAOsG7try1-E1JOq2w_A2767rbi+iyyahh=H1z9TzY+KLoc8N0g@mail.gmail.com>
References: <CAOsG7tqktqxxU9gtyqojP7KP87cy1jpgT8H==wOe0cQj8=LV+Q@mail.gmail.com>
 <20120508111332.GG2263@mudshark.cambridge.arm.com>
 <CAOsG7tqr__yWp1zmMfy3myRGFmY690f8i8emuXq5d7E=o3E7Vw@mail.gmail.com>
 <20120508180430.GL2263@mudshark.cambridge.arm.com>
 <CAOsG7try1-E1JOq2w_A2767rbi+iyyahh=H1z9TzY+KLoc8N0g@mail.gmail.com>
Message-ID: <20120508184506.GM2263@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 07:28:08PM +0100, Hyungwoo Yang wrote:
> Yes, I've already tested without preemption, it seems it is working fine.

Cracking, thanks for confirming that.

> for the failure, it is simple. on my A9 quad, due to heavy loads
> during "late initcall", sometimes process migration happens just after
> vfp_enable() but before smp_call_function(). it means there can be a
> VFP disabled but accessed since smp_call_function() is for the rest of
> cores not the core running it.
> 
> For example, if enable_vfp() is executed on core0 but
> smp_call_function() is excuted on core1 due to migration, then VFP on
> core1 is not enabled. it will be enabled next time when the core1
> online again.

Yup, your initial explanation was clear enough, I just wanted to check that
this did indeed solve your testcase given that I've been lucky enough not to
hit the issue on my boards.

Can I add your signed-off-by to the following please?

Will


Subject: [PATCH] ARM: vfp: ensure preemption is disabled when enabling VFP access

The vfp_enable function enables access to the VFP co-processor register
space (cp10 and cp11) on the current CPU and must be called with
preemption disabled. Unfortunately, the vfp_init late initcall does not
disable preemption and can lead to an oops during boot if thread
migration occurs at the wrong time and we end up attempting to access
the FPSID on a CPU with VFP access disabled.

This patch fixes the initcall to call vfp_enable from a non-preemptible
context on each CPU and adds a BUG_ON(preemptible) to ensure that any
similar problems are easily spotted in the future.

Reported-by: Hyungwoo Yang <hwoo.yang@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/vfp/vfpmodule.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index bc683b8..c5767b5 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
+#include <linux/hardirq.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <linux/signal.h>
@@ -432,7 +433,10 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 
 static void vfp_enable(void *unused)
 {
-	u32 access = get_copro_access();
+	u32 access;
+
+	BUG_ON(preemptible());
+	access = get_copro_access();
 
 	/*
 	 * Enable full access to VFP (cp10 and cp11)
@@ -657,7 +661,7 @@ static int __init vfp_init(void)
 	unsigned int cpu_arch = cpu_architecture();
 
 	if (cpu_arch >= CPU_ARCH_ARMv6)
-		vfp_enable(NULL);
+		on_each_cpu(vfp_enable, NULL, 1);
 
 	/*
 	 * First check that there is a VFP that we can use.
@@ -678,8 +682,6 @@ static int __init vfp_init(void)
 	} else {
 		hotcpu_notifier(vfp_hotplug, 0);
 
-		smp_call_function(vfp_enable, NULL, 1);
-
 		VFP_arch = (vfpsid & FPSID_ARCH_MASK) >> FPSID_ARCH_BIT;  /* Extract the architecture version */
 		printk("implementor %02x architecture %d part %02x variant %x rev %x\n",
 			(vfpsid & FPSID_IMPLEMENTER_MASK) >> FPSID_IMPLEMENTER_BIT,
-- 
1.7.4.1
