From: arve@android.com (=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=)
Date: Wed,  2 Feb 2011 18:54:21 -0800
Subject: [PATCH 3/5] ARM: etm: Don't trigger another overflow when trying to
	clear the RAM-full status
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Message-ID: <1296701663-12168-3-git-send-email-arve@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the write address was at the end of the buffer, toggling the trace
capture bit would set the RAM-full status instead of clearing it.

Signed-off-by: Arve Hj?nnev?g <arve@android.com>
---
 arch/arm/kernel/etm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 2ea0b7c..7652e9f 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -235,6 +235,7 @@ static void etm_dump(void)
 	printk(KERN_INFO "\n--- ETB buffer end ---\n");
 
 	/* deassert the overflow bit */
+	etb_writel(t, 0, ETBR_WRITEADDR);
 	etb_writel(t, 1, ETBR_CTRL);
 	etb_writel(t, 0, ETBR_CTRL);
 
@@ -300,6 +301,7 @@ static ssize_t etb_read(struct file *file, char __user *data,
 		buf[i] = etb_readl(t, ETBR_READMEM);
 
 	/* the only way to deassert overflow bit in ETB status is this */
+	etb_writel(t, 0, ETBR_WRITEADDR);
 	etb_writel(t, 1, ETBR_CTRL);
 	etb_writel(t, 0, ETBR_CTRL);
 
-- 
1.7.3.1
