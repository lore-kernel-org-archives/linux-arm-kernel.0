From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Jul 2013 13:53:01 -0300
Subject: [PATCH 3/3] ARM: imx: mm-imx3: Free l2x0_base
In-Reply-To: <20130709182046.GD516@pengutronix.de>
References: <1373306318-15604-1-git-send-email-festevam@gmail.com>
 <1373306318-15604-3-git-send-email-festevam@gmail.com>
 <20130709062414.GG16656@S2101-09.ap.freescale.net>
 <CAOMZO5D4ivbqYovVA2CpXEemrAq8Nyn5By8-iL3SAnw=mpJ+og@mail.gmail.com>
 <20130709182046.GD516@pengutronix.de>
Message-ID: <CAOMZO5AeJVRL3VhLdYPtAq7-9+Dh3o=ntwhqYOrZZeR7TbBDyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jul 9, 2013 at 3:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> l2x0_base is passed to l2x0_init which uses it for the outer cache
> maintenance operations. I wonder this doesn't crash your kernel.

l2x0_init() is called from arch/arm/mach-imx/mm-imx3.c first and then
from arch/arm/mm/cache-l2x0.c
later.

Why do we need to call it twice?

Can't we just do:

diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 0884ca9..94f3b4f 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -85,7 +85,6 @@ static void __iomem *imx3_ioremap_caller(phys_addr_t
phys_addr, size_t size,
 static void __init imx3_init_l2x0(void)
 {
 #ifdef CONFIG_CACHE_L2X0
-	void __iomem *l2x0_base;
 	void __iomem *clkctl_base;

 /*
@@ -105,14 +104,6 @@ static void __init imx3_init_l2x0(void)
 	} else {
 		pr_err("L2 cache: Cannot fix timing. Trying to continue without\n");
 	}
-
-	l2x0_base = ioremap(MX3x_L2CC_BASE_ADDR, 4096);
-	if (!l2x0_base) {
-		printk(KERN_ERR "remapping L2 cache area failed\n");
-		return;
-	}
-
-	l2x0_init(l2x0_base, 0x00030024, 0x00000000);
 #endif
 }
