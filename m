From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 23:27:54 +0200
Subject: [PATCH 06/10] ARM: davinci: don't use broken ntosd2_init_i2c
In-Reply-To: <1344461278-28245-1-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
Message-ID: <1344461278-28245-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ntosd2_init_i2c walks the ntosd2_i2c_info array, which it expects to
be populated with at least one member. gcc correctly warns about
the out-of-bounds access here.

Without this patch, building davinci_all_defconfig results in:

arch/arm/mach-davinci/board-neuros-osd2.c: In function 'davinci_ntosd2_init':
arch/arm/mach-davinci/board-neuros-osd2.c:187:20: warning: array subscript is above array bounds [-Warray-bounds]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Andrey Porodko <panda@chelcom.ru>
---
 arch/arm/mach-davinci/board-neuros-osd2.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 5de69f2..9d40df9 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -162,6 +162,7 @@ static void __init davinci_ntosd2_map_io(void)
 	dm644x_init();
 }
 
+#if 0
 /*
  I2C initialization
 */
@@ -193,6 +194,12 @@ static	int ntosd2_init_i2c(void)
 	}
 	return status;
 }
+#else
+static  int ntosd2_init_i2c(void)
+{
+	return 0;
+}
+#endif
 
 static struct davinci_mmc_config davinci_ntosd2_mmc_config = {
 	.wires		= 4,
-- 
1.7.10
