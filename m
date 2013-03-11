From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 11 Mar 2013 10:35:58 +0530
Subject: [PATCH 1/8] memory: emif: Correct the lpmode timeout calculation
In-Reply-To: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
References: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1362978365-5593-2-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver tries to round up the specified timeout cycles to
the next power of 2 value. But this is done wrongly.
Correcting this here.

Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/memory/emif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index df08736..622638c 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -732,9 +732,9 @@ static u32 get_pwr_mgmt_ctrl(u32 freq, struct emif_data *emif, u32 ip_rev)
 	if (timeout < 16) {
 		timeout = 0;
 	} else {
-		timeout = __fls(timeout) - 3;
 		if (timeout & (timeout - 1))
-			timeout++;
+			timeout <<= 1;
+		timeout = __fls(timeout) - 3;
 	}
 
 	switch (lpmode) {
-- 
1.7.9.5
