From: geliangtang@163.com (Geliang Tang)
Date: Thu, 26 Nov 2015 08:35:27 +0800
Subject: [PATCH v3] ARM: davinci: fix a problematic usage of WARN()
In-Reply-To: <19146462.9tlorCPL8k@wuerfel>
Message-ID: <fc8f1f2ff507111312243282dc462d00411eb4fe.1448497781.git.geliangtang@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARN() takes a condition and a format string. The condition was
omitted. So I added it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
Changes in v3:
 - fix kbuild test robot error.
Changes in v2:
 - remove __func__ in WARN()
---
 arch/arm/mach-davinci/board-dm355-evm.c     | 4 +---
 arch/arm/mach-davinci/board-dm355-leopard.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index c71dd99..1844076 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -384,9 +384,7 @@ static __init void dm355_evm_init(void)
 	dm355evm_dm9000_rsrc[2].start = gpio_to_irq(1);
 
 	aemif = clk_get(&dm355evm_dm9000.dev, "aemif");
-	if (IS_ERR(aemif))
-		WARN("%s: unable to get AEMIF clock\n", __func__);
-	else
+	if (!WARN(IS_ERR(aemif), "unable to get AEMIF clock\n"))
 		clk_prepare_enable(aemif);
 
 	platform_add_devices(davinci_evm_devices,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 680a7a2..284ff27 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -242,9 +242,7 @@ static __init void dm355_leopard_init(void)
 	dm355leopard_dm9000_rsrc[2].start = gpio_to_irq(9);
 
 	aemif = clk_get(&dm355leopard_dm9000.dev, "aemif");
-	if (IS_ERR(aemif))
-		WARN("%s: unable to get AEMIF clock\n", __func__);
-	else
+	if (!WARN(IS_ERR(aemif), "unable to get AEMIF clock\n"))
 		clk_prepare_enable(aemif);
 
 	platform_add_devices(davinci_leopard_devices,
-- 
2.5.0
