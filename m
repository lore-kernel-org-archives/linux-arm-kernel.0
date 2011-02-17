From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Feb 2011 14:28:50 +0800
Subject: [PATCH 2/4] ARM: mx23: dynamically allocate mx23 auart device
In-Reply-To: <1297924132-17402-1-git-send-email-shawn.guo@freescale.com>
References: <1297924132-17402-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1297924132-17402-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX23 Reference Manaul starts auart index from 1 than 0.  Changing
the index to start from 0 requires corresponding changes on base
address, irq, and iomux definitions, and will probably confuse people
who reads codes and hardware documents together.

This patch introduced the field 'hwid' to distinguish the driver id
and controller id.  These two ids are different on mx23 while
identical on mx28.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c             |    1 +
 arch/arm/mach-mxs/devices-mx23.h           |    5 +++++
 arch/arm/mach-mxs/devices/platform-auart.c |   22 ++++++++++++++++------
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index ca72a05..7c5dace 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -442,6 +442,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
 	/* for amba-pl011 driver */
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
+	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
 	_REGISTER_CLOCK(NULL, "usb", usb_clk)
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index 1256788..c4d4773 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -14,3 +14,8 @@
 extern const struct amba_device mx23_duart_device __initconst;
 #define mx23_add_duart() \
 	mxs_add_duart(&mx23_duart_device)
+
+extern const struct mxs_auart_data mx23_auart_data[] __initconst;
+#define mx23_add_auart(id)	mxs_add_auart(&mx23_auart_data[id])
+#define mx23_add_auart0()		mx23_add_auart(0)
+#define mx23_add_auart1()		mx23_add_auart(1)
diff --git a/arch/arm/mach-mxs/devices/platform-auart.c b/arch/arm/mach-mxs/devices/platform-auart.c
index f0dbf8a..796606c 100644
--- a/arch/arm/mach-mxs/devices/platform-auart.c
+++ b/arch/arm/mach-mxs/devices/platform-auart.c
@@ -7,23 +7,33 @@
  * Free Software Foundation.
  */
 #include <asm/sizes.h>
+#include <mach/mx23.h>
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
 
-#define mxs_auart_data_entry_single(soc, _id)				\
+#define mxs_auart_data_entry_single(soc, _id, hwid)			\
 	{								\
 		.id = _id,						\
-		.iobase = soc ## _AUART ## _id ## _BASE_ADDR,		\
-		.irq = soc ## _INT_AUART ## _id,			\
+		.iobase = soc ## _AUART ## hwid ## _BASE_ADDR,		\
+		.irq = soc ## _INT_AUART ## hwid,			\
 	}
 
-#define mxs_auart_data_entry(soc, _id)					\
-	[_id] = mxs_auart_data_entry_single(soc, _id)
+#define mxs_auart_data_entry(soc, _id, hwid)				\
+	[_id] = mxs_auart_data_entry_single(soc, _id, hwid)
+
+#ifdef CONFIG_SOC_IMX23
+const struct mxs_auart_data mx23_auart_data[] __initconst = {
+#define mx23_auart_data_entry(_id, hwid)				\
+	mxs_auart_data_entry(MX23, _id, hwid)
+	mx23_auart_data_entry(0, 1),
+	mx23_auart_data_entry(1, 2),
+};
+#endif
 
 #ifdef CONFIG_SOC_IMX28
 const struct mxs_auart_data mx28_auart_data[] __initconst = {
 #define mx28_auart_data_entry(_id)					\
-	mxs_auart_data_entry(MX28, _id)
+	mxs_auart_data_entry(MX28, _id, _id)
 	mx28_auart_data_entry(0),
 	mx28_auart_data_entry(1),
 	mx28_auart_data_entry(2),
-- 
1.7.1
