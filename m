From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Sep 2015 14:45:53 +0100
Subject: [PATCH v2 3/7] hwrng: core: Simplify RNG switching from sysfs
In-Reply-To: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1442497557-9271-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we attempt to use sysfs to change the current RNG in the usual
way i.e. issuing something like:

`echo 8a8a000.rng > /sys/devices/virtual/misc/hw_random/rng_current`

... it will fail because the code doesn't currently take the '\n'
into consideration.  Well, now it does.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/hw_random/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index da8faf7..2d4a969 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -323,7 +323,7 @@ static ssize_t hwrng_attr_current_store(struct device *dev,
 		return -ERESTARTSYS;
 	err = -ENODEV;
 	list_for_each_entry(rng, &rng_list, list) {
-		if (strcmp(rng->name, buf) == 0) {
+		if (sysfs_streq(rng->name, buf)) {
 			err = 0;
 			if (rng != current_rng)
 				err = set_current_rng(rng);
-- 
1.9.1
