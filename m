From: tony.kn@samsung.com (Tony K Nadackal)
Date: Fri, 19 Dec 2014 13:07:59 +0530
Subject: [PATCH v2 1/2] [media] s5p-jpeg: Fix modification sequence of
 interrupt enable register
In-Reply-To: <1418974680-5837-1-git-send-email-tony.kn@samsung.com>
References: <1418974680-5837-1-git-send-email-tony.kn@samsung.com>
Message-ID: <1418974680-5837-2-git-send-email-tony.kn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the bug in modifying the interrupt enable register.

Signed-off-by: Tony K Nadackal <tony.kn@samsung.com>
---
 drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
index e53f13a..a61ff7e 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
@@ -155,7 +155,10 @@ void exynos4_jpeg_set_enc_out_fmt(void __iomem *base, unsigned int out_fmt)
 
 void exynos4_jpeg_set_interrupt(void __iomem *base)
 {
-	writel(EXYNOS4_INT_EN_ALL, base + EXYNOS4_INT_EN_REG);
+	unsigned int reg;
+
+	reg = readl(base + EXYNOS4_INT_EN_REG) & ~EXYNOS4_INT_EN_MASK;
+	writel(reg | EXYNOS4_INT_EN_ALL, base + EXYNOS4_INT_EN_REG);
 }
 
 unsigned int exynos4_jpeg_get_int_status(void __iomem *base)
-- 
2.2.0
