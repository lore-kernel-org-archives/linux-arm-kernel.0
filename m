From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 17:39:24 +0100
Subject: [PATCHv2] ipv4: ipconfig: avoid unused ic_proto_used symbol
Message-ID: <2132183.67sfLfLqZb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_PROC_FS, CONFIG_IP_PNP_BOOTP, CONFIG_IP_PNP_DHCP and
CONFIG_IP_PNP_RARP are all disabled, we get a warning about the
ic_proto_used variable being unused:

net/ipv4/ipconfig.c:146:12: error: 'ic_proto_used' defined but not used [-Werror=unused-variable]

This avoids the warning, by making the definition conditional on
whether a dynamic IP configuration protocol is configured. If not,
we know that the value is always zero, so we can optimize away the
variable and all code that depends on it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix typo in changelog

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 67f7c9de0b16..2ed9dd2b5f2f 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -143,7 +143,11 @@ static char dhcp_client_identifier[253] __initdata;
 
 /* Persistent data: */
 
+#ifdef IPCONFIG_DYNAMIC
 static int ic_proto_used;			/* Protocol used, if any */
+#else
+#define ic_proto_used 0
+#endif
 static __be32 ic_nameservers[CONF_NAMESERVERS_MAX]; /* DNS Server IP addresses */
 static u8 ic_domain[64];		/* DNS (not NIS) domain name */
 
