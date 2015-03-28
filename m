From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 28 Mar 2015 13:37:19 +0000
Subject: [PATCH] dtbsinstall: don't move target directory out of the way
In-Reply-To: <20150328132320.GA24391@n2100.arm.linux.org.uk>
References: <20150328132320.GA24391@n2100.arm.linux.org.uk>
Message-ID: <E1YbqvP-000283-5m@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No other kernel installation target moves the target directory out of
the way, even deleting an old version of it.  These are destructive
operations, ones which the kernel build system should not be making.

Remove this behaviour.

If this behaviour is required at installation time, this should be
done by the installation external to the kernel makefiles, just like
it would be done for 'make modules_install'.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 scripts/Makefile.dtbinst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
index 909ed7a2ac61..e0254058b0e9 100644
--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -23,8 +23,6 @@ include $(srctree)/$(obj)/Makefile
 PHONY += __dtbs_install_prep
 __dtbs_install_prep:
 ifeq ("$(dtbinst-root)", "$(obj)")
-	$(Q)if [ -d $(INSTALL_DTBS_PATH).old ]; then rm -rf $(INSTALL_DTBS_PATH).old; fi
-	$(Q)if [ -d $(INSTALL_DTBS_PATH) ]; then mv $(INSTALL_DTBS_PATH) $(INSTALL_DTBS_PATH).old; fi
 	$(Q)mkdir -p $(INSTALL_DTBS_PATH)
 endif
 
-- 
1.8.3.1
