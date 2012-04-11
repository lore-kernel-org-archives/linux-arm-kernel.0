From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Apr 2012 15:30:39 +0100
Subject: [PATCH v2 4/4] ARM: nommu: populate vectors page from paging_init
In-Reply-To: <1334154639-13869-1-git-send-email-will.deacon@arm.com>
References: <1334154639-13869-1-git-send-email-will.deacon@arm.com>
Message-ID: <1334154639-13869-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 94e5a85b ("ARM: earlier initialization of vectors page") made it
the responsibility of paging_init to initialise the vectors page.

This patch adds a call to early_trap_init for the !CONFIG_MMU case,
placing the vectors at CONFIG_VECTORS_BASE.

Cc: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/nommu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 6486d2f..d51225f 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -13,6 +13,7 @@
 #include <asm/sections.h>
 #include <asm/page.h>
 #include <asm/setup.h>
+#include <asm/traps.h>
 #include <asm/mach/arch.h>
 
 #include "mm.h"
@@ -39,6 +40,7 @@ void __init sanity_check_meminfo(void)
  */
 void __init paging_init(struct machine_desc *mdesc)
 {
+	early_trap_init((void *)CONFIG_VECTORS_BASE);
 	bootmem_init();
 }
 
-- 
1.7.4.1
