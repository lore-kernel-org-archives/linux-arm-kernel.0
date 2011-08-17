From: joravec@drewtech.com (Joey Oravec)
Date: Wed, 17 Aug 2011 17:21:49 -0400
Subject: plat-orion problems with mv643xx_eth.c for mv78xx0
Message-ID: <4E4C30ED.9030902@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orion maintainers,

config MV643XX_ETH can be selected for Discovery series chips (mv78xx0), 
but it has some problems.

1. Register PSC1 (0x44C) bit 4 is named port_reset. It defaults to 1 
"port is reset". The documentation does not explain this bit, but the 
example code clears the bit to "port is not in reset". I needed to do 
the same thing and clear this bit on each port to get ethernet working:

===================================================================
--- mv643xx_eth.c
+++ mv643xx_eth.c
@@ -2597,6 +2597,9 @@
         if (msp->base == NULL)
                 goto out_free;

+       // Take the part out of reset?
+       writel(readl(msp->base + 0x44C) & (~(1 << 4)), msp->base + 0x44C);
+
         /*
          * Set up and register SMI bus.
          */

2. This is confusing, but not an error. There's a variable port_number 
in mv643xx_eth_platform_data that MUST be zero for each port on a 
Discovery (MV78xx0) series processor. The printk will say "port 0" for 
all 4 ports, but it must be zero so the driver calculates a valid 
offset. This probably deserves a comment or a change in the printk.

3. This is confusing, but not an error. File mach/mv78xx0.h defines each 
ethernet port's base address like GE00_PHYS_BASE at the wrong address. 
Then orion_ge00_init() in plat-orion/common.c adds a magic 0x2000 
constant which results in the correct address. This probably deserves a 
comment because the header defines incorrect addresses.

4. Each processor varies in support for MII, GMII, and RGMII interfaces. 
Function phy_init() calls phy_attach() which is hardcoded for 
PHY_INTERFACE_MODE_GMII. This depends on the board and can be different 
for each port, so it should probably be specified in the platform data 
instead of hardcoded.

-joey
