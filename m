From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:56:34 +0000
Subject: [PATCH 03/35] mfd: ab8500-gpadc: Reread on failure
In-Reply-To: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360933026-30325-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Reread the gpadc once upon failure.

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Mattias WALLIN <mattias.wallin@stericsson.com>
---
 drivers/mfd/ab8500-gpadc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index 34c1d04..1b48ac1 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -259,6 +259,11 @@ int ab8500_gpadc_convert(struct ab8500_gpadc *gpadc, u8 channel)
 	int voltage;
 
 	ad_value = ab8500_gpadc_read_raw(gpadc, channel);
+
+	/* On failure retry a second time */
+	if (ad_value < 0)
+		ad_value = ab8500_gpadc_read_raw(gpadc, channel);
+
 	if (ad_value < 0) {
 		dev_err(gpadc->dev, "GPADC raw value failed ch: %d\n", channel);
 		return ad_value;
-- 
1.7.10.4
