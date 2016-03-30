From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 16:45:56 +0200
Subject: [PATCH v2 1/9] arm64: vdso: avoid virt_to_page() translations on
 kernel symbols
In-Reply-To: <1459349164-27175-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459349164-27175-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459349164-27175-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The translation performed by virt_to_page() is only valid for linear
addresses, and kernel symbols are no longer in the linear mapping.
So perform the __pa() translation explicitly, which does the right
thing in either case, and only then translate to a struct page offset.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/vdso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 97bc68f4c689..64fc030be0f2 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -131,11 +131,11 @@ static int __init vdso_init(void)
 		return -ENOMEM;
 
 	/* Grab the vDSO data page. */
-	vdso_pagelist[0] = virt_to_page(vdso_data);
+	vdso_pagelist[0] = pfn_to_page(PHYS_PFN(__pa(vdso_data)));
 
 	/* Grab the vDSO code pages. */
 	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+		vdso_pagelist[i + 1] = pfn_to_page(PHYS_PFN(__pa(&vdso_start)) + i);
 
 	/* Populate the special mapping structures */
 	vdso_spec[0] = (struct vm_special_mapping) {
-- 
2.5.0
