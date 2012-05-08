From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 8 May 2012 09:22:35 +0530
Subject: [PATCH V3 Resend 08/12] net/c_can: Remove conditional compilation of
 clk code
In-Reply-To: <cover.1336448639.git.viresh.kumar@st.com>
References: <cover.1336448639.git.viresh.kumar@st.com>
Message-ID: <5bde77a369c9bf2eb2efbd9f8d139443336ff849.1336448639.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
macros.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Bhupesh Sharma <bhupesh.sharma@st.com>
---
 drivers/net/can/c_can/c_can_platform.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 5e1a5ff..7ec9316 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -73,7 +73,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	struct c_can_priv *priv;
 	struct resource *mem;
 	int irq;
-#ifdef CONFIG_HAVE_CLK
 	struct clk *clk;
 
 	/* get the appropriate clk */
@@ -83,7 +82,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto exit;
 	}
-#endif
 
 	/* get the platform data */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -118,10 +116,8 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 
 	dev->irq = irq;
 	priv->regs = addr;
-#ifdef CONFIG_HAVE_CLK
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
-#endif
 
 	switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
 	case IORESOURCE_MEM_32BIT:
@@ -157,10 +153,8 @@ exit_iounmap:
 exit_release_mem:
 	release_mem_region(mem->start, resource_size(mem));
 exit_free_clk:
-#ifdef CONFIG_HAVE_CLK
 	clk_put(clk);
 exit:
-#endif
 	dev_err(&pdev->dev, "probe failed\n");
 
 	return ret;
@@ -181,9 +175,7 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 
-#ifdef CONFIG_HAVE_CLK
 	clk_put(priv->priv);
-#endif
 
 	return 0;
 }
-- 
1.7.9
