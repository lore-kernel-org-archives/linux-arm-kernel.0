From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Thu, 15 Nov 2012 14:51:50 +0100
Subject: [PATCH 6/6] usb: chipidea: usbmisc: add post handling and errata
 fix for mx25
In-Reply-To: <20121115102525.GA16118@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352894137-2050-7-git-send-email-m.grzeschik@pengutronix.de>
 <CALBypN6U=np93ZwnEZqbh=j0Vb_-x630GaktEiv+4K26eYp4Pg@mail.gmail.com>
 <20121115102525.GA16118@pengutronix.de>
Message-ID: <CALBypN7-NKFmoPXWA0utFhUjLOWjvzwJ7ZSuQBa+W5edNQA_OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This is because that series is based on Peter Chen's work. I should have
> mentioned this in the cover-letter mail. You can merge his master branch
> before adding my series:

Ok thanks for the very rapid reply.

I've now built this together with patch 2 "ci13xxx_imx: add 2nd and
3rd clock to support imx5x and newer" from your other series.
But it hangs because the usb-phy clock is not being enabled.
If I add a clock enable for that clock too to usbmisc_imx.c it works
but that can't be the right way.

Who is supposed to enable the phy clock?
[I'm using the OTG port in host only mode on i.MX53 with "nop-usbphy"]

Here's what I did (illustration only, probably white space broken):

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c
b/arch/arm/mach-imx/clk-imx51-imx53.c
index cd6d7a0..2f0687a 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -492,6 +492,7 @@ int __init mx53_clocks_init(unsigned long
rate_ckil, unsigned long rate_osc,
        clk_register_clkdev(clk[usboh3_per_gate], "per", "53f80800.usbmisc");
        clk_register_clkdev(clk[usboh3_gate], "ipg", "53f80800.usbmisc");
        clk_register_clkdev(clk[usboh3_gate], "ahb", "53f80800.usbmisc");
+       clk_register_clkdev(clk[usb_phy1_gate], "phy1",
"53f80800.usbmisc"); // MF
        clk_register_clkdev(clk[esdhc1_ipg_gate], "ipg", "sdhci-esdhc-imx53.0");
        clk_register_clkdev(clk[dummy], "ahb", "sdhci-esdhc-imx53.0");
        clk_register_clkdev(clk[esdhc1_per_gate], "per", "sdhci-esdhc-imx53.0");
diff --git a/drivers/usb/chipidea/usbmisc_imx.c
b/drivers/usb/chipidea/usbmisc_imx.c
index acca109..a59093a 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -197,6 +197,24 @@ static int __devinit usbmisc_imx_probe(struct
platform_device *pdev)
        if (ret)
                goto err_per_failed;

+
+       { /* Temp Hack by MF awaiting reply on mailing list */
+               struct clk *phy_clk;
+
+               dev_info(&pdev->dev, "@MF@ hacking phy clock enable\n");
+               phy_clk = devm_clk_get(&pdev->dev, "phy1");
+               if (IS_ERR(phy_clk)) {
+                       dev_err(&pdev->dev, "failed to get PHY clock,
err=%ld\n", PTR_ERR(phy_clk));
+                       goto err_per_failed;
+               }
+
+               ret = clk_prepare_enable(phy_clk);
+               if (ret) {
+                       dev_err(&pdev->dev, "failed to enable PHY
clock, err=%d\n", ret);
+                       goto err_per_failed;
+               }
+       }
+
        tmp_dev = (struct of_device_id *)
                of_match_device(usbmisc_imx_dt_ids, &pdev->dev);
        data->ops = (const struct usbmisc_ops *)tmp_dev->data;
