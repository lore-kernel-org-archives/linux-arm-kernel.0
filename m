From: juergen@kreuzholzen.de (Juergen Borleis)
Date: Tue, 11 Nov 2014 19:10:33 +0100
Subject: Samsung/S3C6410/Mini6410: how to handle NAND's "clock off"
Message-ID: <201411111910.34231.juergen@kreuzholzen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the S3C2410 NAND driver [1] can still be used for NANDs attached to an S3C6410
SoC. But this driver has a "nice" feature called "clock off" to save some
power while not in use. I tried it here on my Mini6410 platform and it freezes
the system.

The clock tree is somehow:

[...]
  hclk                      4            4   133000000          0 0
     hclk_mfc               0            0   133000000          0 0
     hclk_mem0              2            2   133000000          0 0
        mem0_srom           0            0   133000000          0 0
        mem0_nfcon          1            1   133000000          0 0
        mem0_onenand0       0            0   133000000          0 0
        mem0_onenand1       0            0   133000000          0 0
        mem0_cfcon          0            0   133000000          0 0
[...]

On the Mini6410 the "mem0_nfcon" clock is the only single user of the
"hclk_mem0". And this clock is required to keep the access to the external
network device enabled. When the NAND driver disables its clock "mem0_nfcon",
the "hclk_mem0" gets also disabled because there is no consumer anymore. The
next time the network driver tries to access its device, the SoC freezes.

How to prevent this? Can we keep the "hclk_mem0" enabled without an active
consumer? Or do we need a dummy consumer? Or do we need to request for
"hclk_mem0" when at least one external device is attached? Or should we remove
the "clock stop" feature for at least the S3C6410 SoC?

With the patch below I was able to reproduce the behavior:

Author: Juergen Borleis <juergen@kreuzholzen.de>
Date:   Mon Nov 10 23:35:06 2014 +0100

    ARM/S3C6410/NAND: add clock alias to keep an old driver alive
    
    This change enables the existing S3c2410.c driver for the S3C6410.
    
    But keep in mind to disable the CONFIG_MTD_NAND_S3C2410_CLKSTOP when using
    this driver!
    
    Why? The access to external devices depends on a running "hclk_mem0" clock.
    As the NAND controller was the only single user of it, it disables it, when
    it disables its owm clock to save power. This locks the system. m(
    
    Signed-off-by: Juergen Borleis <juergen@kreuzholzen.de>

diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index 0f590e5..f7d2d57 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -404,6 +404,7 @@ static struct samsung_clock_alias s3c64xx_clock_aliases[] = {
 	ALIAS(PCLK_IIS0, "samsung-i2s.0", "iis"),
 	ALIAS(PCLK_AC97, "samsung-ac97", "ac97"),
 	ALIAS(PCLK_TSADC, "s3c64xx-adc", "adc"),
+	ALIAS(MEM0_NFCON, NULL, "nand"),
 	ALIAS(PCLK_KEYPAD, "samsung-keypad", "keypad"),
 	ALIAS(PCLK_PCM1, "samsung-pcm.1", "pcm"),
 	ALIAS(PCLK_PCM0, "samsung-pcm.0", "pcm"),

jbe

[1] drivers/mtd/nand/s3c2410.c
