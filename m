From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 27 Sep 2018 19:38:09 +0100
Subject: [PATCH] ARM: zImage: atags_to_fdt: add serial-number for ATAG_SERIAL
Message-ID: <20180927183809.23051-1-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the system passes an ATAG_SERIAL, convert that into a /serial-number
node so that the system serial number will be present under the kernel.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/boot/compressed/atags_to_fdt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 41fa7316c52b..330cd3c2eae5 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -98,6 +98,24 @@ static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
 	setprop_string(fdt, "/chosen", "bootargs", cmdline);
 }
 
+static void hex_str(char *out, uint32_t value)
+{
+	uint32_t digit;
+	int idx;
+
+	for (idx = 7; idx >= 0; idx--) {
+		digit = value >> 28;
+		value <<= 4;
+		digit &= 0xf;
+		if (digit < 10)
+			digit += '0';
+		else
+			digit += 'A'-10;
+		*out++ = digit;
+	}
+	*out = '\0';
+}
+
 /*
  * Convert and fold provided ATAGs into the provided FDT.
  *
@@ -180,6 +198,11 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 					initrd_start);
 			setprop_cell(fdt, "/chosen", "linux,initrd-end",
 					initrd_start + initrd_size);
+		} else if (atag->hdr.tag == ATAG_SERIAL) {
+			char serno[16+2];
+			hex_str(serno, atag->u.serialnr.high);
+			hex_str(serno+8, atag->u.serialnr.low);
+			setprop_string(fdt, "/", "serial-number", serno);
 		}
 	}
 
-- 
2.19.0
