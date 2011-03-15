From: andy@warmcat.com (Andy Green)
Date: Tue, 15 Mar 2011 19:56:41 +0000
Subject: [PATCH 3 07/18] I2C: OMAP2+: Pass hwmod rev knowledge via
	platform_data when i2c bus added
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Message-ID: <20110315195641.30000.60794.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark each OMAP I2C bus with the hwmod's knowledge of which I2C
IP version is in the chip we're running on.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/plat-omap/i2c.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 0a1b5af..34a3319 100644
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
