From: dennis.chen@arm.com (Dennis Chen)
Date: Tue, 5 Jan 2016 10:18:19 +0800
Subject: [linux-next PATCH] arm64: fix kernel crash with 48-bit VA and 64KB
 granule
Message-ID: <1451960299-14123-1-git-send-email-dennis.chen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 3400749b5a22 ("arm64/efi: refactor EFI init and runtime
code for reuse by 32-bit ARM") uses pgd_alloc() to allocate space for
efi_mm.pgd while not the static efi_pgd[], since this function will be
called with early_initcall, which results in the pgd_cache used by
pgd_alloc() has not been initialized yet, kernel will hang in this
case. This patch is trying to make the pgd_cache_init() called before
arm_enable_runtime_services() by changing its core_initcall to
early_initcall.

Signed-off-by: Dennis Chen <dennis.chen@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/mm/pgd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index cb3ba1b..859a788 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -56,4 +56,4 @@ static int __init pgd_cache_init(void)
                                              SLAB_PANIC, NULL);
        return 0;
 }
-core_initcall(pgd_cache_init);
+early_initcall(pgd_cache_init);
--
1.9.1

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
