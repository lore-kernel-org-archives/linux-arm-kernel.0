From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Mar 2014 02:53:14 +0100
Subject: [GIT PULL 2/2] Samsung 2nd DT updates for v3.15
In-Reply-To: <5328549D.1090008@samsung.com>
References: <5328549D.1090008@samsung.com>
Message-ID: <201403290253.14497.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 March 2014, Kukjin Kim wrote:
> The following changes since commit 86feafebbec2b510daf36ffbdbe10228ed890b00:
> 
>    ARM: dts: use macros in clock bindings for exynos5440 (2014-02-26 
> 09:53:31 +0900)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/samsung-dt-2
> 
> for you to fetch changes up to ba0d7ed391b7b3fb5ca98d9cf4d067b7f5ed956b:
> 
>    ARM: dts: enable ahci sata and sata phy for exynos5250 (2014-03-18 
> 07:49:14 +0900)
> 
> ----------------------------------------------------------------
> Samsung 2nd DT updates for v3.15
> - add DT entry for AHCI SATA and SATA PHY with using generic
>    PHY framework for exynos5250 and arndale, smdk5250 boards.
> - add SSS DT node for exynos5420 and exynos5250
> - remove leftover spi0 node for smdk5250 board
> - add ADC and thermistor nodes for exynos4412-trats2 board
> - move common irq-combiner node for exynos4x12 from exynos4212
>    and exynos4412
> - add ADC, PMU and GPS_ALIVE power domain nodes for exynos4x12
> 
> Note that based on previous tags/samsung-dt and tags/exynos-clk
> 
> ----------------------------------------------------------------
> Chanwoo Choi (5):
>        ARM: dts: Add ADC's dt data to read raw data for exynos4x12
>        ARM: dts: Add PMU dt data to support PMU for exynos4x12
>        ARM: dts: Add GPS_ALIVE power domain for exynos4x12
>        ARM: dts: Move common dt data for interrupt combiner controller 
> for exynos4x12
>        ARM: dts: Add ADC and themistor nodes for exynos4412-trats2
> 
> Mark Brown (1):
>        ARM: dts: Remove leftover spi0 node for smdk5250
> 
> Naveen Krishna Chatradhi (1):
>        ARM: dts: add dt node for sss module for exynos5250/5420
> 
> Yuvaraj Kumar C D (1):
>        ARM: dts: enable ahci sata and sata phy for exynos5250
> 
>   .../devicetree/bindings/ata/exynos-sata-phy.txt    | 14 ---------
>   .../devicetree/bindings/ata/exynos-sata.txt        | 25 +++++++++------
>   .../devicetree/bindings/phy/samsung-phy.txt        | 36 
> ++++++++++++++++++++++

Looking through the branch contents, I noticed that the examples in the
bindings contain mandatory properties that are not documented.

I have merged your branch into next/cleanup3 of the arm-soc tree,
but I also applied a patch on top to document the missing strings
and properties. It is currently the top commit on the branch, so
if anyone spots a mistake, we can probably rectify it.

Please be more careful with binding documentation in the future.
Was this actually reviewed on the devicetree-discuss mailing list?

	Arnd

9<-----
>From 9dfbff16b422a4bac7ad309847c7bc5d65653392 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 29 Mar 2014 02:15:43 +0100
Subject: [PATCH] devicetree: fix newly added exynos sata bindings

Commit ba0d7ed391b7b "ARM: dts: enable ahci sata and sata phy for
exynos5250" added a new binding document for the sata phy device,
and changed the sata controller binding. However, in both cases
significant aspects of the binding remained undocumented.
This attempts to reconstruct the actual binding from the usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>

diff --git a/Documentation/devicetree/bindings/ata/exynos-sata.txt b/Documentation/devicetree/bindings/ata/exynos-sata.txt
index b2adb1f..cb48448 100644
--- a/Documentation/devicetree/bindings/ata/exynos-sata.txt
+++ b/Documentation/devicetree/bindings/ata/exynos-sata.txt
@@ -8,8 +8,14 @@ Required properties:
 - interrupts		: <interrupt mapping for SATA IRQ>
 - reg			: <registers mapping>
 - samsung,sata-freq	: <frequency in MHz>
-- phys			: as mentioned in phy-bindings.txt
-- phy-names		: as mentioned in phy-bindings.txt
+- phys			: Must contain exactly one entry as specified
+			  in phy-bindings.txt
+- phy-names		: Must be "sata-phy"
+
+Optional properties:
+- clocks		: Must contain an entry for each entry in clock-names.
+- clock-names		: Shall be "sata" for the external SATA bus clock,
+			  and "sclk_sata" for the internal controller clock.
 
 Example:
 	sata at 122f0000 {
diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index a937f75..67d38b3 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -30,7 +30,11 @@ Each SATA PHY controller should have its own node.
 Required properties:
 - compatible        : compatible list, contains "samsung,exynos5250-sata-phy"
 - reg : offset and length of the SATA PHY register set;
-- #phy-cells : from the generic phy bindings;
+- #phy-cells : must be zero
+- clocks : must be exactly one entry
+- clock-names : must be "sata_phyctrl"
+- samsung,exynos-sataphy-i2c-phandle : a phandle to the I2C device, no arguments
+- samsung,syscon-phandle : a phandle to the PMU system controller, no arguments
 
 Example:
 	sata_phy: sata-phy at 12170000 {
