From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 22:58:28 +0100
Subject: [PATCH v2] hostap: avoid uninitialized variable use in hfa384x_get_rid
Message-ID: <18181682.hKPVvnQWXk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver reads a value from hfa384x_from_bap(), which may fail,
and then assigns the value to a local variable. gcc detects that
in in the failure case, the 'rlen' variable now contains
uninitialized data:

In file included from ../drivers/net/wireless/intersil/hostap/hostap_pci.c:220:0:
drivers/net/wireless/intersil/hostap/hostap_hw.c: In function 'hfa384x_get_rid':
drivers/net/wireless/intersil/hostap/hostap_hw.c:842:5: warning: 'rec' may be used uninitialized in this function [-Wmaybe-uninitialized]
  if (le16_to_cpu(rec.len) == 0) {

This restructures the function as suggested by Russell King, to
make it more readable and get more reliable error handling, by
handling each failure mode using a goto.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/net/wireless/intersil/hostap/hostap_hw.c b/drivers/net/wireless/intersil/hostap/hostap_hw.c
index 6df3ee561d52..515aa3f993f3 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_hw.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_hw.c
@@ -836,25 +836,30 @@ static int hfa384x_get_rid(struct net_device *dev, u16 rid, void *buf, int len,
 	spin_lock_bh(&local->baplock);
 
 	res = hfa384x_setup_bap(dev, BAP0, rid, 0);
-	if (!res)
-		res = hfa384x_from_bap(dev, BAP0, &rec, sizeof(rec));
+	if (res)
+		goto unlock;
+
+	res = hfa384x_from_bap(dev, BAP0, &rec, sizeof(rec));
+	if (res)
+		goto unlock;
 
 	if (le16_to_cpu(rec.len) == 0) {
 		/* RID not available */
 		res = -ENODATA;
+		goto unlock;
 	}
 
 	rlen = (le16_to_cpu(rec.len) - 1) * 2;
-	if (!res && exact_len && rlen != len) {
+	if (exact_len && rlen != len) {
 		printk(KERN_DEBUG "%s: hfa384x_get_rid - RID len mismatch: "
 		       "rid=0x%04x, len=%d (expected %d)\n",
 		       dev->name, rid, rlen, len);
 		res = -ENODATA;
 	}
 
-	if (!res)
-		res = hfa384x_from_bap(dev, BAP0, buf, len);
+	res = hfa384x_from_bap(dev, BAP0, buf, len);
 
+unlock:
 	spin_unlock_bh(&local->baplock);
 	mutex_unlock(&local->rid_bap_mtx);
 
