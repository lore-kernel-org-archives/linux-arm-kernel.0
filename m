From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Aug 2011 14:44:56 +0200
Subject: [PATCH 1/3] ARM: Check for multiple zreladdrs
In-Reply-To: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
References: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1312980298-28035-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without CONFIG_AUTO_ZRELADDR being set the kernel needs a single
zreladdr for building zImages. Bail out if we detect multiple
zreladdrs without CONFIG_AUTO_ZRELADDR.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/compressed/Makefile |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 0c74a6f..a53a333 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -139,8 +139,16 @@ bad_syms=$$($(CROSS_COMPILE)nm $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
   ( echo "following symbols must have non local/private scope:" >&2; \
     echo "$$bad_syms" >&2; rm -f $@; false )
 
+check_for_multiple_zreladdr = \
+if [ $(words $(ZRELADDR)) -gt 1 -a "$(CONFIG_AUTO_ZRELADDR)" == "" ]; then \
+	echo 'multiple zreladdrs: $(ZRELADDR)'; \
+	echo 'This needs CONFIG_AUTO_ZRELADDR to be set'; \
+	false; \
+fi
+
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
 	 	$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) FORCE
+	@$(check_for_multiple_zreladdr)
 	$(call if_changed,ld)
 	@$(check_for_bad_syms)
 
-- 
1.7.5.4
