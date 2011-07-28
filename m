From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Jul 2011 22:32:12 -0500
Subject: [RFC PATCH 1/3] ARM: include mach headers before common arm headers
In-Reply-To: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
References: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
Message-ID: <1311823934-29553-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to add an arch/arm/include/mach directory for default
mach headers, make arch/arm/mach-*/include path be searched before
arch/arm/include. This allows platforms to override default header
implementation.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30a19b6..1c41a2e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -234,9 +234,9 @@ machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
 platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
 
 ifeq ($(KBUILD_SRC),)
-KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
+LINUXINCLUDE := $(patsubst %,-I%include,$(machdirs) $(platdirs)) $(LINUXINCLUDE)
 else
-KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
+LINUXINCLUDE := $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs)) $(LINUXINCLUDE)
 endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
-- 
1.7.4.1
