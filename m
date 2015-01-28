From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 17:12 +0100
Subject: [PATCH] Smack: fix netfilter Makefile entry
Message-ID: <2504358.ZeqdfUXKpJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added Smack support for netfilter secmark has its own
Kconfig symbol, but the actual implementation is conditionally
built on another symbol.

It is possible for CONFIG_NETFILTER and SECURITY_SMACK to both
be enabled, but NETWORK_SECMARK to be disabled, in which case
we get a build error:

../security/smack/smack_netfilter.c: In function 'smack_ipv6_output':
../security/smack/smack_netfilter.c:36:6: error: 'struct sk_buff' has no member named 'secmark'
   skb->secmark = skp->smk_secid;
      ^
../security/smack/smack_netfilter.c: In function 'smack_ipv4_output':
../security/smack/smack_netfilter.c:55:6: error: 'struct sk_buff' has no member named 'secmark'
   skb->secmark = skp->smk_secid;
      ^

This changes the Makefile to use the correct Kconfig symbol.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 69f287ae6fc83 ("Smack: secmark support for netfilter")

diff --git a/security/smack/Makefile b/security/smack/Makefile
index 616cf93b368e..d4a376c84050 100644
--- a/security/smack/Makefile
+++ b/security/smack/Makefile
@@ -5,4 +5,4 @@
 obj-$(CONFIG_SECURITY_SMACK) := smack.o
 
 smack-y := smack_lsm.o smack_access.o smackfs.o
-smack-$(CONFIG_NETFILTER) += smack_netfilter.o
+smack-$(SECURITY_SMACK_NETFILTER) += smack_netfilter.o
