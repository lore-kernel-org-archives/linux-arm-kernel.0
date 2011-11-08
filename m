From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Nov 2011 13:07:36 +0000
Subject: [PATCH] ARM: msm: fix compilation flags for MSM_SCM
Message-ID: <1320757656-32171-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_MSM_SCM uses the smc instruction, which with some
toolchains requires a ".arch_extension" directive.

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/Makefile |    2 ++
 arch/arm/mach-msm/scm.c    |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 4285dfd..4ad3969 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -15,6 +15,8 @@ obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 obj-$(CONFIG_MSM_SCM) += scm.o scm-boot.o
 
+CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
+
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
 
diff --git a/arch/arm/mach-msm/scm.c b/arch/arm/mach-msm/scm.c
index 232f97a..bafabb5 100644
--- a/arch/arm/mach-msm/scm.c
+++ b/arch/arm/mach-msm/scm.c
@@ -180,6 +180,9 @@ static u32 smc(u32 cmd_addr)
 			__asmeq("%1", "r0")
 			__asmeq("%2", "r1")
 			__asmeq("%3", "r2")
+#ifdef REQUIRES_SEC
+			".arch_extension sec\n"
+#endif
 			"smc	#0	@ switch to secure world\n"
 			: "=r" (r0)
 			: "r" (r0), "r" (r1), "r" (r2)
-- 
1.7.0.4
