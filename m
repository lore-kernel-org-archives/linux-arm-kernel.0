From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:08 +0100
Subject: [PATCH 01/15] ARM: always select IRQ_WORK on SMP
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any SMP kernel now requires the irq_work code after
generic_smp_call_function_single_interrupt() started using it,
or we get:

kernel/built-in.o: In function `flush_smp_call_function_queue':
:(.text+0x4dc3a): undefined reference to `irq_work_run'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 478850160636c4f ("irq_work: Implement remote queueing")
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7495d5a1316..c0ad9e62192b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1316,6 +1316,7 @@ config SMP
 	depends on GENERIC_CLOCKEVENTS
 	depends on HAVE_SMP
 	depends on MMU || ARM_MPU
+	select IRQ_WORK
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, say N. If you have a system with more
-- 
2.1.0.rc2
