From: colin.king@canonical.com (Colin King)
Date: Mon, 20 Mar 2017 14:08:50 +0000
Subject: [PATCH] staging: vc04_services: fix NULL pointer dereference on
 pointer 'service'
Message-ID: <20170320140850.10570-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Currently, if pservice is null then service is set to NULL and immediately
afterwards service is dereferenced causing a null pointer dereference. Fix
this by bailing out early of the function with a null return.

Detected by CoverityScan, CID#1419681 ("Explicit null dereferenced")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index dc9f85c2a5da..4f9e738abddf 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2673,7 +2673,7 @@ vchiq_add_service_internal(VCHIQ_STATE_T *state,
 
 	if (!pservice) {
 		kfree(service);
-		service = NULL;
+		return NULL;
 	}
 
 	service_quota = &state->service_quotas[service->localport];
-- 
2.11.0
