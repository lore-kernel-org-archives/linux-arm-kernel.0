From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 11 Mar 2016 22:01:08 +0100
Subject: [PATCH 2/3] regulator: axp20x: Handle regulator_register returning
 ENODEV
In-Reply-To: <1457730069-31760-1-git-send-email-hdegoede@redhat.com>
References: <1457730069-31760-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1457730069-31760-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handle regulator_register returning ENODEV, this may happen when
the dts node for the regulator contains "status = disabled" which
is useful for the ldo_io regulators, to avoid the regulator code
getting in the way of gpio use of these pins.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/regulator/axp20x-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 679018c..4250b1b 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -421,6 +421,9 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 
 		rdev = devm_regulator_register(&pdev->dev, desc, &config);
 		if (IS_ERR(rdev)) {
+			if (PTR_ERR(rdev) == -ENODEV)
+				continue;
+
 			dev_err(&pdev->dev, "Failed to register %s\n",
 				regulators[i].name);
 
-- 
2.7.2
