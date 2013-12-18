From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 18 Dec 2013 13:09:11 +0100
Subject: [PATCH V2 8/8] board: add Samsung specific board support
In-Reply-To: <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1387368551-18958-9-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for Samsung's Trats  and Trats2 boards is added.

TODO:
Kernel uses some memory space right after uImage, overwriting the very first
appended device tree blob. As a workaround, a fake 32kB dtb is appended first.

Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes for V2:
 - none

 board-exynos.c                 |   77 ++++++++++++++++++++++++++++++++++++++++
 configs/Makefile.config.exynos |   13 +++++++
 2 files changed, 90 insertions(+)
 create mode 100644 board-exynos.c
 create mode 100644 configs/Makefile.config.exynos

diff --git a/board-exynos.c b/board-exynos.c
new file mode 100644
index 0000000..2769a5f
--- /dev/null
+++ b/board-exynos.c
@@ -0,0 +1,77 @@
+#include "atags.h"
+#include "board.h"
+#include "dtbs.h"
+#include "print.h"
+#include "register.h"
+#include "types.h"
+
+extern u32 _binary_input_zImage_start;
+extern u32 _binary_dtbs_bin_start;
+
+struct board board;
+
+#define EXYNOS_PRO_ID		0x10000000
+#define EXYNOS_PRO_ID_SHIFT	12
+
+struct exynos_board {
+	u32		proid;
+	u32		system_rev;
+	const char	*compatible;
+};
+
+static struct exynos_board exboards[] = {
+	/* Controller */
+	{
+		.proid		= 0xe4412,
+		.system_rev	= 0,
+		.compatible	= "samsung,trats2",
+	},
+	{
+		.proid		= 0x43210,
+		.system_rev	= 0,
+		.compatible	= "samsung,trats",
+	},
+	{ 0, 0, NULL }	/* sentinel */
+};
+
+static void panic(void)
+{
+	while (1)
+		;
+}
+
+static u32 get_proid()
+{
+	return readl(EXYNOS_PRO_ID) >> EXYNOS_PRO_ID_SHIFT;
+}
+
+struct board *match_board(u32 machid, const struct tag *tags)
+{
+	struct exynos_board *exboard;
+	u32 proid;
+
+	proid = get_proid();
+
+	for (exboard = exboards; exboard->proid; exboard++) {
+		if (exboard->proid == proid)
+			break;
+	}
+
+	if (exboard->compatible == NULL) {
+		putstr("ERROR MATCHING BOARD!\n");
+		panic(); /* doesn't return */
+	}
+
+	board.kernel = &_binary_input_zImage_start;
+	board.compatible = exboard->compatible;
+	board.dtb = find_dtb(&_binary_dtbs_bin_start, exboard->compatible);
+
+	if (board.dtb == NULL) {
+		putstr("NO DTB BLOB FOUND FOR ");
+		putstr(exboard->compatible);
+		putstr("\n");
+		panic(); /* doesn't return */
+	}
+
+	return &board;
+}
diff --git a/configs/Makefile.config.exynos b/configs/Makefile.config.exynos
new file mode 100644
index 0000000..7933338
--- /dev/null
+++ b/configs/Makefile.config.exynos
@@ -0,0 +1,13 @@
+# config for Exynos boards
+
+CROSS_COMPILE=arm-linux-gnueabi-
+MFG=exynos
+UART=exynos
+UART_PORT=2
+BINFMT=elf32-littlearm
+LOADADDR=0x41008000
+UART_BASE=0x40100000
+APPEND_KERNEL=input/zImage
+APPEND_DTBS=input/padd32k.bin input/exynos4210-trats.dtb input/exynos4412-trats2.dtb
+LIBFDT = y
+NR_BANKS=8
\ No newline at end of file
-- 
1.7.9.5
