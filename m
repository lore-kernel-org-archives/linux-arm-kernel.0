From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 21:44:11 +0100
Subject: [PATCH v5 07/11] ARM: at91: select ATMEL_EBI when compiling a kernel
 for at91sam9 or sama5d3
In-Reply-To: <1417639455-17410-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417639455-17410-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417639455-17410-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91sam9* and sama5d* SoCs have an EBI (External Bus Interface).
Select the ATMEL_EBI driver when support for these SoCs is selected.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../bindings/memory-controllers/atmel-ebi.txt          | 18 +++++++++---------
 arch/arm/mach-at91/Kconfig                             |  2 ++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
index 3749ea1..68af1ad 100644
--- a/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
@@ -16,6 +16,7 @@ Required properties:
 			"atmel,at91sam9261-ebi"
 			"atmel,at91sam9263-ebi0"
 			"atmel,at91sam9263-ebi1"
+			"atmel,at91sam9rl-ebi"
 			"atmel,at91sam9g45-ebi"
 			"atmel,at91sam9x5-ebi"
 			"atmel,sama5d3-ebi"
@@ -51,15 +52,14 @@ Required child cs node properties:
 			memory layout.
 
 Optional child cs node properties:
-- atmel,generic-dev		boolean property specifying if the device is
-				a generic device.
+- atmel,specialized-logic	boolean property specifying if the device is
+				a connected to a specialized logic:
+				NAND, Compact Flash, SDR-SDRAM.
 				The following properties are only parsed if
-				this property is present.
-				Specialized devices are attached to specialized
-				controllers which are responsible for
-				configuring the bus appropriately.
-				Here are some examples of specialized
-				controllers: NAND, CompactFlash, SDR-SDRAM.
+				this property is absent.
+				If this property is set, specialized controller
+				drivers are responsible for configuring the bus
+				appropriately.
 
 - atmel,bus-width:		width of the asynchronous device's data bus
 				8, 16 or 32.
@@ -99,7 +99,7 @@ present 0 is assumed):
 - atmel,tdf-optimized		data float optimized mode. If present the data
 				float time is optimized depending on the next
 				device being accessed (next device setup
-				time is substracted to the current devive data
+				time is subtracted to the current device data
 				float time).
 
 
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 0e6d548..78b1412 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -49,6 +49,7 @@ config SOC_AT91SAM9
 	select GENERIC_CLOCKEVENTS
 	select MEMORY if USE_OF
 	select ATMEL_SDRAMC if USE_OF
+	select ATMEL_EBI
 
 config SOC_SAMA5
 	bool
@@ -58,6 +59,7 @@ config SOC_SAMA5
 	select USE_OF
 	select MEMORY
 	select ATMEL_SDRAMC
+	select ATMEL_EBI
 
 menu "Atmel AT91 System-on-Chip"
 
-- 
1.9.1
