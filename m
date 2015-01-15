From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 15 Jan 2015 15:08:03 +0800
Subject: [PATCH] ARM: at91: dts: sama5d3/sama5d4: reduce NFC command registers
 memory region
Message-ID: <1421305683-8739-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get NFC status, we need to read the NFC command registers, which is a
256M memory mapping address. To check the status, you just read such
address from NFC command registers.
For example, to check NFCBUSY (bit 27), you need to read 0x08000000
(bit 27 is set to 1) of the NFC command register.
If you want to check NFCBUSY (bit 27) and NFCWR (bit 26) in same time,
you need to read 0x0c000000 (bit 27 and bit 26 are set to 1).

But mapping such huge memory address only for multiple NFC status check
is not very economic.

The economic way is we check the NFC status one bit a time, then we don't
have to mapping such huge address.

Now we reduce the memory mapping from 256M to 128M+4 (include 0x08000000),
the only difference is NFCBUSY (bit 27) status. You cannot check NFCBUSY
bit with other NFC status bit.

Since current atmel_nand driver check the NFCBUSY status without combine
other bits, so this change (reduce 256M to 128M+4) will not be harmful.

Signed-off-by: Josh Wu <josh.wu@atmel.com>

---

 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index d701ddd..d243732 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1426,7 +1426,7 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <
-					0x70000000 0x10000000	/* NFC Command Registers */
+					0x70000000 0x08000004	/* NFC Command Registers */
 					0xffffc000 0x00000070	/* NFC HSMC regs */
 					0x00200000 0x00100000	/* NFC SRAM banks */
 					>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 0a2477f..05b096b 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -288,7 +288,7 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 				reg = <
-					0x90000000 0x10000000	/* NFC Command Registers */
+					0x90000000 0x08000004	/* NFC Command Registers */
 					0xfc05c000 0x00000070	/* NFC HSMC regs */
 					0x00100000 0x00100000	/* NFC SRAM banks */
                                          >;
-- 
1.9.1
