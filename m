From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 23 Apr 2012 17:34:14 +0300
Subject: [PATCH] staging: tidspbridge: fix build errors for OMAP2_L4_IO_ADDRESS
Message-ID: <1335191654-1217-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'

The proper fix will come later.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/include/dspbridge/dbdefs.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/tidspbridge/include/dspbridge/dbdefs.h b/drivers/staging/tidspbridge/include/dspbridge/dbdefs.h
index c8f4645..f9a0d16 100644
--- a/drivers/staging/tidspbridge/include/dspbridge/dbdefs.h
+++ b/drivers/staging/tidspbridge/include/dspbridge/dbdefs.h
@@ -28,6 +28,14 @@
 #define PG_ALIGN_LOW(addr, pg_size) ((addr) & PG_MASK(pg_size))
 #define PG_ALIGN_HIGH(addr, pg_size) (((addr)+(pg_size)-1) & PG_MASK(pg_size))
 
+/*
+ * NOTE: Please update to use ioremap + read/write
+ */
+
+#define OMAP2_L4_IO_OFFSET	0xb2000000
+#define IOMEM(x)		((void __force __iomem *)(x))
+#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET)
+
 /* API return value and calling convention */
 #define DBAPI                       int
 
-- 
1.7.10
