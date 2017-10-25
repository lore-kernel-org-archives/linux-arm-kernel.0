From: keescook@chromium.org (Kees Cook)
Date: Wed, 25 Oct 2017 03:21:24 -0700
Subject: [PATCH] ARM: footbridge: Convert timers to use timer_setup()
Message-ID: <20171025102124.GA145647@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mach-footbridge/dc21285.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 96a3d73ef4bf..8407e4a07c77 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -136,19 +136,14 @@ struct pci_ops dc21285_ops = {
 static struct timer_list serr_timer;
 static struct timer_list perr_timer;
 
-static void dc21285_enable_error(unsigned long __data)
+static void dc21285_enable_error(struct timer_list *timer)
 {
-	switch (__data) {
-	case IRQ_PCI_SERR:
-		del_timer(&serr_timer);
-		break;
-
-	case IRQ_PCI_PERR:
-		del_timer(&perr_timer);
-		break;
-	}
+	del_timer(timer);
 
-	enable_irq(__data);
+	if (timer == &serr_timer)
+		enable_irq(IRQ_PCI_SERR)
+	else if (timer == &perr_timer)
+		enable_irq(IRQ_PCI_PERR);
 }
 
 /*
@@ -323,13 +318,8 @@ void __init dc21285_preinit(void)
 		*CSR_PCICMD = (*CSR_PCICMD & 0xffff) | PCICMD_ERROR_BITS;
 	}
 
-	init_timer(&serr_timer);
-	init_timer(&perr_timer);
-
-	serr_timer.data = IRQ_PCI_SERR;
-	serr_timer.function = dc21285_enable_error;
-	perr_timer.data = IRQ_PCI_PERR;
-	perr_timer.function = dc21285_enable_error;
+	timer_setup(&serr_timer, dc21285_enable_error, 0);
+	timer_setup(&perr_timer, dc21285_enable_error, 0);
 
 	/*
 	 * We don't care if these fail.
-- 
2.7.4


-- 
Kees Cook
Pixel Security
