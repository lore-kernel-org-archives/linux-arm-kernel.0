From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Jun 2018 10:42:10 +0100
Subject: [PATCH v2] arm: Hook up SYNC_CORE functionality for sys_membarrier()
Message-ID: <1530006130-18048-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exception return implies context synchronization, so we can hook up the
SYNC_CORE option to sys_membarrier() simply by selecting the Kconfig option,
just like we've done for arm64 already.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Orion Hodson <oth@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v1 -> v2: Update arch-support.txt

 .../features/sched/membarrier-sync-core/arch-support.txt          | 8 ++++----
 arch/arm/Kconfig                                                  | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index dbdf62907703..c7858dd1ea8f 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -5,10 +5,10 @@
 #
 # Architecture requirements
 #
-# * arm64
+# * arm/arm64
 #
-# Rely on eret context synchronization when returning from IPI handler, and
-# when returning to user-space.
+# Rely on implicit context synchronization as a result of exception return
+# when returning from IPI handler, and when returning to user-space.
 #
 # * x86
 #
@@ -31,7 +31,7 @@
     -----------------------
     |       alpha: | TODO |
     |         arc: | TODO |
-    |         arm: | TODO |
+    |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54eeb8d00bc6..b0ac18547370 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -9,6 +9,7 @@ config ARM
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SET_MEMORY
-- 
2.1.4
