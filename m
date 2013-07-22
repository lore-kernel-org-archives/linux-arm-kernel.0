From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Jul 2013 01:49:22 +0200
Subject: [PATCH v2 5/8] ARM: s3c64xx: dma: Use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1374536965-3545-6-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies s3c64xx DMA driver to prepare and unprepare clocks
in addition to enableind and disabling, since it is required by common
clock framework.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 759846c..c511dfa 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -677,7 +677,7 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 		goto err_map;
 	}
 
-	clk_enable(dmac->clk);
+	clk_prepare_enable(dmac->clk);
 
 	dmac->regs = regs;
 	dmac->chanbase = chbase;
@@ -711,7 +711,7 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 	return 0;
 
 err_clk:
-	clk_disable(dmac->clk);
+	clk_disable_unprepare(dmac->clk);
 	clk_put(dmac->clk);
 err_map:
 	iounmap(regs);
-- 
1.8.3.2
