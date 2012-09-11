From: b32955@freescale.com (Huang Shijie)
Date: Tue, 11 Sep 2012 14:17:11 +0800
Subject: [PATCH 9/9] mtd: gpmi: initialize the timing registers only one time
In-Reply-To: <1347344231-10295-1-git-send-email-b32955@freescale.com>
References: <1347344231-10295-1-git-send-email-b32955@freescale.com>
Message-ID: <1347344231-10295-10-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code initialize the timing registers at very time
we call the gpmi_begin(). This really wastes the cpu cycles.

Add a flag to let the gpmi driver initializes the timing registers
only one time.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |    8 ++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 7efd326..c374236 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -914,6 +914,9 @@ static int enable_edo_mode(struct gpmi_nand_data *this, int mode)
 	rate = (mode == 5) ? 100000000 : 80000000;
 	clk_set_rate(r->clock[0], rate);
 
+	/* Let the gpmi_begin() re-compute the timing again. */
+	this->flags &= ~GPMI_TIMING_INIT_OK;
+
 	this->flags |= GPMI_ASYNC_EDO_ENABLED;
 	this->timing_mode = mode;
 	pr_info("gpmi-nand enters asynchronous EDO mode %d\n", mode);
@@ -964,6 +967,11 @@ void gpmi_begin(struct gpmi_nand_data *this)
 		goto err_out;
 	}
 
+	/* Only initialize the timing once */
+	if (this->flags & GPMI_TIMING_INIT_OK)
+		return;
+	this->flags |= GPMI_TIMING_INIT_OK;
+
 	if (this->flags & GPMI_ASYNC_EDO_ENABLED)
 		gpmi_compute_edo_timing(this, &hw);
 	else
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index fe52a3b..1e01a03 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -124,6 +124,7 @@ struct nand_timing {
 struct gpmi_nand_data {
 	/* flags */
 #define GPMI_ASYNC_EDO_ENABLED	(1 << 0)
+#define GPMI_TIMING_INIT_OK	(1 << 1)
 	int			flags;
 
 	/* System Interface */
-- 
1.7.0.4
