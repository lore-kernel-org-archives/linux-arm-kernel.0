From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 10 Aug 2011 11:13:41 +0100
Subject: [RFC PATCH 3/5] ARM: kprobes: Reference cpu_architecture as a global
	variable
In-Reply-To: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1312971223-28165-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is needed for compatibility with the change of
cpu_architecture from a function to a global variable.

Since cpu_architecture is ARM-specific, also add an explicit
include for <asm/system.h> rather than relying on this being
included as a side-effect.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/kprobes-common.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index a5394fb4..bbf248c 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include <asm/system.h>
 
 #include "kprobes.h"
 
@@ -51,9 +52,8 @@ bool load_write_pc_interworks;
 
 void __init test_load_write_pc_interworking(void)
 {
-	int arch = cpu_architecture();
-	BUG_ON(arch == CPU_ARCH_UNKNOWN);
-	load_write_pc_interworks = arch >= CPU_ARCH_ARMv5T;
+	BUG_ON(cpu_architecture == CPU_ARCH_UNKNOWN);
+	load_write_pc_interworks = cpu_architecture >= CPU_ARCH_ARMv5T;
 }
 
 #endif /* !test_load_write_pc_interworking */
@@ -65,9 +65,8 @@ bool alu_write_pc_interworks;
 
 void __init test_alu_write_pc_interworking(void)
 {
-	int arch = cpu_architecture();
-	BUG_ON(arch == CPU_ARCH_UNKNOWN);
-	alu_write_pc_interworks = arch >= CPU_ARCH_ARMv7;
+	BUG_ON(cpu_architecture == CPU_ARCH_UNKNOWN);
+	alu_write_pc_interworks = cpu_architecture >= CPU_ARCH_ARMv7;
 }
 
 #endif /* !test_alu_write_pc_interworking */
-- 
1.7.4.1
