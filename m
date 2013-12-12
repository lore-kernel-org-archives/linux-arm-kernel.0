From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 12 Dec 2013 14:31:16 +0100
Subject: [PATCH v2] regulator_get_optional: don't print an error when no
 regulator is found
Message-ID: <1386855076-5242-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since regulator_get_optional is the only one calling _regulator_get() with
both allow_dummy and exclusive set to false this patch adds the following
test for calling dev_err:

    if (!(!allow_dummy && !exclusive))

Simplified to the much easier on the eyes:

    if (allow_dummy || exclusive)

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3fe1313..a1d4ddc 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1346,7 +1346,8 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 
 		rdev = dummy_regulator_rdev;
 		goto found;
-	} else {
+	/* Don't log an error when called from regulator_get_optional() */
+	} else if (allow_dummy || exclusive) {
 		dev_err(dev, "dummy supplies not allowed\n");
 	}
 
-- 
1.8.4.2
