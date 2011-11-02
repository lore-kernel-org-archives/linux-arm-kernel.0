From: javi.merino@arm.com (Javi Merino)
Date: Wed,  2 Nov 2011 14:30:56 +0000
Subject: [PATCH 1/4] ARM: PL330: Don't call the callbacks if there isn't any
	active transfer
Message-ID: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there are no transactions running it is not only wrong but
potentially dangerous to call the callbacks. There can be a stale
struct pl330_req pointer from a previous run, but the memory may be free
already. This patch fixes this, and the callbacks are only called if
there were active transfers when pl330_release_channel() is called.

Signed-off-by: Javi Merino <javi.merino@arm.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/common/pl330.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 7129cfb..842bab0 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -1691,8 +1691,10 @@ void pl330_release_channel(void *ch_id)
 
 	_stop(thrd);
 
-	_callback(thrd->req[1 - thrd->lstenq].r, PL330_ERR_ABORT);
-	_callback(thrd->req[thrd->lstenq].r, PL330_ERR_ABORT);
+	if (!IS_FREE(&thrd->req[1 - thrd->lstenq]))
+		_callback(thrd->req[1 - thrd->lstenq].r, PL330_ERR_ABORT);
+	if (!IS_FREE(&thrd->req[thrd->lstenq]))
+		_callback(thrd->req[thrd->lstenq].r, PL330_ERR_ABORT);
 
 	pl330 = thrd->dmac;
 
-- 
1.7.0.4
