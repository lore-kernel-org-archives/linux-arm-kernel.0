From: khilman@ti.com (Kevin Hilman)
Date: Wed,  1 Jun 2011 17:19:39 -0700
Subject: [PATCH v4 13/18] I2C: OMAP2+: Pass flags up to omap i2c platform_data
	as well
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Message-ID: <1306973984-15165-14-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Green <andy@warmcat.com>

This is how the driver can find the flags for its implementation
functionality in its platform_data

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/i2c.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 0d3eda7..9098669 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -141,6 +141,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	struct omap_device *od;
 	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
 	struct omap_i2c_bus_platform_data *pdata;
+	struct omap_i2c_dev_attr *dev_attr;
 
 	omap2_i2c_mux_pins(bus_id);
 
@@ -156,10 +157,14 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	pdata = &i2c_pdata[bus_id - 1];
 	/*
 	 * pass the hwmod class's CPU-specific knowledge of I2C IP revision in
-	 * use up to the OMAP I2C driver via platform data
+	 * use, and functionality implementation flags, up to the OMAP I2C
+	 * driver via platform data
 	 */
 	pdata->rev = oh->class->rev;
 
+	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
+	pdata->flags = dev_attr->flags;
+
 	/*
 	 * When waiting for completion of a i2c transfer, we need to
 	 * set a wake up latency constraint for the MPU. This is to
-- 
1.7.4
