From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Mon,  7 Jan 2013 12:21:44 +0100
Subject: [PATCH 02/16] dmaengine: ste_dma40: use writel_relaxed for lcxa
In-Reply-To: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
References: <1357557718-15676-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1357557718-15676-3-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@stericsson.com>

lcpa and lcla are written often and the cache_sync() overhead in writel
is costly, especially for wlan where every single network packet (in RX
mode) corresponds to a separate DMA transfer.

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
Reviewed-by: Narayanan Gopalakrishnan <narayanan.gopalakrishnan@stericsson.com>
Reviewed-by: Rabin Vincent <rabin.vincent@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/dma/ste_dma40_ll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ste_dma40_ll.c b/drivers/dma/ste_dma40_ll.c
index d64b72a..1cfe7ab 100644
--- a/drivers/dma/ste_dma40_ll.c
+++ b/drivers/dma/ste_dma40_ll.c
@@ -332,10 +332,10 @@ void d40_log_lli_lcpa_write(struct d40_log_lli_full *lcpa,
 {
 	d40_log_lli_link(lli_dst, lli_src, next, flags);
 
-	writel(lli_src->lcsp02, &lcpa[0].lcsp0);
-	writel(lli_src->lcsp13, &lcpa[0].lcsp1);
-	writel(lli_dst->lcsp02, &lcpa[0].lcsp2);
-	writel(lli_dst->lcsp13, &lcpa[0].lcsp3);
+	writel_relaxed(lli_src->lcsp02, &lcpa[0].lcsp0);
+	writel_relaxed(lli_src->lcsp13, &lcpa[0].lcsp1);
+	writel_relaxed(lli_dst->lcsp02, &lcpa[0].lcsp2);
+	writel_relaxed(lli_dst->lcsp13, &lcpa[0].lcsp3);
 }
 
 void d40_log_lli_lcla_write(struct d40_log_lli *lcla,
@@ -345,10 +345,10 @@ void d40_log_lli_lcla_write(struct d40_log_lli *lcla,
 {
 	d40_log_lli_link(lli_dst, lli_src, next, flags);
 
-	writel(lli_src->lcsp02, &lcla[0].lcsp02);
-	writel(lli_src->lcsp13, &lcla[0].lcsp13);
-	writel(lli_dst->lcsp02, &lcla[1].lcsp02);
-	writel(lli_dst->lcsp13, &lcla[1].lcsp13);
+	writel_relaxed(lli_src->lcsp02, &lcla[0].lcsp02);
+	writel_relaxed(lli_src->lcsp13, &lcla[0].lcsp13);
+	writel_relaxed(lli_dst->lcsp02, &lcla[1].lcsp02);
+	writel_relaxed(lli_dst->lcsp13, &lcla[1].lcsp13);
 }
 
 static void d40_log_fill_lli(struct d40_log_lli *lli,
-- 
1.7.12.1
