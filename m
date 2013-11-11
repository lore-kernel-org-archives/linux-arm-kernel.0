From: ivan.khoronzhuk@ti.com (Khoronzhuk, Ivan)
Date: Mon, 11 Nov 2013 17:09:59 +0000
Subject: [PATCH 09/12] mtd: nand: davinci: reuse driver for Keystone arch
In-Reply-To: <1384187188-5776-10-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-10-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <4F5844B3A985794BA902E12C070812375F8D46@DNCE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone arch has compatible nand device, so reuse it.
In case with Keystone it depends on TI_DAVINCI_AEMIF because AEMIF
driver is responsible to set timings.

See http://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 .../devicetree/bindings/mtd/davinci-nand.txt       |    8 +++++---
 drivers/mtd/nand/Kconfig                           |    6 +++---
 drivers/mtd/nand/davinci_nand.c                    |    1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
index befaa5b..cfb18ab 100644
--- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
@@ -1,14 +1,16 @@
-Device tree bindings for Texas instruments Davinci NAND controller
+Device tree bindings for Texas instruments Davinci/Keystone NAND controller

-This file provides information, what the device node for the davinci NAND
-interface contains.
+This file provides information, what the device node for the davinci/keystone
+NAND interface contains.

 Documentation:
 Davinci DM646x - http://www.ti.com/lit/ug/sprueq7c/sprueq7c.pdf
+Kestone - http://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf

 Required properties:

 - compatible:                  "ti,davinci-nand"
+                               "ti,keystone-nand"

 - reg:                         Contains 2 offset/length values:
                                - offset and length for the access window.
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index d885298..62dbcd5 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -492,11 +492,11 @@ config MTD_NAND_SH_FLCTL
          for NAND Flash using FLCTL.

 config MTD_NAND_DAVINCI
-        tristate "Support NAND on DaVinci SoC"
-        depends on ARCH_DAVINCI
+        tristate "Support NAND on DaVinci/Keystone SoC"
+        depends on ARCH_DAVINCI || (ARCH_KEYSTONE && TI_DAVINCI_AEMIF)
         help
          Enable the driver for NAND flash chips on Texas Instruments
-         DaVinci processors.
+         DaVinci/Keystone processors.

 config MTD_NAND_TXX9NDFMC
        tristate "NAND Flash support for TXx9 SoC"
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 78b8d66..4705214 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -523,6 +523,7 @@ static struct nand_ecclayout hwecc4_2048 __initconst = {
 #if defined(CONFIG_OF)
 static const struct of_device_id davinci_nand_of_match[] = {
        {.compatible = "ti,davinci-nand", },
+       {.compatible = "ti,keystone-nand", },
        {},
 };
 MODULE_DEVICE_TABLE(of, davinci_nand_of_match);
--
1.7.9.5
