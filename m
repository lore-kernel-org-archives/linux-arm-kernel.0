From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 13:56:27 +0100
Subject: [PATCH v2 3/3] mfd: db8500-prcmu: Example using new
 OF_MFD_CELL/MFD_CELL_BASIC MACROs
In-Reply-To: <20180416125627.22156-1-lee.jones@linaro.org>
References: <20180416125627.22156-1-lee.jones@linaro.org>
Message-ID: <20180416125627.22156-4-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... with and without 'resources'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5970b8def548..91259addab54 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3038,23 +3038,13 @@ static const struct mfd_cell common_prcmu_devs[] = {
 };
 
 static const struct mfd_cell db8500_prcmu_devs[] = {
-	{
-		.name = "db8500-prcmu-regulators",
-		.of_compatible = "stericsson,db8500-prcmu-regulator",
-		.platform_data = &db8500_regulators,
-		.pdata_size = sizeof(db8500_regulators),
-	},
-	{
-		.name = "cpuidle-dbx500",
-		.of_compatible = "stericsson,cpuidle-dbx500",
-	},
-	{
-		.name = "db8500-thermal",
-		.num_resources = ARRAY_SIZE(db8500_thsens_resources),
-		.resources = db8500_thsens_resources,
-		.platform_data = &db8500_thsens_data,
-		.pdata_size = sizeof(db8500_thsens_data),
-	},
+	OF_MFD_CELL("db8500-prcmu-regulators", NULL, &db8500_regulators,
+		    sizeof(db8500_regulators), 0,
+		    "stericsson,db8500-prcmu-regulator"),
+	OF_MFD_CELL("cpuidle-dbx500", NULL, NULL, 0, 0,
+		    "stericsson,cpuidle-dbx500"),
+	MFD_CELL_BASIC("db8500-thermal", db8500_thsens_resources,
+		       &db8500_thsens_data, sizeof(db8500_thsens_data), 0),
 };
 
 static int db8500_prcmu_register_ab8500(struct device *parent)
-- 
2.14.1
