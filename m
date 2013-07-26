From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:30 +0800
Subject: [PATCH v6 08/11] ARM: pxa: init dma debugfs in late level
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-9-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove pxa_init_dma() from core_initcall level since it's unncecssary
for DT mode. But dma debugfs is also included in pxa_init_dma().
So only initiliaze dma debugfs in late_initcall level.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/mmp2.c   |  2 +-
 arch/arm/mach-mmp/pxa168.c |  2 +-
 arch/arm/mach-mmp/pxa910.c |  2 +-
 arch/arm/plat-pxa/dma.c    | 30 ++++++++++++++++++++----------
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index f26ea9d..a0abfd7 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -114,7 +114,6 @@ static int __init mmp2_init(void)
 
 	return 0;
 }
-postcore_initcall(mmp2_init);
 
 #define APBC_TIMERS	APBC_REG(0x024)
 
@@ -122,6 +121,7 @@ void __init mmp2_timer_init(void)
 {
 	unsigned long clk_rst;
 
+	mmp2_init();
 	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 
 	/*
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index b6b3d5b..a332d51 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -61,7 +61,6 @@ static int __init pxa168_init(void)
 
 	return 0;
 }
-postcore_initcall(pxa168_init);
 
 /* system timer - clock enabled, 3.25MHz */
 #define TIMER_CLK_RST	(APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(3))
@@ -69,6 +68,7 @@ postcore_initcall(pxa168_init);
 
 void __init pxa168_timer_init(void)
 {
+	pxa168_init();
 	/* this is early, we have to initialize the CCU registers by
 	 * ourselves instead of using clk_* API. Clock rate is defined
 	 * by APBC_TIMERS_CLK_RST (3.25MHz) and enabled free-running
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index df379c2..1a84800 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -100,7 +100,6 @@ static int __init pxa910_init(void)
 
 	return 0;
 }
-postcore_initcall(pxa910_init);
 
 /* system timer - clock enabled, 3.25MHz */
 #define TIMER_CLK_RST	(APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(3))
@@ -108,6 +107,7 @@ postcore_initcall(pxa910_init);
 
 void __init pxa910_timer_init(void)
 {
+	pxa910_init();
 	/* reset and configure */
 	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index 79ef102..6c5472b 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -228,36 +228,46 @@ err_state:
 	return NULL;
 }
 
-static void pxa_dma_init_debugfs(void)
+static int __init pxa_dma_init_debugfs(void)
 {
-	int i;
+	int i, ret;
 	struct dentry *chandir;
 
 	dbgfs_root = debugfs_create_dir(DMA_DEBUG_NAME, NULL);
-	if (IS_ERR(dbgfs_root) || !dbgfs_root)
+	if (IS_ERR(dbgfs_root) || !dbgfs_root) {
+		ret = -EINVAL;
 		goto err_root;
+	}
 
 	dbgfs_state = debugfs_create_file("state", 0400, dbgfs_root, NULL,
 					  &dbg_fops_state);
-	if (!dbgfs_state)
+	if (!dbgfs_state) {
+		ret = -EINVAL;
 		goto err_state;
+	}
 
 	dbgfs_chan = kmalloc(sizeof(*dbgfs_state) * num_dma_channels,
 			     GFP_KERNEL);
-	if (!dbgfs_chan)
+	if (!dbgfs_chan) {
+		ret = -ENOMEM;
 		goto err_alloc;
+	}
 
 	chandir = debugfs_create_dir("channels", dbgfs_root);
-	if (!chandir)
+	if (!chandir) {
+		ret = -EINVAL;
 		goto err_chandir;
+	}
 
 	for (i = 0; i < num_dma_channels; i++) {
 		dbgfs_chan[i] = pxa_dma_dbg_alloc_chan(i, chandir);
-		if (!dbgfs_chan[i])
+		if (!dbgfs_chan[i]) {
+			ret = -EINVAL;
 			goto err_chans;
+		}
 	}
 
-	return;
+	return 0;
 err_chans:
 err_chandir:
 	kfree(dbgfs_chan);
@@ -266,7 +276,9 @@ err_state:
 	debugfs_remove_recursive(dbgfs_root);
 err_root:
 	pr_err("pxa_dma: debugfs is not available\n");
+	return ret;
 }
+late_initcall(pxa_dma_init_debugfs);
 
 static void __exit pxa_dma_cleanup_debugfs(void)
 {
@@ -385,7 +397,5 @@ int __init pxa_init_dma(int irq, int num_ch)
 	}
 	num_dma_channels = num_ch;
 
-	pxa_dma_init_debugfs();
-
 	return 0;
 }
-- 
1.8.1.2
