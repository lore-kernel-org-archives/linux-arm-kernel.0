From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Feb 2016 17:21:29 +0100
Subject: [RFC PATCH 2/6] arm64: vdso: avoid virt_to_page() translations on
 kernel symbols
In-Reply-To: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456330893-19228-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The translation performed by virt_to_page() is only valid for linear
addresses, and kernel symbols are no longer in the linear mapping.
So perform the __pa() translation explicitly, which does the right
thing in either case, and only then translate to a struct page offset.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/vdso.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 97bc68f4c689..fb3c17f031aa 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -131,11 +131,12 @@ static int __init vdso_init(void)
 		return -ENOMEM;
 
 	/* Grab the vDSO data page. */
-	vdso_pagelist[0] = virt_to_page(vdso_data);
+	vdso_pagelist[0] = pfn_to_page(__pa(vdso_data) >> PAGE_SHIFT);
 
 	/* Grab the vDSO code pages. */
-	for (i = 0; i < vdso_pages; i++)
-		vdso_pagelist[i + 1] = virt_to_page(&vdso_start + i * PAGE_SIZE);
+	vdso_pagelist[1] = pfn_to_page(__pa(&vdso_start) >> PAGE_SHIFT);
+	for (i = 1; i < vdso_pages; i++)
+		vdso_pagelist[i + 1] = vdso_pagelist[1] + i;
 
 	/* Populate the special mapping structures */
 	vdso_spec[0] = (struct vm_special_mapping) {
-- 
2.5.0
