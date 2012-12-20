From: Barry.Song@csr.com (Barry Song)
Date: Thu, 20 Dec 2012 20:13:53 +0800
Subject: [PATCH 3/9] ARM: PRIMA2: initialize l2x0 according to mach from DT
In-Reply-To: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
References: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1356005639-23466-4-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

prima2 and marco have diffetent l2 cache configuration, so
we initialize l2x0 cache based on dtb given to kernel.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/l2x0.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index c998377..909cc6f 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -16,6 +16,11 @@ static struct of_device_id prima2_l2x0_ids[]  = {
 	{},
 };
 
+static struct of_device_id marco_l2x0_ids[]  = {
+	{ .compatible = "sirf,marco-pl310-cache" },
+	{},
+};
+
 static int __init sirfsoc_l2x0_init(void)
 {
 	struct device_node *np;
@@ -26,6 +31,15 @@ static int __init sirfsoc_l2x0_init(void)
 		return l2x0_of_init(0x40000, 0);
 	}
 
+	np = of_find_matching_node(NULL, marco_l2x0_ids);
+	if (np) {
+		pr_info("Initializing marco L2 cache\n");
+		/* Way size: 32KB Associativity: 16-way */
+		return l2x0_of_init((2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
+			(1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
+			L2X0_AUX_CTRL_MASK);
+	}
+
 	return 0;
 }
 early_initcall(sirfsoc_l2x0_init);
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog@www.csr.com/blog
