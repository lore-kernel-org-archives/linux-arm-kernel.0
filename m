From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:44 +0200
Subject: [PATCH v2 02/11] Kbuild: avoid duplicate include path
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/$(hdr-arch)/include/generated/uapi is included twice in the
header search path, which is unnecessary, so this changes the
top-level Makefile to drop the second instance by filtering out
everything from USERINCLUDE that was already part of LINUXINCLUDE.

This should have very little effect other than making the 'make V=1'
output slightly smaller and making the build time faster by a miniscule
amount, but it seems to be cleaner.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8b80a1506be0..45159861e645 100644
--- a/Makefile
+++ b/Makefile
@@ -389,8 +389,9 @@ LINUXINCLUDE    := \
 		-Iarch/$(hdr-arch)/include/generated/uapi \
 		-Iarch/$(hdr-arch)/include/generated \
 		$(if $(KBUILD_SRC), -I$(srctree)/include) \
-		-Iinclude \
-		$(USERINCLUDE)
+		-Iinclude
+
+LINUXINCLUDE	+= $(filter-out $(LINUXINCLUDE),$(USERINCLUDE))
 
 KBUILD_CPPFLAGS := -D__KERNEL__
 
-- 
2.9.0
