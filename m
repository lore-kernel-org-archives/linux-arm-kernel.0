From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Nov 2013 17:26:46 +0100
Subject: [PATCH 3/4] ARM: mvebu: use the virtual CPU registers to access
 coherency registers
In-Reply-To: <1385396807-19027-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1385396807-19027-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1385396807-19027-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The Armada XP provides a mechanism called "virtual CPU registers" or
"per-CPU register banking", to access the per-CPU registers of the
current CPU, without having to worry about finding on which CPU we're
running. CPU0 has its registers at 0x21800, CPU1 at 0x21900, CPU2 at
0x21A00 and CPU3 at 0x21B00. The virtual registers accessing the
current CPU registers are at 0x21000.

However, in the Device Tree node that provides the register addresses
for the coherency unit (which is responsible for ensuring coherency
between processors, and I/O coherency between processors and the
DMA-capable devices), a mistake was made: the CPU0-specific registers
were specified instead of the virtual CPU registers. This means that
the coherency barrier needed for I/O coherency was not behaving
properly when executed from a CPU different from CPU0. This patch
fixes that by using the virtual CPU registers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: stable at vger.kernel.org
---
This bug has been introduced in e60304f8cb7bb5 ("arm: mvebu: Add
hardware I/O Coherency support"), merged in v3.8. Therefore this fix
should be backported into -stable all the way to 3.8. Due to various
reorganizations in the DT file, the patch will certainly not apply as
is, but the fix itself is trivial.
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 00d6a79..7f10f62 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -118,7 +118,7 @@
 
 			coherency-fabric at 20200 {
 				compatible = "marvell,coherency-fabric";
-				reg = <0x20200 0xb0>, <0x21810 0x1c>;
+				reg = <0x20200 0xb0>, <0x21010 0x1c>;
 			};
 
 			serial at 12000 {
-- 
1.8.1.2
