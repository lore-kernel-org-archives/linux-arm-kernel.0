From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Fri, 25 Mar 2011 11:31:19 +0800
Subject: [PATCH] call cookies_initialize() before gator_start()
Message-ID: <1301023879-1770-1-git-send-email-ratbert.chuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Po-Yu Chuang <ratbert@faraday-tech.com>

gator_crc32_table might be accessed by gator_chksum_crc32() before
it is allocated.

Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
---
Hi Pawel Moll,

Not sure where to post this patch. Please let me know if there were something
wrong.

 gator_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gator_main.c b/gator_main.c
index 60b09cb..12aa1be 100644
--- a/gator_main.c
+++ b/gator_main.c
@@ -739,13 +739,13 @@ static int gator_op_start(void)
 
 	mutex_lock(&start_mutex);
 
+	cookies_initialize();
+
 	if (gator_started || gator_start())
 		err = -EINVAL;
 	else
 		gator_started = 1;
 
-	cookies_initialize();
-
 	mutex_unlock(&start_mutex);
 
 	return err;
-- 
1.6.3.3
