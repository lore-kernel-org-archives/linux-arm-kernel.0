From: dianders@chromium.org (Doug Anderson)
Date: Tue, 20 Nov 2012 14:27:04 -0800
Subject: [PATCH 2/2] i2c: s3c2410: Get the i2c bus number from alias id
In-Reply-To: <1353450428-2615-1-git-send-email-dianders@chromium.org>
References: <1353450428-2615-1-git-send-email-dianders@chromium.org>
Message-ID: <1353450428-2615-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Padmavathi Venna <padma.v@samsung.com>

Get the i2c bus number that the device is connected to using the alias
id.  This makes debugging / grokking of kernel messages much easier.

[dianders: slight patch cleanup from Padmavathi's original.]

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/i2c/busses/i2c-s3c2410.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 3e0335f..ca43590 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -899,11 +899,19 @@ static void
 s3c24xx_i2c_parse_dt(struct device_node *np, struct s3c24xx_i2c *i2c)
 {
 	struct s3c2410_platform_i2c *pdata = i2c->pdata;
+	int id;
 
 	if (!np)
 		return;
 
-	pdata->bus_num = -1; /* i2c bus number is dynamically assigned */
+	id = of_alias_get_id(np, "i2c");
+	if (id < 0) {
+		dev_warn(i2c->dev, "failed to get alias id:%d\n", id);
+		pdata->bus_num = -1;
+	} else {
+		/* i2c bus number is statically assigned from alias */
+		pdata->bus_num = id;
+	}
 	of_property_read_u32(np, "samsung,i2c-sda-delay", &pdata->sda_delay);
 	of_property_read_u32(np, "samsung,i2c-slave-addr", &pdata->slave_addr);
 	of_property_read_u32(np, "samsung,i2c-max-bus-freq",
-- 
1.7.7.3
