From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  1 Jul 2018 13:07:54 +0200
Subject: [RFC net-next 05/15] HACK: net: lora: Deal with .poll_mask in 4.18-rc2
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
Message-ID: <20180701110804.32415-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux-next and 4.18-rc2 both identify as LINUX_VERSION(4,18,0), but
commit a11e1d432b51f63ba698d044441284a661f01144 (Revert changes to
convert to ->poll_mask() and aio IOCB_CMD_POLL) reverted .poll_mask
to .poll again.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 net/lora/dgram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/lora/dgram.c b/net/lora/dgram.c
index 4d931fd3778a..ef56fd90e762 100644
--- a/net/lora/dgram.c
+++ b/net/lora/dgram.c
@@ -217,7 +217,11 @@ const struct proto_ops dgram_proto_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= dgram_getname,
+#if 0 /* LINUX_VERSION_CODE >= LINUX_VERSION(4, 18, 0) */
+	.poll_mask	= datagram_poll_mask,
+#else
 	.poll		= datagram_poll,
+#endif
 	.ioctl		= dgram_ioctl,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.16.4
