From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  3 Jun 2013 18:45:37 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
Message-ID: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Willy Tarreau <w@1wt.eu>

Marvell uses a specific atag in its u-boot which includes among other
information the MAC addresses for up to 4 network interfaces. This
atag is parsed, and if found the MAC addresses are extracted there and
assigned to node aliases eth0..3 with the name "mac-address".

This allows, with the non-DT capable bootloaders currently used on
most Marvell platforms, to get a proper MAC address for the different
interfaces.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c |  8 +++++++-
 arch/arm/include/uapi/asm/setup.h       | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index aabc02a..7f405ed 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -16,7 +16,7 @@ static int node_offset(void *fdt, const char *node_path)
 }
 
 static int setprop(void *fdt, const char *node_path, const char *property,
-		   uint32_t *val_array, int size)
+		   void *val_array, int size)
 {
 	int offset = node_offset(fdt, node_path);
 	if (offset < 0)
@@ -147,6 +147,12 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 					initrd_start);
 			setprop_cell(fdt, "/chosen", "linux,initrd-end",
 					initrd_start + initrd_size);
+		} else if (atag->hdr.tag == ATAG_MV_UBOOT) {
+			/* This ATAG provides up to 4 MAC addresses */
+			setprop(fdt, "eth0", "mac-address", atag->u.mv_uboot.macaddr[0], 6);
+			setprop(fdt, "eth1", "mac-address", atag->u.mv_uboot.macaddr[1], 6);
+			setprop(fdt, "eth2", "mac-address", atag->u.mv_uboot.macaddr[2], 6);
+			setprop(fdt, "eth3", "mac-address", atag->u.mv_uboot.macaddr[3], 6);
 		}
 	}
 
diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/asm/setup.h
index 979ff40..5588b1f 100644
--- a/arch/arm/include/uapi/asm/setup.h
+++ b/arch/arm/include/uapi/asm/setup.h
@@ -143,6 +143,19 @@ struct tag_memclk {
 	__u32 fmemclk;
 };
 
+/* Marvell uboot parameters */
+#define ATAG_MV_UBOOT	0x41000403
+
+struct tag_mv_uboot {
+	__u32 uboot_version;
+	__u32 tclk;
+	__u32 sysclk;
+	__u32 isusbhost;
+	__u8  macaddr[4][6];
+	__u16 mtu[4];
+	__u32 nand_ecc;
+};
+
 struct tag {
 	struct tag_header hdr;
 	union {
@@ -165,6 +178,11 @@ struct tag {
 		 * DC21285 specific
 		 */
 		struct tag_memclk	memclk;
+
+		/*
+		 * Marvell specific
+		 */
+		struct tag_mv_uboot	mv_uboot;
 	} u;
 };
 
-- 
1.8.1.2
