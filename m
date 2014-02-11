From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Feb 2014 17:10:31 +0000
Subject: [PATCH 07/12] mfd: syscon: Consider platform data a regmap config name
In-Reply-To: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1392138636-29240-8-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the device platform data as a regmap config
name. This is particularly useful in the regmap
debugfs when there is more than one syscon device
registered, to distinguish the register blocks.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
Alternatively I could define a syscon platform data structure,
something like this:

struct syscon_platform_data {
	const char *label;
};

 drivers/mfd/syscon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 71841f9..ea1770b 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -143,6 +143,7 @@ static int syscon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	syscon_regmap_config.max_register = res->end - res->start - 3;
+	syscon_regmap_config.name = dev_get_platdata(&pdev->dev);
 	syscon->regmap = devm_regmap_init_mmio(dev, base,
 					&syscon_regmap_config);
 	if (IS_ERR(syscon->regmap)) {
-- 
1.8.3.2
