From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 17 Apr 2015 16:27:04 -0500
Subject: [PATCH 2/2] ARM: VDSO: honor CONFIG_VDSO in Makefile
In-Reply-To: <1429306024-5253-1-git-send-email-nathan_lynch@mentor.com>
References: <1429306024-5253-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1429306024-5253-3-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_VDSO=n, the build normally does not enter arch/arm/vdso/
because arch/arm/Makefile does not add it to core-y.

However, if the user runs 'make arch/arm/vdso/' the VDSO targets will
get visited.  This is because the VDSO Makefile itself does not
consider the value of CONFIG_VDSO.

It is arguably better and more consistent behavior to generate an
empty built-in.o when CONFIG_VDSO=n and the user attempts to build
arch/arm/vdso/.  It's nicer because it doesn't try to build things
that Kconfig dependencies are there to prevent (e.g. the dependency on
AEABI), and it's less confusing than building objects that won't be
used in the final image.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index bab0a8be7924..8aa791051029 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -10,8 +10,8 @@ ccflags-y := -shared -fPIC -fno-common -fno-builtin -fno-stack-protector
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 -DDISABLE_BRANCH_PROFILING
 ccflags-y += -Wl,--no-undefined $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
-obj-y += vdso.o
-extra-y += vdso.lds
+obj-$(CONFIG_VDSO) += vdso.o
+extra-$(CONFIG_VDSO) += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
 CFLAGS_REMOVE_vdso.o = -pg
-- 
1.9.3
