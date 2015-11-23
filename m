From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 23 Nov 2015 11:54:09 -0500
Subject: [PATCH] ARM: dts: keystone: k2l: fix kernel crash when
 clk_ignore_unused is not in bootargs
Message-ID: <1448297649-22122-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently kernel crash randomly when K2L EVM is booted without
clk_ignore_unused in the bootargs. This workaround is not needed
on other K2 devices such as K2HK and K2E and with this fix, we can
remove the workaround altogether. netcp driver on K2L uses linked
ram on OSR (On chip Static RAM) and requires the clock to this peripheral
enabled for proper functioning. This is the reason for the kernel crash.
So add the clock node to fix this issue.

While at it, remove the workaround documentation as well.

With the fix applied, clk_summary dump shows the clock to OSR enabled.

cat /sys/kernel/debug/clk/clk_summary
 ------cut--------------
   tcp3d-1                   0            0   399360000          0 0
   tcp3d-0                   0            0   399360000          0 0
   osr                       1            1   399360000          0 0
   fftc-0                    0            0   399360000          0 0
 -----cut----------------
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 Applies to Linux 4.4-rc2
 Documentation/arm/keystone/Overview.txt | 18 ------------------
 arch/arm/boot/dts/k2l-netcp.dtsi        |  2 +-
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/Documentation/arm/keystone/Overview.txt b/Documentation/arm/keystone/Overview.txt
index f17bc4c..400c0c2 100644
--- a/Documentation/arm/keystone/Overview.txt
+++ b/Documentation/arm/keystone/Overview.txt
@@ -49,24 +49,6 @@ specified through DTS. Following are the DTS used:-
 The device tree documentation for the keystone machines are located at
         Documentation/devicetree/bindings/arm/keystone/keystone.txt
 
-Known issues & workaround
--------------------------
-
-Some of the device drivers used on keystone are re-used from that from
-DaVinci and other TI SoCs. These device drivers may use clock APIs directly.
-Some of the keystone specific drivers such as netcp uses run time power
-management API instead to enable clock. As this API has limitations on
-keystone, following workaround is needed to boot Linux.
-
-   Add 'clk_ignore_unused' to the bootargs env variable in u-boot. Otherwise
-   clock frameworks will try to disable clocks that are unused and disable
-   the hardware. This is because netcp related power domain and clock
-   domains are enabled in u-boot as run time power management API currently
-   doesn't enable clocks for netcp due to a limitation. This workaround is
-   expected to be removed in the future when proper API support becomes
-   available. Until then, this work around is needed.
-
-
 Document Author
 ---------------
 Murali Karicheri <m-karicheri2@ti.com>
diff --git a/arch/arm/boot/dts/k2l-netcp.dtsi b/arch/arm/boot/dts/k2l-netcp.dtsi
index 01aef23..5acbd0d 100644
--- a/arch/arm/boot/dts/k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/k2l-netcp.dtsi
@@ -137,7 +137,7 @@ netcp: netcp at 26000000 {
 	/* NetCP address range */
 	ranges = <0 0x26000000 0x1000000>;
 
-	clocks = <&papllclk>, <&clkcpgmac>, <&chipclk12>;
+	clocks = <&clkosr>, <&papllclk>, <&clkcpgmac>, <&chipclk12>;
 	dma-coherent;
 
 	ti,navigator-dmas = <&dma_gbe 0>,
-- 
1.9.1
