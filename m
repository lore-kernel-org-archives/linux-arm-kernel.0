From: james.morse@arm.com (James Morse)
Date: Wed, 16 May 2018 17:28:20 +0100
Subject: [PATCH v4 03/12] ACPI / APEI: don't wait to serialise with oops
 messages when panic()ing
In-Reply-To: <20180516162829.14348-1-james.morse@arm.com>
References: <20180516162829.14348-1-james.morse@arm.com>
Message-ID: <20180516162829.14348-4-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

oops_begin() exists to group printk() messages with the oops message
printed by die(). To reach this caller we know that platform firmware
took this error first, then notified the OS via NMI with a 'panic'
severity.

Don't wait for another CPU to release the die-lock before we can
panic(), our only goal is to print this fatal error and panic().

This code is always called in_nmi(), and since 42a0bb3f7138 ("printk/nmi:
generic solution for safe printk in NMI"), it has been safe to call
printk() from this context. Messages are batched in a per-cpu buffer
and printed via irq-work, or a call back from panic().

Link: https://patchwork.kernel.org/patch/10313555/
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5a0b8a1bddb1..9b5f9642ee32 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -33,7 +33,6 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/cper.h>
-#include <linux/kdebug.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
@@ -758,9 +757,6 @@ static int _in_nmi_notify_one(struct ghes *ghes)
 
 	sev = ghes_severity(ghes->estatus->error_severity);
 	if (sev >= GHES_SEV_PANIC) {
-#ifdef CONFIG_X86
-		oops_begin();
-#endif
 		ghes_print_queued_estatus();
 		__ghes_panic(ghes);
 	}
-- 
2.16.2
