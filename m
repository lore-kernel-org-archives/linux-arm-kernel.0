From: angus@akkea.ca (Angus Ainslie)
Date: Tue, 23 May 2017 22:05:14 -0600
Subject: CHIPPro NAND issue with 4.12 rc1
In-Reply-To: <20170523195239.6nsv4ydrt4u7q6ge@flea.home>
References: <399ea126f3b18071fbe46bfc9787df6b@www.akkea.ca>
 <20170520171418.4e8a47e0@bbrezillon>
 <6f3cefa6c54776f82160ed8954f4d0d4@www.akkea.ca>
 <20170521074535.4a4ba6dd@bbrezillon>
 <20170522070117.mwk4gm34o7idedye@flea.home>
 <63aca137397dc3700a34993205c8cfba@www.akkea.ca>
 <20170523195239.6nsv4ydrt4u7q6ge@flea.home>
Message-ID: <a022aed57030622591a8e7eb97a59ff1@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-23 13:52, Maxime Ripard wrote:
> 
> Ok, good.
> 
> If you unrevert those patches, and add clk_ignore_unused to the kernel
> command line, is it still broken?
> 
> Maxime


If I use the clk_ignore_unused flag with the patches below then the 
kernel can boot and mount the nand.

diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c 
b/drivers/clk/sunxi-ng/ccu-sun5i.c
index 5c476f9..700944c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.c
+++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
@@ -251,7 +251,7 @@ static SUNXI_CCU_GATE(ahb_mmc1_clk, "ahb-mmc1",     
"ahb",
  static SUNXI_CCU_GATE(ahb_mmc2_clk,    "ahb-mmc2",     "ahb",
                       0x060, BIT(10), 0);
  static SUNXI_CCU_GATE(ahb_nand_clk,    "ahb-nand",     "ahb",
-                     0x060, BIT(13), 0);
+                     0x060, BIT(13), CLK_IS_CRITICAL);
  static SUNXI_CCU_GATE(ahb_sdram_clk,   "ahb-sdram",    "ahb",
                       0x060, BIT(14), CLK_IS_CRITICAL);
  static SUNXI_CCU_GATE(ahb_emac_clk,    "ahb-emac",     "ahb",


diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts 
b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index c55b11a..fa37cce 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -146,6 +149,32 @@
                 reg = <0>;
                 allwinner,rb = <0>;
                 nand-ecc-mode = "hw";
+    nand-on-flash-bbt;
+
+    spl at 0 {
+      label = "SPL";
+      reg = /bits/ 64 <0x0 0x400000>;
+    };
+
+    spl-backup at 400000 {
+      label = "SPL.backup";
+      reg = /bits/ 64 <0x400000 0x400000>;
+    };
+
+    u-boot at 800000 {
+      label = "U-Boot";
+      reg = /bits/ 64 <0x800000 0x400000>;
+    };
+
+    env at c00000 {
+      label = "env";
+      reg = /bits/ 64 <0xc00000 0x400000>;
+    };
+
+    rootfs at 1000000 {
+      label = "rootfs";
+      reg = /bits/ 64 <0x1000000 0x1f000000>;
+    };
         };
  };
