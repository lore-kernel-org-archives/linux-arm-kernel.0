From: khilman@ti.com (Kevin Hilman)
Date: Wed,  1 Jun 2011 17:19:33 -0700
Subject: [PATCH v4 07/18] I2C: OMAP2+: Pass hwmod rev knowledge via
	platform_data when i2c bus added
In-Reply-To: <1306973984-15165-1-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Message-ID: <1306973984-15165-8-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Green <andy@warmcat.com>

Mark each OMAP I2C bus with the hwmod's knowledge of which I2C
IP version is in the chip we're running on.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/i2c.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a938df0..0d3eda7 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -155,6 +155,12 @@ static inline int omap2_i2c_add_bus(int bus_id)
 
 	pdata = &i2c_pdata[bus_id - 1];
 	/*
+	 * pass the hwmod class's CPU-specific knowledge of I2C IP revision in
+	 * use up to the OMAP I2C driver via platform data
+	 */
+	pdata->rev = oh->class->rev;
+
+	/*
 	 * When waiting for completion of a i2c transfer, we need to
 	 * set a wake up latency constraint for the MPU. This is to
 	 * ensure quick enough wakeup from idle, when transfer
-- 
1.7.4
