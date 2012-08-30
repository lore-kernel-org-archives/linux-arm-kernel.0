From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 30 Aug 2012 14:12:04 +0100
Subject: [PATCH 8/8] input: ab8500-ponkey: Rely on MFD core to convert
 IRQs to virtual
In-Reply-To: <20120821164244.GA4672@core.coreip.homeip.net>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ-HOGy_sdsCQSNOdYTDzHFszk0OySM88TjO-neSJUz0A@mail.gmail.com>
 <20120821092328.GC26899@gmail.com>
 <20120821164244.GA4672@core.coreip.homeip.net>
Message-ID: <20120830131202.GG14145@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Sorry for the delay. Yes, this shoudl be fine, but since it is
> essentially a revert of the original patch it should be pushed in as
> such.

How's this?

Author: Lee Jones <lee.jones@linaro.org>
Date:   Thu Aug 30 14:08:19 2012 +0100

    Revert "input: ab8500-ponkey: Create AB8500 domain IRQ mapping"
    
    This reverts commit ca3b3faf9bee4dc5df4f10eae2d1e48f7de0a8ad.
    
    There was a plan to place ab8500_irq_get_virq() calls in each AB8500
    child device prior to requesting an IRQ, but as we're no longer using
    Device Tree to collect our IRQ numbers, it's actually better to allow
    the core to do this during device registration time. So the IRQ number
    we pull from its resource has already been converted to a virtual IRQ.
    
    CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    CC: linux-input at vger.kernel.org
    Acked-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index f06231b..84ec691 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -74,8 +74,8 @@ static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
 
        ponkey->idev = input;
        ponkey->ab8500 = ab8500;
-       ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, irq_dbf);
-       ponkey->irq_dbr = ab8500_irq_get_virq(ab8500, irq_dbr);
+       ponkey->irq_dbf = irq_dbf;
+       ponkey->irq_dbr = irq_dbr;
 
        input->name = "AB8500 POn(PowerOn) Key";
        input->dev.parent = &pdev->dev;
