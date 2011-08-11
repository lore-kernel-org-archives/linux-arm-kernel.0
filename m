From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 10 Aug 2011 18:31:31 -0700
Subject: [PATCH v2 2/3] ARM: i.MX51: clean up iomux-mx51.h
In-Reply-To: <1313026292-945-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1313026292-945-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1313026292-945-2-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delete about 700 used only once symbols.

I used the following script to clean up the file,
iomux-mx51.h.

cp iomux-mx51.h iomux-mx51.h.cpy

sed -n iomux-mx51.h.cpy \
-e 's/#define[ \x09]\+\(_MX5[0-9a-zA-Z_]*\)[ \x09]\+\(.\+\)/s@\1@\2 at g/p' >t.tmp

sed iomux-mx51.h.cpy \
-e '/define[ \x09]\+_MX5/d' \
-f t.tmp \
-e 's/,[ \x09]*\([^,]\+\)/, \1/g' \
-e 's/, 0)[ \x09]*|[ \x09]*MUX_PAD_CTRL(/, /' \
-e 's/(IOMUX_PAD(\(.*\)))/IOMUX_PAD(\1)/' \
-e 's/0x\([0-9a-fA-F]\{2\}\)[ \x09]*,/0x0\1,/' \
-e 's/0x0\([0-9a-fA-F]\{3\}\)[ \x09]*,/0x\1,/' \
-e '/#include <mach\/iomux-v3.h/ a#define __NA_\x090x000\n' \
-e 's/0x[0]\{1,3\},/__NA_,/' \
-e 's/#define[ \x09]\+\(MX5[0-9a-zA-Z_]*\)[ \x09]\+\(IOMUX_PAD.\+\)/#define \1\x09\2/' \
-e 's/\(#define MX5[^\x09]\{5,12\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\x09\x09\2/' \
-e 's/\(#define MX5[^\x09]\{13,20\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\x09\2/' \
-e 's/\(#define MX5[^\x09]\{21,28\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\x09\2/' \
-e 's/\(#define MX5[^\x09]\{29,36\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\2/' \
-e 's/\(#define MX5[^\x09]\{45,\}\)\x09\(IOMUX_PAD.\+\)/\1\x09\\\n\x09\x09\x09\x09\x09\x09\2/' \
-e 's/, IOMUX_CONFIG_SION,/, 0 | IOMUX_CONFIG_SION,/' \
-e 's/\((0x[0-9a-fA-F]*, 0x[0-9a-fA-F]*, \)0x0\([0-9a-fA-F]\{2\},\)/\10x\2/' >iomux-mx51.h

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx51.h | 2270 +++++++++------------------
 1 files changed, 758 insertions(+), 1512 deletions(-)

I didn't include the entire patch because it is too big for the mailing list.
Beside, you'll probably want to run the above script last thing before sending a pull
for a clean up branch to avoid conflicts.


diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index df6acc0..c7f5169 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -14,6 +14,8 @@
 #define __MACH_IOMUX_MX51_H__
 
 #include <mach/iomux-v3.h>
+#define __NA_	0x000
+
 
 /* Pad control groupings */
 #define MX51_UART_PAD_CTRL	(PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_DSE_HIGH | \
@@ -47,1521 +49,765 @@
 
 /* Raw pin modes without pad control */
 /*							  PAD    MUX ALT INPSE PATH PADCTRL */
