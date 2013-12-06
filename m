From: broonie@kernel.org (Mark Brown)
Date: Fri,  6 Dec 2013 11:57:07 +0000
Subject: [PATCH] ARM: cpu: Document and tweak clock-frequency property
Message-ID: <1386331027-26065-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

The ARMv7 topology code uses the ePAPR specified mandatory clock-frequency
property to determine the relative performances of the CPUs along with the
CPU type. However with FDT we don't update to take account of the current
speed and if the cores are not running at full speed on boot then a device
tree which is accurate on boot can provide incorrect information about the
relative performances of the cores.

Document the current usage both to override ePAPR and to make the binding
within the kernel more complete. Ideally the kernel would use information
from the CPU frequency scaling drivers here but they may in turn consider
this property and such changes are likely to be part of the energy aware
scheduling work so not immediately available.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 91304353eea4..e3726f6bca92 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -191,6 +191,15 @@ nodes to be present and contain the properties described below.
 			  property identifying a 64-bit zero-initialised
 			  memory location.
 
+	- clock-frequency
+		Usage: required
+		Value type: <u32> or <u64>
+		Definition:
+			This is specified in ePAPR as the current clock
+			frequency of the CPU.  When used with these
+			extensions it should reflect the maximum clock
+			frequency for the CPU.
+
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
 	cpus {
-- 
1.8.5.1
