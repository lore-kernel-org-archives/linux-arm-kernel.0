From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Wed,  6 May 2015 10:49:02 +0200
Subject: [RESEND] [PATCH v2 2/2] arm: boot: convert ATAG_REVISION to DT
 revision field
In-Reply-To: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1430902142-17035-3-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ATAG_REVISION is unsigned number and revision in DT is stored as hexadecimal
string value. It means that it will be correctly parsed by kernel.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/compressed/atags_to_fdt.c |   37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 9448aa0..b23748e 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -97,6 +97,39 @@ static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
 	setprop_string(fdt, "/chosen", "bootargs", cmdline);
 }
 
+static void tohexstr(char * str, int size, unsigned int num)
+{
+	int len = 0;
+	int i, tmp;
+
+	if (size < 4) {
+		if (size > 0)
+			str[0] = 0;
+		return;
+	}
+
+	str[len++] = '0';
+	str[len++] = 'x';
+
+	while (len-1 < size && num) {
+		tmp = num % 16;
+		if (tmp >= 10)
+			tmp += 'A';
+		else
+			tmp += '0';
+		str[len++] = tmp;
+		num /= 16;
+	}
+
+	str[len] = 0;
+
+	for (i = 2; i < 2+(len-2)/2; ++i) {
+		tmp = str[i];
+		str[i] = str[len-i+1];
+		str[len-i+1] = tmp;
+	}
+}
+
 /*
  * Convert and fold provided ATAGs into the provided FDT.
  *
@@ -171,6 +204,10 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 					cpu_to_fdt32(atag->u.mem.size);
 			}
 
+		} else if (atag->hdr.tag == ATAG_REVISION) {
+			char revision[11];
+			tohexstr(revision, sizeof(revision), atag->u.revision.rev);
+			setprop_string(fdt, "/", "revision", revision);
 		} else if (atag->hdr.tag == ATAG_INITRD2) {
 			uint32_t initrd_start, initrd_size;
 			initrd_start = atag->u.initrd.start;
-- 
1.7.9.5
