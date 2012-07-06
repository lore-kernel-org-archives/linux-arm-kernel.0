From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 06 Jul 2012 08:52:43 +0100
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
Message-ID: <4FF6994B.9040801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry Dmitry, looks like I missed you off of the CC list on this one.

Here it is again:

Before we can use any domain allocated IRQ, we need to first create a
map between the Hardware IRQ (hwirq) and the Linux Virtual IRQ (virq).
We do this with a helper function provided by the AB8500 IRQ domain
controller called ab8500_irq_get_virq(). We need to do this for both
IRQs which the Power-On-Key driver uses; one for button press, the other
for button depress.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/ab8500-ponkey.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 5ceb23e..ae4b683 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -82,6 +82,7 @@ static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
  	input_set_capability(input, EV_KEY, KEY_POWER);
 +	ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, ponkey->irq_dbf);
 	error = request_any_context_irq(ponkey->irq_dbf, ab8500_ponkey_handler,
 					0, "ab8500-ponkey-dbf", ponkey);
 	if (error < 0) {
@@ -90,6 +91,7 @@ static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 +	ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, ponkey->irq_dbr);
 	error = request_any_context_irq(ponkey->irq_dbr, ab8500_ponkey_handler,
 					0, "ab8500-ponkey-dbr", ponkey);
 	if (error < 0) {
-- 
1.7.9.5
