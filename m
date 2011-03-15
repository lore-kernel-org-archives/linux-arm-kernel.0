From: andy@warmcat.com (Andy Green)
Date: Tue, 15 Mar 2011 19:57:49 +0000
Subject: [PATCH 3 16/18] I2C: OMAP1: set i2c unit feature implementation flags
	in platform data
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Message-ID: <20110315195749.30000.36662.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the OMAP1 implementation flags are set statically, with the
exception that omap7xx has its data bus wired up differently.

Cc: patches at linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/plat-omap/i2c.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index abe070c..710c5d5 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -111,6 +111,19 @@ static inline int omap1_i2c_add_bus(int bus_id)
 	/* all OMAP1 have IP version 1 register set */
 	pdata->rev = OMAP_I2C_IP_VERSION_1;
 
+	/* all OMAP1 I2C are implemented like this */
+	pdata->flags = OMAP_I2C_FLAG_NO_FIFO |
+		       OMAP_I2C_FLAG_SIMPLE_CLOCK |
+		       OMAP_I2C_FLAG_16BIT_DATA_REG |
+		       OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK;
+
+	/* how the cpu bus is wired up differs for 7xx only */
+
+	if (cpu_is_omap7xx())
+		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_1;
+	else
+		pdata->flags |= OMAP_I2C_FLAG_BUS_SHIFT_2;
+
 	return platform_device_register(pdev);
 }
 
