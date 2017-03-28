From: elena.reshetova@intel.com (Elena Reshetova)
Date: Tue, 28 Mar 2017 11:56:37 +0300
Subject: [PATCH 10/16] drivers,
 net: convert masces_rx_sc.refcnt from atomic_t to refcount_t
In-Reply-To: <1490691403-4016-1-git-send-email-elena.reshetova@intel.com>
References: <1490691403-4016-1-git-send-email-elena.reshetova@intel.com>
Message-ID: <1490691403-4016-11-git-send-email-elena.reshetova@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 drivers/net/macsec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index bc0b00a..1869223 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -172,7 +172,7 @@ struct macsec_rx_sc {
 	bool active;
 	struct macsec_rx_sa __rcu *sa[MACSEC_NUM_AN];
 	struct pcpu_rx_sc_stats __percpu *stats;
-	atomic_t refcnt;
+	refcount_t refcnt;
 	struct rcu_head rcu_head;
 };
 
@@ -331,12 +331,12 @@ static void free_rx_sc_rcu(struct rcu_head *head)
 
 static struct macsec_rx_sc *macsec_rxsc_get(struct macsec_rx_sc *sc)
 {
-	return atomic_inc_not_zero(&sc->refcnt) ? sc : NULL;
+	return refcount_inc_not_zero(&sc->refcnt) ? sc : NULL;
 }
 
 static void macsec_rxsc_put(struct macsec_rx_sc *sc)
 {
-	if (atomic_dec_and_test(&sc->refcnt))
+	if (refcount_dec_and_test(&sc->refcnt))
 		call_rcu(&sc->rcu_head, free_rx_sc_rcu);
 }
 
@@ -1396,7 +1396,7 @@ static struct macsec_rx_sc *create_rx_sc(struct net_device *dev, sci_t sci)
 
 	rx_sc->sci = sci;
 	rx_sc->active = true;
-	atomic_set(&rx_sc->refcnt, 1);
+	refcount_set(&rx_sc->refcnt, 1);
 
 	secy = &macsec_priv(dev)->secy;
 	rcu_assign_pointer(rx_sc->next, secy->rx_sc);
-- 
2.7.4
