From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 Mar 2015 09:27:05 +0100
Subject: [PATCH v6 01/22] compal-laptop: Fix leaking hwmon device
In-Reply-To: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1425976046-20973-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit c2be45f09bb0 ("compal-laptop: Use
devm_hwmon_device_register_with_groups") wanted to change the
registering of hwmon device to resource-managed version. It mostly did
it except the main thing - it forgot to use devm-like function so the
hwmon device leaked after device removal or probe failure.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: c2be45f09bb0 ("compal-laptop: Use devm_hwmon_device_register_with_groups")
Cc: <stable@vger.kernel.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Darren Hart <dvhart@linux.intel.com>

---
Changes since previous submission:
1. Add Darren's ack.
   http://lkml.iu.edu/hypermail/linux/kernel/1503.0/01895.html
---
 drivers/platform/x86/compal-laptop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/compal-laptop.c b/drivers/platform/x86/compal-laptop.c
index 15c0fab2bfa1..eb9885e7fb0e 100644
--- a/drivers/platform/x86/compal-laptop.c
+++ b/drivers/platform/x86/compal-laptop.c
@@ -1026,9 +1026,9 @@ static int compal_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
-						      "compal", data,
-						      compal_hwmon_groups);
+	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
+							   "compal", data,
+							   compal_hwmon_groups);
 	if (IS_ERR(hwmon_dev)) {
 		err = PTR_ERR(hwmon_dev);
 		goto remove;
-- 
1.9.1
