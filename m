From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 16:09:02 +0100
Subject: [PATCH] bridge: mdb: avoid uninitialized variable warning
Message-ID: <1455116946-2948649-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change to the mdb code confused the compiler to the point
where it did not realize that the port-group returned from
br_mdb_add_group() is always valid when the function returns a nonzero
return value, so we get a spurious warning:

net/bridge/br_mdb.c: In function 'br_mdb_add':
net/bridge/br_mdb.c:542:4: error: 'pg' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    __br_mdb_notify(dev, entry, RTM_NEWMDB, pg);

Slightly rearranging the code in br_mdb_add_group() makes the problem
go away, as gcc is clever enough to see that both functions check
for 'ret != 0'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9e8430f8d60d ("bridge: mdb: Passing the port-group pointer to br_mdb module")
---
 net/bridge/br_mdb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index ac089286526e..9ab1fcd488c6 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -437,8 +437,8 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 	mp = br_mdb_ip_get(mdb, group);
 	if (!mp) {
 		mp = br_multicast_new_group(br, port, group);
-		err = PTR_ERR(mp);
-		if (IS_ERR(mp))
+		err = PTR_ERR_OR_ZERO(mp);
+		if (err)
 			return err;
 	}
 
-- 
2.7.0
