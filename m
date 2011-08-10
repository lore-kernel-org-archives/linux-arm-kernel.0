From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Aug 2011 14:44:57 +0200
Subject: [PATCH 2/3] ARM: Check for multiple load addresses before building a
	uImage
In-Reply-To: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
References: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1312980298-28035-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uImages need a load address specified. This makes them
incompatible with multiple zreladdrs. Catch this error
before building an uImage so that we do not end up with
broken uImages. The load address can still be specified
with LOADADDR= on the command line.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/Makefile |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index a1edfd5..176062a 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -78,7 +78,16 @@ endif
 
 $(obj)/uImage: STARTADDR=$(LOADADDR)
 
+check_for_multiple_loadaddr = \
+if [ $(words $(LOADADDR)) -gt 1 ]; then \
+	echo 'multiple load addresses: $(LOADADDR)'; \
+	echo 'This is incompatible with uImages'; \
+	echo 'Specify LOADADDR on the commandline to build an uImage'; \
+	false; \
+fi
+
 $(obj)/uImage:	$(obj)/zImage FORCE
+	@$(check_for_multiple_loadaddr)
 	$(call if_changed,uimage)
 	@echo '  Image $@ is ready'
 
-- 
1.7.5.4
