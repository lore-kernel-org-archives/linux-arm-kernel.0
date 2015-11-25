From: geliangtang@163.com (Geliang Tang)
Date: Wed, 25 Nov 2015 22:13:13 +0800
Subject: [PATCH v2] ARM: davinci: fix a problematic usage of WARN()
In-Reply-To: <12268783.CeI9Q9YHFN@wuerfel>
Message-ID: <50fd45fb78403b66381569a8c9ada6b17433e2d9.1448460525.git.geliangtang@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARN() takes a condition and a format string. The condition was
omitted. So I added it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
Changes in v2:
 - remove __func__ in WARN()
---
 arch/arm/mach-davinci/board-dm355-evm.c     | 4 +---
 arch/arm/mach-davinci/board-dm355-leopard.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index c71dd99..3c79796 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -384,9 +384,7 @@ static __init void dm355_evm_init(void)
 	dm355evm_dm9000_rsrc[2].start = gpio_to_irq(1);
 
 	aemif = clk_get(&dm355evm_dm9000.dev, "aemif");
-	if (IS_ERR(aemif))
-		WARN("%s: unable to get AEMIF clock\n", __func__);
-	else
+	if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
 		clk_prepare_enable(aemif);
 
 	platform_add_devices(davinci_evm_devices,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 680a7a2..627ba89 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -242,9 +242,7 @@ static __init void dm355_leopard_init(void)
 	dm355leopard_dm9000_rsrc[2].start = gpio_to_irq(9);
 
 	aemif = clk_get(&dm355leopard_dm9000.dev, "aemif");
-	if (IS_ERR(aemif))
-		WARN("%s: unable to get AEMIF clock\n", __func__);
-	else
+	if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
 		clk_prepare_enable(aemif);
 
 	platform_add_devices(davinci_leopard_devices,
-- 
2.5.0
