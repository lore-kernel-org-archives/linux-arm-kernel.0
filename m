From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 03 Nov 2016 15:21:23 +0900
Subject: [PATCH 01/13] mmc: dw_mmc: display the real register value on debugfs
In-Reply-To: <20161103062135.10697-1-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Message-ID: <20161103062135.10697-2-jh80.chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Developer wants to see the real register value, not register offset.
This patch fixed to display the real value of register.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1c9ee36..b87dd07 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -165,12 +165,14 @@ static const struct file_operations dw_mci_req_fops = {
 
 static int dw_mci_regs_show(struct seq_file *s, void *v)
 {
-	seq_printf(s, "STATUS:\t0x%08x\n", SDMMC_STATUS);
-	seq_printf(s, "RINTSTS:\t0x%08x\n", SDMMC_RINTSTS);
-	seq_printf(s, "CMD:\t0x%08x\n", SDMMC_CMD);
-	seq_printf(s, "CTRL:\t0x%08x\n", SDMMC_CTRL);
-	seq_printf(s, "INTMASK:\t0x%08x\n", SDMMC_INTMASK);
-	seq_printf(s, "CLKENA:\t0x%08x\n", SDMMC_CLKENA);
+	struct dw_mci *host = s->private;
+
+	seq_printf(s, "STATUS:\t0x%08x\n", mci_readl(host, STATUS));
+	seq_printf(s, "RINTSTS:\t0x%08x\n", mci_readl(host, RINTSTS));
+	seq_printf(s, "CMD:\t0x%08x\n", mci_readl(host, CMD));
+	seq_printf(s, "CTRL:\t0x%08x\n", mci_readl(host, CTRL));
+	seq_printf(s, "INTMASK:\t0x%08x\n", mci_readl(host, INTMASK));
+	seq_printf(s, "CLKENA:\t0x%08x\n", mci_readl(host, CLKENA));
 
 	return 0;
 }
-- 
2.10.1
