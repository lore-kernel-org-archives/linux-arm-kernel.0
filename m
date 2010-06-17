From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Thu, 17 Jun 2010 09:59:03 +0200
Subject: [PATCH 2/4] arch/arm/mach-kirkwood: add support for 88F6282-A0
	revision
In-Reply-To: <20100617075711.15387.69398.stgit@localhost.localdomain>
References: <20100617075711.15387.69398.stgit@localhost.localdomain>
Message-ID: <20100617075903.15387.69442.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Benjamin Zores <benjamin.zores@alcatel-lucent.com>
---
 arch/arm/mach-kirkwood/common.c                |   10 +++++++++-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    5 ++++-
 arch/arm/mach-kirkwood/mpp.c                   |    2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 6072eaa..94f629d 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -402,7 +402,7 @@ void __init kirkwood_sdio_init(struct mvsdio_platform_data *mvsdio_data)
 	u32 dev, rev;
 
 	kirkwood_pcie_id(&dev, &rev);
-	if (rev == 0)  /* catch all Kirkwood Z0's */
+	if (rev == 0 && dev != MV88F6282_DEV_ID)  /* catch all Kirkwood Z0's and 6282 */
 		mvsdio_data->clock = 100000000;
 	else
 		mvsdio_data->clock = 200000000;
@@ -851,6 +851,9 @@ int __init kirkwood_find_tclk(void)
 					rev == MV88F6281_REV_A1))
 		return 200000000;
 
+	if (dev == MV88F6282_DEV_ID)
+		return 200000000;
+
 	return 166666667;
 }
 
@@ -886,6 +889,11 @@ static char * __init kirkwood_id(void)
 			return "MV88F6281-A1";
 		else
 			return "MV88F6281-Rev-Unsupported";
+	} if (dev == MV88F6282_DEV_ID) {
+		if (rev == MV88F6282_REV_A0)
+			return "MV88F6282-A0";
+		else
+			return "MV88F6282-Rev-Unsupported";
 	} else if (dev == MV88F6192_DEV_ID) {
 		if (rev == MV88F6192_REV_Z0)
 			return "MV88F6192-Z0";
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index a15cf0e..a571860 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -2,7 +2,7 @@
  * arch/arm/mach-kirkwood/include/mach/kirkwood.h
  *
  * Generic definitions for Marvell Kirkwood SoC flavors:
- *  88F6180, 88F6192 and 88F6281.
+ *  88F6180, 88F6192, 88F6281 and 88F6282.
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
@@ -104,6 +104,9 @@
 #define MV88F6281_REV_A0	2
 #define MV88F6281_REV_A1	3
 
+#define MV88F6282_DEV_ID	0x6282
+#define MV88F6282_REV_A0	0
+
 #define MV88F6192_DEV_ID	0x6192
 #define MV88F6192_REV_Z0	0
 #define MV88F6192_REV_A0	2
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index a5900f6..330a5a1 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -25,6 +25,8 @@ static unsigned int __init kirkwood_variant(void)
 
 	if (dev == MV88F6281_DEV_ID && rev >= MV88F6281_REV_A0)
 		return MPP_F6281_MASK;
+	if (dev == MV88F6282_DEV_ID && rev >= MV88F6282_REV_A0)
+		return MPP_F6282_MASK;
 	if (dev == MV88F6192_DEV_ID && rev >= MV88F6192_REV_A0)
 		return MPP_F6192_MASK;
 	if (dev == MV88F6180_DEV_ID)
