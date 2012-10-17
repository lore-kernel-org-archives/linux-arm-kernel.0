From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:35:55 +0100
Subject: [RESEND PATCH 1/4] ARM: mm: use pteval_t to represent page protection
 values
In-Reply-To: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
References: <1350488158-3399-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350488158-3399-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When updating the page protection map after calculating the user_pgprot
value, the base protection map is temporarily stored in an unsigned long
type, causing truncation of the protection bits when LPAE is enabled.
This effectively means that calls to mprotect() will corrupt the upper
page attributes, clearing the XN bit unconditionally.

This patch uses pteval_t to store the intermediate protection values,
preserving the upper bits for 64-bit descriptors.

Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/mmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 941dfb9..99b47b9 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -488,7 +488,7 @@ static void __init build_mem_type_table(void)
 #endif
 
 	for (i = 0; i < 16; i++) {
-		unsigned long v = pgprot_val(protection_map[i]);
+		pteval_t v = pgprot_val(protection_map[i]);
 		protection_map[i] = __pgprot(v | user_pgprot);
 	}
 
-- 
1.7.4.1
