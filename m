From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 22:10:04 +0200
Subject: [PATCH] netfilter: fix Kconfig dependencies for nft_dup_ipv{4,6}
Message-ID: <5041322.FiDa5XtNuO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nft_dup_ipv4 and nft_dup_ipv6 select the respective nf_dup_ipv{4,6}
drivers, which must not be built-in if nf_conntrack is a loadable
module, otherwise we get a link error:

net/built-in.o: In function `nf_dup_ipv6':
(.text+0xdef20): undefined reference to `nf_conntrack_untracked'

The dependency was fixed for the nf_dup_* modules recently, but this
patch adds the same dependency to the nft_dup_* modules for
the (hopefully) complete fix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6ece90f9a13e ("netfilter: fix Kconfig dependencies for nf_dup_ipv{4,6}")
---
found on ARM randconfig builds

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index a35584176535..c187c60e3e0c 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -60,6 +60,7 @@ config NFT_REJECT_IPV4
 
 config NFT_DUP_IPV4
 	tristate "IPv4 nf_tables packet duplication support"
+	depends on !NF_CONNTRACK || NF_CONNTRACK
 	select NF_DUP_IPV4
 	help
 	  This module enables IPv4 packet duplication support for nf_tables.
diff --git a/net/ipv6/netfilter/Kconfig b/net/ipv6/netfilter/Kconfig
index f6a024e141e5..e10a04c9cdc7 100644
--- a/net/ipv6/netfilter/Kconfig
+++ b/net/ipv6/netfilter/Kconfig
@@ -49,6 +49,7 @@ config NFT_REJECT_IPV6
 
 config NFT_DUP_IPV6
 	tristate "IPv6 nf_tables packet duplication support"
+	depends on !NF_CONNTRACK || NF_CONNTRACK
 	select NF_DUP_IPV6
 	help
 	  This module enables IPv6 packet duplication support for nf_tables.
