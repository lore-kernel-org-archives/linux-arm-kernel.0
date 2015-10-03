From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat,  3 Oct 2015 13:03:48 -0700
Subject: [PATCH 3.10-3.17] ARM: orion: Fix DSA platform device after mvmdio
 conversion
In-Reply-To: <1443902628-7861-1-git-send-email-f.fainelli@gmail.com>
References: <1443902628-7861-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1443902628-7861-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DSA expects the host_dev pointer to be the device structure associated
with the MDIO bus controller driver. First commit breaking that was
c3a07134e6aa ("mv643xx_eth: convert to use the Marvell Orion MDIO
driver"), and then, it got completely under the radar for a while.

Reported-by: Frans van de Wiel" <fvdw@fvdw.eu>
Fixes: c3a07134e6aa ("mv643xx_eth: convert to use the Marvell Orion MDIO driver")
CC: stable at vger.kernel.org
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
This patch is for -stable kernels 3.10 to 3.17 (included)

 arch/arm/plat-orion/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 3ec6e8e8d368..3f02575e4cc8 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -499,7 +499,7 @@ void __init orion_ge00_switch_init(struct dsa_platform_data *d, int irq)
 
 	d->netdev = &orion_ge00.dev;
 	for (i = 0; i < d->nr_chips; i++)
-		d->chip[i].mii_bus = &orion_ge00_shared.dev;
+		d->chip[i].mii_bus = &orion_ge_mvmdio.dev;
 	orion_switch_device.dev.platform_data = d;
 
 	platform_device_register(&orion_switch_device);
-- 
2.1.0
