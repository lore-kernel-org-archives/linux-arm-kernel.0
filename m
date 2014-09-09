From: m.chehab@samsung.com (Mauro Carvalho Chehab)
Date: Tue, 09 Sep 2014 13:10:36 -0300
Subject: [PATCHv2 2/3] [media] s5p-jpeg: Fix compilation with COMPILE_TEST
In-Reply-To: <540F1D11.9030400@samsung.com>
References: <20140909124306.2d5a0d76@canb.auug.org.au>
 <6cbd00c5f2d342b573aaf9c0e533778374dd2e1e.1410273306.git.m.chehab@samsung.com>
 <b7343e6296b5d1d68b7229b8307442fd4141bcb3.1410273306.git.m.chehab@samsung.com>
 <540F15B2.3000902@samsung.com> <20140909120936.527bd852.m.chehab@samsung.com>
 <540F1D11.9030400@samsung.com>
Message-ID: <20140909131036.7265121f.m.chehab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ERROR: "__bad_ndelay" [drivers/media/platform/s5p-jpeg/s5p-jpeg.ko] undefined!

That happens because asm-generic doesn't like any ndelay time
bigger than 20us.

Currently, usleep_range() couldn't simply be used, since
exynos4_jpeg_sw_reset() is called with a spinlock held.

So, let's use ndelay() instead.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
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
