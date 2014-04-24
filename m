From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 24 Apr 2014 17:23:19 -0300
Subject: [PATCH v2 05/10] thermal: armada: Allow to specify an 'inverted
 readout' sensor
In-Reply-To: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1398371004-15807-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1398371004-15807-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support inverted-formula thermal sensor readout, this commit
introduces an 'inverted' field in the SoC-specific structure which
allows to specify an inversion of the temperature formula.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/armada_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index aafcc4d..e228132 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -56,6 +56,7 @@ struct armada_thermal_data {
 	unsigned long coef_b;
 	unsigned long coef_m;
 	unsigned long coef_div;
+	bool inverted;
 
 	/* Offset and mask to access the sensor temperature */
 	unsigned int temp_offset;
@@ -138,7 +139,10 @@ static int armada_get_temp(struct thermal_zone_device *thermal,
 	m = priv->data->coef_m;
 	div = priv->data->coef_div;
 
-	*temp = (b - (m * reg)) / div;
+	if (priv->data->inverted)
+		*temp = ((m * reg) - b) / div;
+	else
+		*temp = (b - (m * reg)) / div;
 	return 0;
 }
 
-- 
1.9.1
