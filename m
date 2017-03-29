From: keescook@chromium.org (Kees Cook)
Date: Wed, 29 Mar 2017 11:15:55 -0700
Subject: [RFC v2][PATCH 03/11] net: switch sock_diag handlers to rare_write()
In-Reply-To: <1490811363-93944-1-git-send-email-keescook@chromium.org>
References: <1490811363-93944-1-git-send-email-keescook@chromium.org>
Message-ID: <1490811363-93944-4-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple example a register/unregister case for __wr_rare markings,
which only needs a simple rare_write() call to make updates.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/core/sock_diag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index 6b10573cc9fa..67253026106f 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -14,7 +14,7 @@
 #include <linux/inet_diag.h>
 #include <linux/sock_diag.h>
 
-static const struct sock_diag_handler *sock_diag_handlers[AF_MAX];
+static const struct sock_diag_handler *sock_diag_handlers[AF_MAX] __wr_rare;
 static int (*inet_rcv_compat)(struct sk_buff *skb, struct nlmsghdr *nlh);
 static DEFINE_MUTEX(sock_diag_table_mutex);
 static struct workqueue_struct *broadcast_wq;
@@ -194,7 +194,7 @@ int sock_diag_register(const struct sock_diag_handler *hndl)
 	if (sock_diag_handlers[hndl->family])
 		err = -EBUSY;
 	else
-		sock_diag_handlers[hndl->family] = hndl;
+		rare_write(sock_diag_handlers[hndl->family], hndl);
 	mutex_unlock(&sock_diag_table_mutex);
 
 	return err;
@@ -210,7 +210,7 @@ void sock_diag_unregister(const struct sock_diag_handler *hnld)
 
 	mutex_lock(&sock_diag_table_mutex);
 	BUG_ON(sock_diag_handlers[family] != hnld);
-	sock_diag_handlers[family] = NULL;
+	rare_write(sock_diag_handlers[family], NULL);
 	mutex_unlock(&sock_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
-- 
2.7.4
