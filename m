From: javi.merino@arm.com (Javi Merino)
Date: Wed,  2 Nov 2011 14:30:57 +0000
Subject: [PATCH 2/4] ARM: PL330: Only register usable channels
In-Reply-To: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
Message-ID: <1320244259-10496-2-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the manager is running non-secure, the only channels that can
issue interrupts are the ones that have a 1 in their corresponding bit
in Configuration Register 3. The other ones will generate an abort
when trying to signal the end of the transaction so they are useless
in non-secure mode.

Signed-off-by: Javi Merino <javi.merino@arm.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/common/pl330.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 842bab0..590fd57 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -1623,6 +1623,11 @@ static inline int _alloc_event(struct pl330_thread *thrd)
 	return -1;
 }
 
+static bool is_non_secure_chan(const struct pl330_info *pi, int i)
+{
+	return pi->pcfg.irq_ns & (1 << i);
+}
+
 /* Upon success, returns IdentityToken for the
  * allocated channel, NULL otherwise.
  */
@@ -1647,7 +1652,8 @@ void *pl330_request_channel(const struct pl330_info *pi)
 
 	for (i = 0; i < chans; i++) {
 		thrd = &pl330->channels[i];
-		if (thrd->free) {
+		if ((thrd->free) && (!_manager_ns(thrd) ||
+					is_non_secure_chan(pi, i))) {
 			thrd->ev = _alloc_event(thrd);
 			if (thrd->ev >= 0) {
 				thrd->free = false;
-- 
1.7.0.4
