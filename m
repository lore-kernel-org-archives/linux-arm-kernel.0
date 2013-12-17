From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 17 Dec 2013 16:24:57 +0100
Subject: [PATCH v3] regulator_get_optional: don't print an error when no
 regulator is found
Message-ID: <1387293897-31786-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only print an error when _regulator_get() is expected to return a valid
regulator, that is when _regulator_get() is called from regulator_get() and
we're not using the dummy because we don't have full-constraints, or when
_regulator_get() is called from regulator_get_exclusive() in which case
returning a dummy is not allowed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d85f313..9888f26 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1351,7 +1351,8 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 
 		rdev = dummy_regulator_rdev;
 		goto found;
-	} else {
+	/* Don't log an error when called from regulator_get_optional() */
+	} else if (!have_full_constraints() || exclusive) {
 		dev_err(dev, "dummy supplies not allowed\n");
 	}
 
-- 
1.8.4.2
