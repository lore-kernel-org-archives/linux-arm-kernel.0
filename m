From: arve@android.com (=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=)
Date: Mon, 14 Feb 2011 22:11:15 -0800
Subject: [PATCH 7/8] ARM: etm: Return the entire trace buffer if it is empty
	after reset
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Message-ID: <1297750276-12475-7-git-send-email-arve@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some SOCs the read and write pointer are reset when the chip
resets, but the trace buffer content is preserved. If the status
bits indicates that the buffer is empty and we have never started
tracing, assume the buffer is full instead. This can be useful
if the system rebooted from a watchdog reset.

Signed-off-by: Arve Hj?nnev?g <arve@android.com>
---
 arch/arm/kernel/etm.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 8126beb..4ad1257 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -44,6 +44,7 @@ struct tracectx {
 	unsigned long	range_end;
 	unsigned long	data_range_start;
 	unsigned long	data_range_end;
+	bool		dump_initial_etb;
 	struct device	*dev;
 	struct clk	*emu_clk;
 	struct mutex	mutex;
@@ -105,6 +106,7 @@ static int trace_start(struct tracectx *t)
 
 	etb_unlock(t);
 
+	t->dump_initial_etb = false;
 	etb_writel(t, 0, ETBR_WRITEADDR);
 	etb_writel(t, 0, ETBR_FORMATTERCTRL);
 	etb_writel(t, 1, ETBR_CTRL);
@@ -311,6 +313,8 @@ static ssize_t etb_read(struct file *file, char __user *data,
 	etb_unlock(t);
 
 	total = etb_getdatalen(t);
+	if (total == 0 && t->dump_initial_etb)
+		total = t->etb_bufsz;
 	if (total == t->etb_bufsz)
 		first = etb_readl(t, ETBR_WRITEADDR);
 
@@ -385,6 +389,7 @@ static int __init etb_probe(struct amba_device *dev, struct amba_id *id)
 		goto out_release;
 	}
 
+	t->dump_initial_etb = true;
 	amba_set_drvdata(dev, t);
 
 	etb_unlock(t);
-- 
1.7.3.1
