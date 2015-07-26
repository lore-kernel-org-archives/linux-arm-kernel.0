From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 26 Jul 2015 14:59:00 +0200
Subject: [PATCH] arm64/efi: map the entire UEFI vendor string before reading it
Message-ID: <1437915540-7553-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At boot, the UTF-16 UEFI vendor string is copied from the system
table into a char array with a size of 100 bytes. However, this
size of 100 bytes is also used for memremapping() the source,
which may not be sufficient if the vendor string exceeds 50
UTF-16 characters, and the placement of the vendor string inside
a 4 KB page happens to leave the end unmapped.

So use the correct '100 * sizeof(efi_char16_t)' for the size of
the mapping.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Hello Catalin,

I think this should go into v4.2 with a cc: stable.

Thanks,
Ard.

 arch/arm64/kernel/efi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 9d4aa18f2a82..e8ca6eaedd02 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -122,12 +122,12 @@ static int __init uefi_init(void)
 
 	/* Show what we know for posterity */
 	c16 = early_memremap(efi_to_phys(efi.systab->fw_vendor),
-			     sizeof(vendor));
+			     sizeof(vendor) * sizeof(efi_char16_t));
 	if (c16) {
 		for (i = 0; i < (int) sizeof(vendor) - 1 && *c16; ++i)
 			vendor[i] = c16[i];
 		vendor[i] = '\0';
-		early_memunmap(c16, sizeof(vendor));
+		early_memunmap(c16, sizeof(vendor) * sizeof(efi_char16_t));
 	}
 
 	pr_info("EFI v%u.%.02u by %s\n",
-- 
1.9.1
