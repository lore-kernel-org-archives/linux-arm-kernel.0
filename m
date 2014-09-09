From: m.chehab@samsung.com (Mauro Carvalho Chehab)
Date: Tue,  9 Sep 2014 15:54:05 -0300
Subject: [PATCHv3 2/3] [media] s5p-jpeg: Fix compilation with COMPILE_TEST
In-Reply-To: <5f850d5d45a27c50dabf3da08689cbedf986841b.1410288748.git.m.chehab@samsung.com>
References: <6cbd00c5f2d342b573aaf9c0e533778374dd2e1e.1410273306.git.m.chehab@samsung.com>
 <5f850d5d45a27c50dabf3da08689cbedf986841b.1410288748.git.m.chehab@samsung.com>
Message-ID: <e9793025e2d9a18dacfc302e2f032f2f49f9f746.1410288748.git.m.chehab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ERROR: "__bad_ndelay" [drivers/media/platform/s5p-jpeg/s5p-jpeg.ko] undefined!

That happens because asm-generic doesn't like any ndelay time
bigger than 20us.

Currently, usleep_range() couldn't simply be used, since
exynos4_jpeg_sw_reset() is called with a spinlock held.

So, let's use udelay() instead.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
index e51c078360f5..ab6d6f43c96f 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
@@ -23,7 +23,7 @@ void exynos4_jpeg_sw_reset(void __iomem *base)
 	reg = readl(base + EXYNOS4_JPEG_CNTL_REG);
 	writel(reg & ~EXYNOS4_SOFT_RESET_HI, base + EXYNOS4_JPEG_CNTL_REG);
 
-	ndelay(100000);
+	udelay(100);
 
 	writel(reg | EXYNOS4_SOFT_RESET_HI, base + EXYNOS4_JPEG_CNTL_REG);
 }
-- 
1.9.3
