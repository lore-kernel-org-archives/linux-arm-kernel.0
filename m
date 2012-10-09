From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 17:22:56 +0200
Subject: [PATCH 2/9] ARM: export set_irq_flags
In-Reply-To: <1349796183-30648-1-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
Message-ID: <1349796183-30648-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added Emma Mobile GPIO driver calls set_irq_flags
and irq_set_chip_and_handler for the interrupts it exports and
it can be built as a module, which currently fails with

ERROR: "set_irq_flags" [drivers/gpio/gpio-em.ko] undefined!

We either need to replace the call to set_irq_flags with something
else or export that function. This patch does the latter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Magnus Damm <damm@opensource.se>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/irq.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 16cedb4..8961650 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -34,6 +34,7 @@
 #include <linux/list.h>
 #include <linux/kallsyms.h>
 #include <linux/proc_fs.h>
+#include <linux/export.h>
 
 #include <asm/exception.h>
 #include <asm/mach/arch.h>
@@ -109,6 +110,7 @@ void set_irq_flags(unsigned int irq, unsigned int iflags)
 	/* Order is clear bits in "clr" then set bits in "set" */
 	irq_modify_status(irq, clr, set & ~clr);
 }
+EXPORT_SYMBOL_GPL(set_irq_flags);
 
 void __init init_IRQ(void)
 {
-- 
1.7.10
