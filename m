From: vincent.sanders@collabora.co.uk (Vincent Sanders)
Date: Tue, 13 Mar 2012 14:34:17 +0000
Subject: [PATCH] Improve build environment isolation
Message-ID: <20120313143417.GA5615@mail.collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increasingly distributions are setting default build environments to
have LDFLAGS with hardening options. There seems to be an assumption
with those options that LDFLAGS are passed to the compiler frontend
rather than used directly with ld (which the kernel build process
assumes)

To prevent build failures in such environments this patch changes the
ARM architecture Makefile to override the LDFLAGS from the environment
similar to the behaviour on other common architectures e.g. x86

Signed-off-by: Vincent Sanders <vince@collabora.co.uk>
--

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1683bfb..0a05c44 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -10,6 +10,9 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
+# Ensure linker flags are correct
+LDFLAGS		:=
+
 LDFLAGS_vmlinux	:=-p --no-undefined -X
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
