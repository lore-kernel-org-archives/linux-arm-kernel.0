From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 11:03:19 +0100
Subject: [PATCH v2 04/26] openrisc: convert handle_IRQ to use
 __handle_domain_irq
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1409047421-27649-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to limit code duplication, convert the architecture specific
handle_IRQ to use the generic __handle_domain_irq function.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/openrisc/Kconfig      | 1 +
 arch/openrisc/kernel/irq.c | 9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 88e8336..e5a693b 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -8,6 +8,7 @@ config OPENRISC
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
+	select HANDLE_DOMAIN_IRQ
 	select HAVE_MEMBLOCK
 	select ARCH_REQUIRE_GPIOLIB
         select HAVE_ARCH_TRACEHOOK
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index 967eb14..e9aaf28 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -50,14 +50,7 @@ void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 
 void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	irq_enter();
-
-	generic_handle_irq(irq);
-
-	irq_exit();
-	set_irq_regs(old_regs);
+	__handle_domain_irq(NULL, irq, false, regs);
 }
 
 void __irq_entry do_IRQ(struct pt_regs *regs)
-- 
2.0.4
