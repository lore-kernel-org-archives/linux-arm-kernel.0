From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 03:20:06 -0500
Subject: [PATCH 2/4] ARM: make PHYS_OFFSET actually variable
In-Reply-To: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
Message-ID: <1294129208-15201-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous patch made the implementation of __virt_to_phys() and
__phys_to_virt() assuming PHYS_OFFSET was variable.  Let's make
PHYS_OFFSET actually variable by defining it in terms of __virt_to_phys().

There is a catch with this approach, as PHYS_OFFSET cannot be used as
a static initializer anymore.  Only one such case was found in generic
code and removed, and that is in the declaration of the init_tags
structure (those who wish to use CONFIG_ARM_PATCH_PHYS_VIRT are better
not to rely on that init_tags  default at all anyway, or they'll get
what they deserve).

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

PAGE_OFFSET)
---
 arch/arm/include/asm/memory.h |    3 +++
 arch/arm/kernel/setup.c       |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 2783ce2..acc3126 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -182,6 +182,9 @@ static inline unsigned long __phys_to_virt(unsigned long x)
 	return t;
 }
 
+#undef PHYS_OFFSET
+#define PHYS_OFFSET		__virt_to_phys(PAGE_OFFSET)
+
 #else
 #define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
 #define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 336f14e..7502bc1 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -703,8 +703,10 @@ static struct init_tags {
 } init_tags __initdata = {
 	{ tag_size(tag_core), ATAG_CORE },
 	{ 1, PAGE_SIZE, 0xff },
+#ifndef CONFIG_ARM_PATCH_PHYS_VIRT
 	{ tag_size(tag_mem32), ATAG_MEM },
 	{ MEM_SIZE, PHYS_OFFSET },
+#endif
 	{ 0, ATAG_NONE }
 };
 
-- 
1.7.3.2.193.g78bbb
