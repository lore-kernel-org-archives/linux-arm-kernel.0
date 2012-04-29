From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sun, 29 Apr 2012 17:28:48 +0200
Subject: [PATCH 1/3] pwm-core: fix compilation when OF is not selected
Message-ID: <1335713330-6488-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

else we get the following error :
drivers/pwm/core.c: In function 'pwm_get':
drivers/pwm/core.c:538:3: error: implicit declaration of function 'of_pwm_request' [-Werror=implicit-function-declaration]

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/pwm/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e5ab7cd..a7be0bc 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -533,9 +533,11 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	unsigned int index;
 	unsigned int match;
 
+#ifdef CONFIG_OF
 	/* look up via DT first */
 	if (dev && dev->of_node)
 		return of_pwm_request(dev->of_node, con_id);
+#endif
 
 	/*
 	 * We look up the provider in the static table typically provided by
-- 
1.7.7.6
