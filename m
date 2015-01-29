From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 17:18:59 +0100
Subject: [PATCH] [TEMPORARY] net: netfilter: IPV6 XT sockets need
 CONFIG_NF_DEFRAG_IPV6
Message-ID: <1513018.IdvuSAziQY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If IP6_NF_IPTABLES=m, NF_DEFRAG_IPV6 gets selected as a module as well
from NETFILTER_XT_MATCH_SOCKET, so the latter cannot be built-in, or
we get:

net/built-in.o: In function `socket_mt_init':
:(.init.text+0x32a0): undefined reference to `nf_defrag_ipv6_enable'
net/built-in.o: In function `tproxy_tg_init':
xt_TPROXY.c:582: undefined reference to `nf_defrag_ipv6_enable'

This adds one more dependency like the others to avoid the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index b02660fa9eb0..2bd57d62a385 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -875,6 +875,7 @@ config NETFILTER_XT_TARGET_TPROXY
 	depends on NETFILTER_ADVANCED
 	depends on (IPV6 || IPV6=n)
 	depends on IP_NF_MANGLE
+	depends on (IP6_NF_IPTABLES || !IP6_NF_IPTABLES)
 	select NF_DEFRAG_IPV4
 	select NF_DEFRAG_IPV6 if IP6_NF_IPTABLES
 	help
@@ -1367,6 +1368,7 @@ config NETFILTER_XT_MATCH_SOCKET
 	depends on NETFILTER_ADVANCED
 	depends on !NF_CONNTRACK || NF_CONNTRACK
 	depends on (IPV6 || IPV6=n)
+	depends on (IP6_NF_IPTABLES || !IP6_NF_IPTABLES)
 	select NF_DEFRAG_IPV4
 	select NF_DEFRAG_IPV6 if IP6_NF_IPTABLES
 	help
