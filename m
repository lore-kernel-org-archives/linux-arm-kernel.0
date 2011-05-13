From: vbendeb@google.com (Vadim Bendebury)
Date: Fri, 13 May 2011 12:53:16 -0700 (PDT)
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate operation in
	thumb mode.
Message-ID: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a cosmetic change, adding a '_thumb' prefix to the
'Hardware' line in /proc/cpuinfo. Tested as follows:

localhost ~ # dmesg | grep thumb
[    0.000000] Machine: kaen_thumb
localhost ~ # grep '^Hardware' /proc/cpuinfo
Hardware        : kaen_thumb
localhost ~ #

Signed-off-by: Vadim Bendebury <vbendeb@chromium.org>
---
 arch/arm/include/asm/mach/arch.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index bf13b81..c7445a5 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -51,12 +51,18 @@ extern struct machine_desc *machine_desc;
  * Set of macros to define architecture features.  This is built into
  * a table by the linker.
  */
+#ifdef CONFIG_THUMB2_KERNEL
+#define NAME_SUFFIX	"_thumb"
+#else
+#define NAME_SUFFIX	""
+#endif
+
 #define MACHINE_START(_type,_name)			\
 static const struct machine_desc __mach_desc_##_type	\
  __used							\
  __attribute__((__section__(".arch.info.init"))) = {	\
 	.nr		= MACH_TYPE_##_type,		\
-	.name		= _name,
+	.name		= _name NAME_SUFFIX,
 
 #define MACHINE_END				\
 };
-- 
1.7.3.1
