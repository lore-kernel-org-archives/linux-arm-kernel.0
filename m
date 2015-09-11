From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 21:08:26 +0100
Subject: [PATCH 2/6] hwrng: core: Simplify RNG switching from sysfs
In-Reply-To: <1442002110-28733-1-git-send-email-lee.jones@linaro.org>
References: <1442002110-28733-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1442002110-28733-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we attempt to use sysfs to change the current RNG in the usual
way i.e. issuing something like:

`echo 8a8a000.rng > /sys/devices/virtual/misc/hw_random/rng_current`

... it will fail because the code doesn't currently take the '\n'
into consideration.  Well, now it does.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/hw_random/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index da8faf7..14dc984 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -316,6 +316,7 @@ static ssize_t hwrng_attr_current_store(struct device *dev,
 					const char *buf, size_t len)
 {
 	int err;
+	int snip = 0;
 	struct hwrng *rng;
 
 	err = mutex_lock_interruptible(&rng_mutex);
@@ -323,7 +324,11 @@ static ssize_t hwrng_attr_current_store(struct device *dev,
 		return -ERESTARTSYS;
 	err = -ENODEV;
 	list_for_each_entry(rng, &rng_list, list) {
-		if (strcmp(rng->name, buf) == 0) {
+
+		if (buf[len-1] == '\n')
+			snip = 1; /* Snip one character */
+
+		if (strncmp(rng->name, buf, len - snip) == 0) {
 			err = 0;
 			if (rng != current_rng)
 				err = set_current_rng(rng);
-- 
1.9.1
