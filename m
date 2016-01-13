From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 14:58:11 +0100
Subject: [PATCH] netfilter: nft_ct: mark nft_ct_get_eval_counter __maybe_unused
Message-ID: <6200241.eeH6DHXzHj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added nft_ct_get_eval_counter() function is only used when
CONFIG_NF_CONNTRACK_LABELS is set, otherwise gcc warns about the
unused definition:

netfilter/nft_ct.c:34:12: warning: 'nft_ct_get_eval_counter' defined but not used [-Wunused-function]
 static u64 nft_ct_get_eval_counter(const struct nf_conn_counter *c,

This marks the function __maybe_unused to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 48f66c905a97 ("netfilter: nft_ct: add byte/packet counter support")
---
Found on ARM randconfig builds this week

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index a0eb2161e3ef..3496929bbc54 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -31,9 +31,9 @@ struct nft_ct {
 	};
 };
 
-static u64 nft_ct_get_eval_counter(const struct nf_conn_counter *c,
-				   enum nft_ct_keys k,
-				   enum ip_conntrack_dir d)
+static u64 __maybe_unused nft_ct_get_eval_counter(const struct nf_conn_counter *c,
+						  enum nft_ct_keys k,
+						  enum ip_conntrack_dir d)
 {
 	if (d < IP_CT_DIR_MAX)
 		return k == NFT_CT_BYTES ? atomic64_read(&c[d].bytes) :
