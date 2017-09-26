From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:52:19 +0200
Subject: [PATCH 2/2] iio: adc: sun4i-gpadc-iio: do not fail probing when no
 thermal DT node
In-Reply-To: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
References: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
Message-ID: <160cf183a167ef841c96c5626f42e23b7195effa.1506430136.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before this patch, forgetting to put a thermal-zones DT node would
result in the driver failing to probe.

It should be perfectly acceptable to have the driver probe even if no
thermal-zones DT is found. However, it shouldn't want to fail if the
thermal registering fail for any other reason (waiting for other drivers
for example) so check on ENODEV only.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 392d47f..46fe0b5 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -652,7 +652,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
 							    0, info,
 							    &sun4i_ts_tz_ops);
-		if (IS_ERR(info->tzd)) {
+		/*
+		 * Do not fail driver probing when failing to register in
+		 * thermal because no thermal DT node is found.
+		 */
+		if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV) {
 			dev_err(&pdev->dev,
 				"could not register thermal sensor: %ld\n",
 				PTR_ERR(info->tzd));
-- 
git-series 0.9.1
