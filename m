From: singhalsimran0@gmail.com (simran singhal)
Date: Sat,  4 Mar 2017 22:16:54 +0530
Subject: [PATCH 2/3] staging: speakup: Clean up tests if NULL returned on
 failure
In-Reply-To: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
References: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
Message-ID: <1488646015-7059-3-git-send-email-singhalsimran0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some functions like kmalloc/kzalloc return NULL on failure.
When NULL represents failure, !x is commonly used.

This was done using Coccinelle:
@@
expression *e;
identifier l1;
@@

e = \(kmalloc\|kzalloc\|kcalloc\|devm_kzalloc\)(...);
...
- e == NULL
+ !e

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/speakup/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/main.c b/drivers/staging/speakup/main.c
index c2f70ef..e8268bc 100644
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -1324,7 +1324,7 @@ static int speakup_allocate(struct vc_data *vc)
 	if (speakup_console[vc_num] == NULL) {
 		speakup_console[vc_num] = kzalloc(sizeof(*speakup_console[0]),
 						  GFP_ATOMIC);
-		if (speakup_console[vc_num] == NULL)
+		if (!speakup_console[vc_num])
 			return -ENOMEM;
 		speakup_date(vc);
 	} else if (!spk_parked)
-- 
2.7.4
