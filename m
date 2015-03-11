From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Mar 2015 20:39:29 +0800
Subject: [PATCH v10 03/21] ARM64: allow late use of early_ioremap
In-Reply-To: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1426077587-1561-4-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

Commit 0e63ea48b4d8 (arm64/efi: add missing call to early_ioremap_reset())
added a missing call to early_ioremap_reset(). This triggers a BUG if code
tries using early_ioremap() after the early_ioremap_reset(). This is a
problem for some ACPI code which needs short-lived temporary mappings
after paging_init() but before acpi_early_init() in start_kernel(). This
patch adds definitions for the __late_set_fixmap() and __late_clear_fixmap()
which avoids the BUG by allowing later use of early_ioremap().

CC: Leif Lindholm <leif.lindholm@linaro.org>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Robert Richter <rrichter@cavium.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Acked-by: Robert Richter <rrichter@cavium.com>
Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/fixmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index defa0ff9..f196e40 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -62,6 +62,9 @@ void __init early_fixmap_init(void);
 
 #define __early_set_fixmap __set_fixmap
 
+#define __late_set_fixmap __set_fixmap
+#define __late_clear_fixmap(idx) __set_fixmap((idx), 0, FIXMAP_PAGE_CLEAR)
+
 extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
 
 #include <asm-generic/fixmap.h>
-- 
1.9.1
