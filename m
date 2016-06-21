From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 21 Jun 2016 10:44:00 +0900
Subject: [PATCH] arm64: add boot image dependencies to not generate invalid
 images
Message-ID: <1466473440-18887-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I fixed boot image dependencies for arch/arm in commit 3939f3345050
("ARM: 8418/1: add boot image dependencies to not generate invalid
images").

I see a similar problem for arch/arm64; "make -jN Image Image.gz"
would sometimes end up generating bad images where N > 1.

Fix the dependency in arch/arm64/Makefile to avoid the race
between "make Image" and "make Image.*".

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7085e32..648a32c 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -95,7 +95,7 @@ boot := arch/arm64/boot
 Image: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-Image.%: vmlinux
+Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 zinstall install:
-- 
1.9.1
