From: philip@cog.systems (Philip Derrin)
Date: Thu,  9 Nov 2017 11:41:43 +1100
Subject: [PATCH 1/2] ARM: mm: make STRICT_KERNEL_RWX effective for LPAE
In-Reply-To: <20171109004144.2246-1-philip@cog.systems>
References: <20171109004144.2246-1-philip@cog.systems>
Message-ID: <20171109004144.2246-2-philip@cog.systems>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, for ARM kernels with CONFIG_ARM_LPAE and
CONFIG_STRICT_KERNEL_RWX enabled, the 2MiB pages mapping the
kernel code and rodata are writable. They are marked read-only in
a software bit (L_PMD_SECT_RDONLY) but the hardware read-only bit
is not set (PMD_SECT_AP2).

For user mappings, the logic that propagates the software bit
to the hardware bit is in set_pmd_at(); but for the kernel,
section_update() writes the PMDs directly, skipping this logic.

The fix is to set PMD_SECT_AP2 for read-only sections in
section_update(), at the same time as L_PMD_SECT_RDONLY.

Fixes: 1e3479225acb ("ARM: 8275/1: mm: fix PMD_SECT_RDONLY undeclared compile error")
Signed-off-by: Philip Derrin <philip@cog.systems>
Reported-by: Neil Dick <neil@cog.systems>
Tested-by: Neil Dick <neil@cog.systems>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: stable at vger.kernel.org
---
 arch/arm/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ad80548325fe..0f6d1537f330 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -639,8 +639,8 @@ static struct section_perm ro_perms[] = {
 		.start  = (unsigned long)_stext,
 		.end    = (unsigned long)__init_begin,
 #ifdef CONFIG_ARM_LPAE
-		.mask   = ~L_PMD_SECT_RDONLY,
-		.prot   = L_PMD_SECT_RDONLY,
+		.mask   = ~(L_PMD_SECT_RDONLY | PMD_SECT_AP2),
+		.prot   = L_PMD_SECT_RDONLY | PMD_SECT_AP2,
 #else
 		.mask   = ~(PMD_SECT_APX | PMD_SECT_AP_WRITE),
 		.prot   = PMD_SECT_APX | PMD_SECT_AP_WRITE,
-- 
2.15.0
