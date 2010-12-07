From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 6 Dec 2010 21:30:57 -0700 (MST)
Subject: [PATCH] OMAP1: I2C: fix device initialization
Message-ID: <alpine.DEB.2.00.1012062130060.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Commit 4d17aeb1c5b2375769446d13012a98e6d265ec13 ("OMAP: I2C: split
device registration and convert OMAP2+ to omap_device") broke I2C on
OMAP1.  The following messages appear at boot:

i2c_omap i2c_omap.1: failure requesting irq 0
i2c_omap: probe of i2c_omap.1 failed with error -22

Investigation revealed that a chunk of code is missing from the
original plat-omap/i2c.c file which configured the IRQ and base address
for the I2C block on OMAP1.  Upon adding this back, the OMAP1 I2C block
seems to initialize correctly.

Thanks to Cory Maccarrone <darkstar6262@gmail.com> for reporting the bug,
and apologies for the breakage.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/plat-omap/i2c.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a5bff9c..a6cf4e9 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -97,10 +97,15 @@ static inline int omap1_i2c_add_bus(int bus_id)
 {
 	struct platform_device *pdev;
 	struct omap_i2c_bus_platform_data *pdata;
+	struct resource *res;
 
 	omap1_i2c_mux_pins(bus_id);
 
 	pdev = &omap_i2c_devices[bus_id - 1];
+	res = pdev->resource;
+	res[0].start = OMAP1_I2C_BASE;
+	res[0].end = res[0].start + OMAP_I2C_SIZE;
+	res[1].start = INT_I2C;
 	pdata = &i2c_pdata[bus_id - 1];
 
 	return platform_device_register(pdev);
-- 
1.7.2.3
