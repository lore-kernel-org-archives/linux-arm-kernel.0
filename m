From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue,  9 Jun 2015 00:24:48 +0200
Subject: [PATCH] ARM: Re-enable TRACE_IRQFLAGS_SUPPORT on ARMv7-M
Message-ID: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cb1293e2f594 ("ARM: 8375/1: disable some options on ARMv7-M") causes
build failure on ARMv7-M machines:

  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/sem.h:5:0,
                 from include/linux/sched.h:35,
                 from arch/arm/kernel/asm-offsets.c:14:
include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
include/linux/rcupdate.h:539:2: error: implicit declaration of function 'arch_irqs_disabled' [-Werror=implicit-function-declaration]
  return preempt_count() != 0 || irqs_disabled();
  ^
Commit cb1293e2f594 was initially introduced to fix build errors with randconfig,
as ARMv7-m selects TRACE_IRQFLAGS_SUPPORT but breaks build when TRACE_IRQFLAGS
is selected.

As there is no proper support yet for TRACE_IRQFLAGS, this patch partially
reverts commit cb1293e2f594, with the downside of build errors with randconfig
when TRACE_IRQFLAGS gets selected.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b47457d..e4e1694 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -171,7 +171,7 @@ config LOCKDEP_SUPPORT
 
 config TRACE_IRQFLAGS_SUPPORT
 	bool
-	default !CPU_V7M
+	default y
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
-- 
1.9.1
