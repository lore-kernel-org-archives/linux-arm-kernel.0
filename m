From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:26 +0200
Subject: [PATCH 08/32] Revert "input: ab8500-ponkey: Create AB8500 domain IRQ
 mapping"
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit ca3b3faf9bee4dc5df4f10eae2d1e48f7de0a8ad.

There was a plan to place ab8500_irq_get_virq() calls in each AB8500
child device prior to requesting an IRQ, but as we're no longer using
Device Tree to collect our IRQ numbers, it's actually better to allow
the core to do this during device registration time. So the IRQ number
we pull from its resource has already been converted to a virtual IRQ.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/ab8500-ponkey.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index f06231b..84ec691 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -74,8 +74,8 @@ static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
 
 	ponkey->idev = input;
 	ponkey->ab8500 = ab8500;
-	ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, irq_dbf);
-	ponkey->irq_dbr = ab8500_irq_get_virq(ab8500, irq_dbr);
+	ponkey->irq_dbf = irq_dbf;
+	ponkey->irq_dbr = irq_dbr;
 
 	input->name = "AB8500 POn(PowerOn) Key";
 	input->dev.parent = &pdev->dev;
-- 
1.7.9.5
