From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:38 +0000
Subject: [RFC v3 PATCH 20/25] ARM: i.MX: remove map_io callback
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-21-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to define map_io only for debug_ll_io_init() since it
is already called in devicemaps_init() if map_io is NULL.

Apart from that, for NOMMU build debug_ll_io_init() is a nop which
leads to following error:

CC      arch/arm/mach-imx/mach-imx1.o
arch/arm/mach-imx/mach-imx1.c:40:13: error: 'debug_ll_io_init' undeclared here (not in a function)
  .map_io  = debug_ll_io_init,
             ^
make[1]: *** [arch/arm/mach-imx/mach-imx1.o] Error 1

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mach-imx/mach-imx1.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx1.c b/arch/arm/mach-imx/mach-imx1.c
index de5ab8d..3a8406e 100644
--- a/arch/arm/mach-imx/mach-imx1.c
+++ b/arch/arm/mach-imx/mach-imx1.c
@@ -37,7 +37,6 @@ static void __init imx1_init_irq(void)
 };
 
 DT_MACHINE_START(IMX1_DT, "Freescale i.MX1 (Device Tree Support)")
-	.map_io		= debug_ll_io_init,
 	.init_early	= imx1_init_early,
 	.init_irq	= imx1_init_irq,
 	.dt_compat	= imx1_dt_board_compat,
-- 
1.7.9.5
