From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 22:24 +0100
Subject: [PATCH] X.509: shut up about included cert for silent build
Message-ID: <2124221.xG51kBCe6s@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every kernel build that includes X.509 support prints out
a message like

 - Including cert signing_key.x509

This may be useful for some cases, but when doing automated
build tests, it just means noise.

To hide the message, this uses '$(kecho)' for printing the
message, which means we still see it when building with V=1,
but not at the normal level or when building with 'make -s'.

Signed-off-by: Arnd Bergmann <arnd@arnd.de>

diff --git a/kernel/Makefile b/kernel/Makefile
index 6892723681d5..4e5598689058 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -144,7 +144,7 @@ endif
 kernel/system_certificates.o: $(obj)/x509_certificate_list
 
 quiet_cmd_x509certs  = CERTS   $@
-      cmd_x509certs  = cat $(X509_CERTIFICATES) /dev/null >$@ $(foreach X509,$(X509_CERTIFICATES),; echo "  - Including cert $(X509)")
+      cmd_x509certs  = cat $(X509_CERTIFICATES) /dev/null >$@ $(foreach X509,$(X509_CERTIFICATES),; $(kecho) "  - Including cert $(X509)")
 
 targets += $(obj)/x509_certificate_list
 $(obj)/x509_certificate_list: $(X509_CERTIFICATES) $(obj)/.x509.list
