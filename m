From: lisovy@gmail.com (Rostislav Lisovy)
Date: Mon,  8 Sep 2014 10:05:32 +0200
Subject: =?UTF-8?q?=5BPATCH=20RESEND=5D=20ARM=3A=20PCI=3A=20Use=20PCI=5FCLASS=5F*=20defines=20for=20PCI=20class?=
Message-ID: <1410163532-31057-1-git-send-email-lisovy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
Reviewed-by: Yijing Wang <wangyijing@huawei.com>
---
The header file include/linux/pci_ids.h defines
#define PCI_CLASS_BRIDGE_OTHER????????? 0x0680
#define PCI_CLASS_SYSTEM_DMA??????????? 0x0801

((struct pci_dev*)dev)->class
corresponds to the 3 bytes Class code in the PCI Configuration space
header -- 1B Base class, 1B Sub-class, 1B Reg-level interface.

In that case
(PCI_CLASS_BRIDGE_OTHER << 8)
is equivalent to 0x68000 (imagine the leading zero)
and
((PCI_CLASS_SYSTEM_DMA << 8) | 0x03))
is equivalent to 0x80103.


 arch/arm/kernel/bios32.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c1..e511ad1 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -255,10 +255,9 @@ static void pci_fixup_it8152(struct pci_dev *dev)
 {
 	int i;
 	/* fixup for ITE 8152 devices */
-	/* FIXME: add defines for class 0x68000 and 0x80103 */
 	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST ||
-	    dev->class == 0x68000 ||
-	    dev->class == 0x80103) {
+	    dev->class == (PCI_CLASS_BRIDGE_OTHER << 8) ||
+	    dev->class == ((PCI_CLASS_SYSTEM_DMA << 8) | 0x03)) {
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			dev->resource[i].start = 0;
 			dev->resource[i].end   = 0;
-- 
1.7.10.4
