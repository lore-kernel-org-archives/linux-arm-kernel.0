From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 10 Aug 2018 14:58:28 +0800
Subject: [query] about recent mvneta patches
Message-ID: <20180810145828.6d05b776@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Today I have a look at recent mvneta patches in net-next, I worried two patches:

1. commit 562e2f467e71 ("net: mvneta: Improve the buffer allocation method
for SWBM") sets rx_offset_correction as 0 for SW BM, but IIRC, the offset
is introduced to support 64bit platforms. So in theory the commit could break
arm64 platforms with mvneta SW BM.

Fortunately, commit d93277b9839b ("Revert "arm64: Increase the max granular
size") makes arm64 L1_CACHE_BYTES equal to 64 again, thus NET_SKB_PAD is 64
too, so the commit 562e2f467e71 doesn't introduce regression, but it hides
the bug we tried to fix in commit 8d5047cf9ca ("net: mvneta: Convert to be 64
bits compatible)

IMHO, this patch need to be updated to not introduce regression even the
L1_CACHE_BYTES is larger than 64B, what do you think?

2. commit f945cec88cb ("net: mvneta: Verify hardware checksum only when
offload checksum feature is set"), I agree with the point. But
MVNETA_RX_CSUM_WITH_PSEUDO_HDR bit is always set, so the RX CSUM is always
generated no matter we set NETIF_F_RXCSUM or not, so IMHO, we should
always set NETIF_F_RXCSUM. And since we enabled GRO, so what about something
as below:

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index bc80a678abc3..a5043b27bf37 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4598,7 +4598,8 @@ static int mvneta_probe(struct platform_device *pdev)
 		}
 	}
 
-	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_TSO;
+	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+			NETIF_F_RXCSUM | NETIF_F_TSO | NETIF_F_GRO;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
