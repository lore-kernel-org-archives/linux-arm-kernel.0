From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 17:24:51 +0100
Subject: [PATCH 2/3] ARM: orion: mark orion_ge00_mvmdio_bus_name as const
In-Reply-To: <20180220162519.1498223-1-arnd@arndb.de>
References: <20180220162519.1498223-1-arnd@arndb.de>
Message-ID: <20180220162519.1498223-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A section type mismatch warning shows up when building with LTO,
since orion_ge00_mvmdio_bus_name was put in __initconst but not marked
const itself:

include/linux/of.h: In function 'spear_setup_of_timer':
arch/arm/mach-spear/time.c:207:34: error: 'timer_of_match' causes a section type conflict with 'orion_ge00_mvmdio_bus_name'
 static const struct of_device_id timer_of_match[] __initconst = {
                                  ^
arch/arm/plat-orion/common.c:475:32: note: 'orion_ge00_mvmdio_bus_name' was declared here
 static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
                                ^

This marks it const as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-orion/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index aff6994950ba..4e1d8270537c 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -472,7 +472,7 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 /*****************************************************************************
  * Ethernet switch
  ****************************************************************************/
-static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
+static __initconst const char *const orion_ge00_mvmdio_bus_name = "orion-mii";
 static __initdata struct mdio_board_info
 		  orion_ge00_switch_board_info;
 
-- 
2.9.0
