From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Thu, 11 Jun 2015 11:03:59 +0530
Subject: [PATCH] ARM: iop32x: Use setup_timer
Message-ID: <20150611053359.GA4855@vaishali-Ideapad-Z570>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the timer API function setup_timer instead of structure field
assignments to initialize a timer.

A simplified version of the Coccinelle semantic patch that performs
this transformation is as follows:

@change@
expression e1, e2, a;
@@

-init_timer(&e1);
+setup_timer(&e1, a, 0UL);
... when != a = e2
-e1.function = a;

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 arch/arm/mach-iop32x/n2100.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index c1cd80e..4a64a11 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -336,8 +336,7 @@ static int __init n2100_request_gpios(void)
 			pr_err("could not set power GPIO as input\n");
 	}
 	/* Set up power button poll timer */
-	init_timer(&power_button_poll_timer);
-	power_button_poll_timer.function = power_button_poll;
+	setup_timer(&power_button_poll_timer, power_button_poll, 0UL);
 	power_button_poll_timer.expires = jiffies + (HZ / 10);
 	add_timer(&power_button_poll_timer);
 	return 0;
-- 
1.9.1
