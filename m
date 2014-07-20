From: xerofoify@gmail.com (Nicholas Krause)
Date: Sun, 20 Jul 2014 00:06:19 -0400
Subject: [PATCH] arm: Fix me in bios32.c
Message-ID: <1405829179-19476-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixs a fix me in bios32.c for pci_fixup_it8152 as this if
statement is incorrect needs to be checked against the class bits
not the whole address for the two or conditions and since they don't
have define statements outside of their numeratical value.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/kernel/bios32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c1..b2217af 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -254,11 +254,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, pci_
 static void pci_fixup_it8152(struct pci_dev *dev)
 {
 	int i;
-	/* fixup for ITE 8152 devices */
-	/* FIXME: add defines for class 0x68000 and 0x80103 */
 	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST ||
-	    dev->class == 0x68000 ||
-	    dev->class == 0x80103) {
+	   (dev->class >> 8) == 0x680 ||
+	   (dev->class >> 8) == 0x801) {
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			dev->resource[i].start = 0;
 			dev->resource[i].end   = 0;
-- 
1.9.1
