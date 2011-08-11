From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 10 Aug 2011 18:31:32 -0700
Subject: [PATCH v2 3/3] ARM: i.MX53: clean up iomux-mx53.h
In-Reply-To: <1313026292-945-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1313026292-945-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1313026292-945-3-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delete about 1,000 symbols used only once

I used the following script to clean up the file.

cp iomux-mx53.h iomux-mx53.h.cpy

sed -n iomux-mx53.h.cpy \
-e 's/#define[ \x09]\+\(_MX5[0-9a-zA-Z_]*\)[ \x09]\+\(.\+\)/s@\1@\2 at g/p' >t.tmp

sed iomux-mx53.h.cpy \
-e '/define[ \x09]\+_MX5/d' \
-f t.tmp \
-e 's/,[ \x09]*\([^,]\+\)/, \1/g' \
-e 's/, 0)[ \x09]*|[ \x09]*MUX_PAD_CTRL(/, /' \
-e 's/(IOMUX_PAD(\(.*\)))/IOMUX_PAD(\1)/' \
-e 's/0x\([0-9a-fA-F]\{2\}\)[ \x09]*,/0x0\1,/' \
-e 's/NON_PAD_I/__NA_/' \
-e 's/0x0,/__NA_,/' \
-e 's/#define[ \x09]\+\(MX5[0-9a-zA-Z_]*\)[ \x09]\+\(IOMUX_PAD.\+\)/#define \1\x09\2/' \
-e 's/\(#define MX5[^\x09]\{5,12\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\x09\x09\x09\2/' \
-e 's/\(#define MX5[^\x09]\{13,20\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\x09\x09\2/' \
-e 's/\(#define MX5[^\x09]\{21,28\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\x09\2/' \
-e 's/\(#define MX5[^\x09]\{29,36\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\2/' \
-e 's/\(#define MX5[^\x09]\{45,\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\\\n\x09\x09\x09\x09\x09\x09\x09\2/' \
-e 's/, IOMUX_CONFIG_SION,/, 0 | IOMUX_CONFIG_SION,/' >iomux-mx53.h

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx53.h | 3527 +++++++++------------------
 1 files changed, 1184 insertions(+), 2343 deletions(-)


I didn't include the entire patch because it is too big for the mailing list.
Beside, you'll probably want to run the above script last thing before sending a pull
for a clean up branch to avoid conflicts.


diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index 9440b9e..4558484 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -23,7 +23,7 @@
 
 /* These 2 defines are for pins that may not have a mux register, but could
  * have a pad setting register, and vice-versa. */
-#define NON_PAD_I	0x00
+#define __NA_	0x00
 
 #define MX53_UART_PAD_CTRL		(PAD_CTL_PKE | PAD_CTL_PUE |	\
 		PAD_CTL_DSE_HIGH | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
@@ -31,2348 +31,1189 @@
 				PAD_CTL_PUS_47K_UP | PAD_CTL_DSE_HIGH | \
 				PAD_CTL_SRE_FAST)
 
-#define _MX53_PAD_GPIO_19__KPP_COL_5		IOMUX_PAD(0x348, 0x20, 0, 0x840, 0, 0)
-#define _MX53_PAD_GPIO_19__GPIO4_5		IOMUX_PAD(0x348, 0x20, 1, 0x0, 0, 0)
-#define _MX53_PAD_GPIO_19__CCM_CLKO		IOMUX_PAD(0x348, 0x20, 2, 0x0, 0, 0)
-#define _MX53_PAD_GPIO_19__SPDIF_OUT1	IOMUX_PAD(0x348, 0x20, 3, 0x0, 0, 0)
-#define _MX53_PAD_GPIO_19__RTC_CE_RTC_EXT_TRIG2	IOMUX_PAD(0x348, 0x20, 4, 0x0, 0, 0)
-#define _MX53_PAD_GPIO_19__ECSPI1_RDY	IOMUX_PAD(0x348, 0x20, 5, 0x0, 0, 0)
-#define _MX53_PAD_GPIO_19__FEC_TDATA_3	IOMUX_PAD(0x348, 0x20, 6, 0x0, 0, 0)
-#define _MX53_PAD_GPIO_19__SRC_INT_BOOT	IOMUX_PAD(0x348, 0x20,7, 0x0, 0, 0)
-#define _MX53_PAD_KEY_COL0__KPP_COL_0	IOMUX_PAD(0x34C, 0x24, 0, 0x0, 0, 0)
.........
.........
 
-#define MX53_PAD_GPIO_19__KPP_COL_5		(_MX53_PAD_GPIO_19__KPP_COL_5 | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX53_PAD_GPIO_19__GPIO4_5		(_MX53_PAD_GPIO_19__GPIO4_5 | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX53_PAD_GPIO_19__CCM_CLKO		(_MX53_PAD_GPIO_19__CCM_CLKO | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX53_PAD_GPIO_19__SPDIF_OUT1		(_MX53_PAD_GPIO_19__SPDIF_OUT1 | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX53_PAD_GPIO_19__RTC_CE_RTC_EXT_TRIG2		(_MX53_PAD_GPIO_19__RTC_CE_RTC_EXT_TRIG2 | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX53_PAD_GPIO_19__ECSPI1_RDY		(_MX53_PAD_GPIO_19__ECSPI1_RDY | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX53_PAD_GPIO_19__FEC_TDATA_3		(_MX53_PAD_GPIO_19__FEC_TDATA_3 | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX53_PAD_GPIO_19__SRC_INT_BOOT		(_MX53_PAD_GPIO_19__SRC_INT_BOOT | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX53_PAD_KEY_COL0__KPP_COL_0		(_MX53_PAD_KEY_COL0__KPP_COL_0 | MUX_PAD_CTRL(NO_PAD_CTRL))
.........
.........
+#define MX53_PAD_GPIO_19__KPP_COL_5			IOMUX_PAD(0x348, 0x020, 0, 0x840, 0, NO_PAD_CTRL)
+#define MX53_PAD_GPIO_19__GPIO4_5			IOMUX_PAD(0x348, 0x020, 1, __NA_, 0, NO_PAD_CTRL)
+#define MX53_PAD_GPIO_19__CCM_CLKO			IOMUX_PAD(0x348, 0x020, 2, __NA_, 0, NO_PAD_CTRL)
+#define MX53_PAD_GPIO_19__SPDIF_OUT1			IOMUX_PAD(0x348, 0x020, 3, __NA_, 0, NO_PAD_CTRL)
+#define MX53_PAD_GPIO_19__RTC_CE_RTC_EXT_TRIG2		IOMUX_PAD(0x348, 0x020, 4, __NA_, 0, NO_PAD_CTRL)
+#define MX53_PAD_GPIO_19__ECSPI1_RDY			IOMUX_PAD(0x348, 0x020, 5, __NA_, 0, NO_PAD_CTRL)
+#define MX53_PAD_GPIO_19__FEC_TDATA_3			IOMUX_PAD(0x348, 0x020, 6, __NA_, 0, NO_PAD_CTRL)
+#define MX53_PAD_GPIO_19__SRC_INT_BOOT			IOMUX_PAD(0x348, 0x020, 7, __NA_, 0, NO_PAD_CTRL)
+#define MX53_PAD_KEY_COL0__KPP_COL_0			IOMUX_PAD(0x34C, 0x024, 0, __NA_, 0, NO_PAD_CTRL)
.........
.........
 
 #endif	/* __MACH_IOMUX_MX53_H__ */
-- 
1.7.0.4
