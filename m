From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:22 +0100
Subject: [PATCH 15/15] ARM: don't discard exit sections for spinlock debugging
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-16-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids lots of warnings like this one:

`.exit.text' referenced in section `.alt.smp.init' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o

for each spinlock that is used in an __exit function, because
the smp alternatives try to patch out the spinlock locations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/vmlinux.lds.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index fb98c79179e9..f4de6e16d951 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -40,8 +40,7 @@
 #define ARM_CPU_KEEP(x)
 #endif
 
-#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
-	defined(CONFIG_GENERIC_BUG)
+#if defined(CONFIG_SMP_ON_UP) || defined(CONFIG_GENERIC_BUG)
 #define ARM_EXIT_KEEP(x)	x
 #define ARM_EXIT_DISCARD(x)
 #else
-- 
2.1.0.rc2
