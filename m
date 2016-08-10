From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Wed, 10 Aug 2016 12:12:52 +0530
Subject: [PATCH 20/21] net: thunderx: Use netdev_rss_key_fill() helper
In-Reply-To: <1470811373-28277-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1470811373-28277-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1470811373-28277-21-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

Use standard API to generate a random RSS hash key
on every boot.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index e73e6df..1cfe2b0 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -366,13 +366,7 @@ static int nicvf_rss_init(struct nicvf *nic)
 
 	rss->enable = true;
 
-	/* Using the HW reset value for now */
-	rss->key[0] = 0xFEED0BADFEED0BADULL;
-	rss->key[1] = 0xFEED0BADFEED0BADULL;
-	rss->key[2] = 0xFEED0BADFEED0BADULL;
-	rss->key[3] = 0xFEED0BADFEED0BADULL;
-	rss->key[4] = 0xFEED0BADFEED0BADULL;
-
+	netdev_rss_key_fill(rss->key, RSS_HASH_KEY_SIZE * sizeof(u64));
 	nicvf_set_rss_key(nic);
 
 	rss->cfg = RSS_IP_HASH_ENA | RSS_TCP_HASH_ENA | RSS_UDP_HASH_ENA;
-- 
2.7.4
