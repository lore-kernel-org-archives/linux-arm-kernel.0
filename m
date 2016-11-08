From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  8 Nov 2016 17:31:32 +0100
Subject: [PATCH] arm64: dts: marvell: add unique identifiers for Armada A8k
 SPI controllers
Message-ID: <1478622692-18441-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling SPI controllers, which are attached to different busses
inside an SoC, may result in overlapping enumeration and cause
sysfs registration failure. Example log after enabling two
controllers on Armada 8040 SoC with same identifiers:

[    3.740415] sysfs: cannot create duplicate filename
'/class/spi_master/spi0'
[    3.747510] ------------[ cut here ]------------
[    3.752145] WARNING: at fs/sysfs/dir.c:31
[...]
[    4.002299] orion_spi: probe of f4700600.spi failed with error -17

spi-orion driver offers dedicated DT property ('cell-index'), that
allow setting unique identifiers. Recently added support for CP110-slave
HW block introduced two new SPI controllers' nodes with same ID as
ones from CP110-master.

This commit fixes the issue by assigning different 'cell-index' values
for CP110-slave SPI controllers.

Fixes: 4eef78a0091b ("arm64: dts: marvell: add description for the slave
CP110 in Armada 8K")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index abb3fa2..d94d592 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -132,7 +132,7 @@
 				reg = <0x700600 0x50>;
 				#address-cells = <0x1>;
 				#size-cells = <0x0>;
-				cell-index = <1>;
+				cell-index = <3>;
 				clocks = <&cps_syscon0 1 21>;
 				status = "disabled";
 			};
@@ -142,7 +142,7 @@
 				reg = <0x700680 0x50>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				cell-index = <2>;
+				cell-index = <4>;
 				clocks = <&cps_syscon0 1 21>;
 				status = "disabled";
 			};
-- 
1.8.3.1
