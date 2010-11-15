From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Mon, 15 Nov 2010 09:31:34 -0800 (PST)
Subject: [PATCH] mx35_3ds: Add watchdog support
In-Reply-To: <20101115155201.GH8942@pengutronix.de>
Message-ID: <78127.99191.qm@web51001.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe and Wolfram,

--- On Mon, 11/15/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Subject: Re: [PATCH] mx35_3ds: Add watchdog support
> To: "Fabio Estevam" <fabioestevam@yahoo.com>
> Cc: fabio.estevam at freescale.com, s.hauer at pengutronix.de, linux-arm-kernel at lists.infradead.org
> Date: Monday, November 15, 2010, 1:52 PM
> Hi Fabio,
> 
> On Mon, Nov 15, 2010 at 06:31:09AM -0800, Fabio Estevam
> wrote:
> > mx35_3ds: Add watchdog support.
> I just converted the mx3 watchdog device to dynamic
> allocation.? Will
> take care of mx35_3ds.

Ok, understood.

I have also started testing watchdog on MX51.

As there is no watchdog clock entry in the CCM block on MX51 I thought on doing the following:

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 2ee7dac..63f600c 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -270,10 +270,12 @@ static int __init imx2_wdt_probe(struct
platform_device *pdev)
        return -ENOMEM;
    }

-    imx2_wdt.clk = clk_get_sys("imx-wdt.0", NULL);
-    if (IS_ERR(imx2_wdt.clk)) {
-        dev_err(&pdev->dev, "can't get Watchdog clock\n");
-        return PTR_ERR(imx2_wdt.clk);
+    if (!cpu_is_mx51()) {
+        imx2_wdt.clk = clk_get_sys("imx-wdt.0", NULL);
+        if (IS_ERR(imx2_wdt.clk)) {
+            dev_err(&pdev->dev, "can't get Watchdog clock\n");
+            return PTR_ERR(imx2_wdt.clk);
+        }
    }

Does this look a correct approach?

Regards,

Fabio Estevam 


      