-#define _MX51_PAD_EIM_D16__AUD4_RXFS		IOMUX_PAD(0x3f0, 0x5c, 5, 0x0000, 0, 0)
-#define _MX51_PAD_EIM_D16__AUD5_TXD		IOMUX_PAD(0x3f0, 0x5c, 7, 0x08d8, 0, 0)
-#define _MX51_PAD_EIM_D16__EIM_D16		IOMUX_PAD(0x3f0, 0x5c, 0, 0x0000, 0, 0)
-#define _MX51_PAD_EIM_D16__GPIO2_0		IOMUX_PAD(0x3f0, 0x5c, 1, 0x0000, 0, 0)
-#define _MX51_PAD_EIM_D16__I2C1_SDA		IOMUX_PAD(0x3f0, 0x5c, 0x14, 0x09b4, 0, 0)
-#define _MX51_PAD_EIM_D16__UART2_CTS		IOMUX_PAD(0x3f0, 0x5c, 3, 0x0000, 0, 0)
-#define _MX51_PAD_EIM_D16__USBH2_DATA0		IOMUX_PAD(0x3f0, 0x5c, 2, 0x0000, 0, 0)
-#define _MX51_PAD_EIM_D17__AUD5_RXD		IOMUX_PAD(0x3f4, 0x60, 7, 0x08d4, 0, 0)
.........
.........
 
 /* The same pins as above but with the default pad control values applied */
-#define MX51_PAD_EIM_D16__AUD4_RXFS		(_MX51_PAD_EIM_D16__AUD4_RXFS | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX51_PAD_EIM_D16__AUD5_TXD		(_MX51_PAD_EIM_D16__AUD5_TXD | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX51_PAD_EIM_D16__EIM_D16		(_MX51_PAD_EIM_D16__EIM_D16 | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX51_PAD_EIM_D16__GPIO2_0		(_MX51_PAD_EIM_D16__GPIO2_0 | MUX_PAD_CTRL(MX51_GPIO_PAD_CTRL))
-#define MX51_PAD_EIM_D16__I2C1_SDA		(_MX51_PAD_EIM_D16__I2C1_SDA | MUX_PAD_CTRL(MX51_I2C_PAD_CTRL))
-#define MX51_PAD_EIM_D16__UART2_CTS		(_MX51_PAD_EIM_D16__UART2_CTS | MUX_PAD_CTRL(MX51_UART_PAD_CTRL))
-#define MX51_PAD_EIM_D16__USBH2_DATA0		(_MX51_PAD_EIM_D16__USBH2_DATA0 | MUX_PAD_CTRL(NO_PAD_CTRL))
-#define MX51_PAD_EIM_D17__AUD5_RXD		(_MX51_PAD_EIM_D17__AUD5_RXD | MUX_PAD_CTRL(NO_PAD_CTRL))
.........
.........
+#define MX51_PAD_EIM_D16__AUD4_RXFS		IOMUX_PAD(0x3f0, 0x05c, 5, __NA_, 0, NO_PAD_CTRL)
+#define MX51_PAD_EIM_D16__AUD5_TXD		IOMUX_PAD(0x3f0, 0x05c, 7, 0x8d8, 0, NO_PAD_CTRL)
+#define MX51_PAD_EIM_D16__EIM_D16		IOMUX_PAD(0x3f0, 0x05c, 0, __NA_, 0, NO_PAD_CTRL)
+#define MX51_PAD_EIM_D16__GPIO2_0		IOMUX_PAD(0x3f0, 0x05c, 1, __NA_, 0, MX51_GPIO_PAD_CTRL)
+#define MX51_PAD_EIM_D16__I2C1_SDA		IOMUX_PAD(0x3f0, 0x05c, 0x14, 0x9b4, 0, MX51_I2C_PAD_CTRL)
+#define MX51_PAD_EIM_D16__UART2_CTS		IOMUX_PAD(0x3f0, 0x05c, 3, __NA_, 0, MX51_UART_PAD_CTRL)
+#define MX51_PAD_EIM_D16__USBH2_DATA0		IOMUX_PAD(0x3f0, 0x05c, 2, __NA_, 0, NO_PAD_CTRL)
+#define MX51_PAD_EIM_D17__AUD5_RXD		IOMUX_PAD(0x3f4, 0x060, 7, 0x8d4, 0, NO_PAD_CTRL)
.........
.........
 
 #endif /* __MACH_IOMUX_MX51_H__ */
-- 
1.7.0.4
