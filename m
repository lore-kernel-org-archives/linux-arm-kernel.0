From: Florian.Belser@sensor-technik.de (Belser Florian)
Date: Thu, 28 Nov 2013 09:30:00 +0000
Subject: [PATCH] IMX6 flexcan: Change serial clock_feq source from IPG clock
 to PER clock
In-Reply-To: <E1C9442006A9AE48A7A4B85E0D01C4D4748A18@stwexdb.stww2k.local>
References: <E1C9442006A9AE48A7A4B85E0D01C4D4748A18@stwexdb.stww2k.local>
Message-ID: <5EC8D4ACC923FE4D871AFFACC9761279739C0B@stwexdb.stww2k.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

think I found a bug in the flexcan driver. Currently the serial clock frequency for bitrate calculation is derived from IPG clock.
According to the imx6d/q reference manual, the CAN serial clock is derived from can_root clock (PER clock in dtb). The patch below fixes this issue.
However, I'm not sure if the patch below will also work for the rest of the imx family. Does anybody know if the CAN serial clock is derived from IPG clock in other imx processors?
Is there a case distinction required to keep backward compatibility?

Be aware that getting the flexcan module running on the imx6 also requires patch "[PATCH] IMX6: Add static /8 prescaler to can_root clock configuration"


Here is my patch:

--- linux-3.10.20/drivers/net/can/flexcan.c.orig    2013-11-20 21:28:01.000000000 +0100
+++ linux-3.10.20/drivers/net/can/flexcan.c    2013-11-28 09:34:01.539469212 +0100
@@ -1031,7 +1031,6 @@ static int flexcan_probe(struct platform
             err = PTR_ERR(clk_ipg);
             goto failed_clock;
         }
-        clock_freq = clk_get_rate(clk_ipg);

         clk_per = devm_clk_get(&pdev->dev, "per");
         if (IS_ERR(clk_per)) {
@@ -1039,6 +1038,7 @@ static int flexcan_probe(struct platform
             err = PTR_ERR(clk_per);
             goto failed_clock;
         }
+        clock_freq = clk_get_rate(clk_per);
     }

     mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);

----------------------------------------

In the same file there is another bug which only occurs in combination with an imx6 processor.
Within the function "static int flexcan_chip_start(struct net_device *dev)" all message boxes will be initialized.
Think that isn't correct for the IMX6 processor.
In the newest kernel v3.12.r1 the problem is already fixed and I'm not sure if the fix will be automatically added to the LTE kernel version 3.10.20 ?
If not, shall I create a patch for it ?

Best regards
Florian Belser
