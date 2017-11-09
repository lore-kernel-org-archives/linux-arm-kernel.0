From: philip@cog.systems (Philip Derrin)
Date: Thu,  9 Nov 2017 11:41:44 +1100
Subject: [PATCH 2/2] ARM: mm: dump: check hardware RO bit for LPAE
In-Reply-To: <20171109004144.2246-1-philip@cog.systems>
References: <20171109004144.2246-1-philip@cog.systems>
Message-ID: <20171109004144.2246-3-philip@cog.systems>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_ARM_LPAE is set, the PMD dump relies on the software
read-only bit to determine whether a page is writable. This
concealed a bug which left the kernel text section writable
(AP2=0) while marked read-only in the software bit.

In a kernel with the AP2 bug, the dump looks like this:

    ---[ Kernel Mapping ]---
    0xc0000000-0xc0200000           2M RW NX SHD
    0xc0200000-0xc0600000           4M ro x  SHD
    0xc0600000-0xc0800000           2M ro NX SHD
    0xc0800000-0xc4800000          64M RW NX SHD

The fix is to check that the software and hardware bits are both
set before displaying "ro". The dump then shows the true perms:

    ---[ Kernel Mapping ]---
    0xc0000000-0xc0200000           2M RW NX SHD
    0xc0200000-0xc0600000           4M RW x  SHD
    0xc0600000-0xc0800000           2M RW NX SHD
    0xc0800000-0xc4800000          64M RW NX SHD

Fixes: ded947798469 ("ARM: 8109/1: mm: Modify pte_write and pmd_write logic for LPAE")
Signed-off-by: Philip Derrin <philip@cog.systems>
Tested-by: Neil Dick <neil@cog.systems>
Cc: stable at vger.kernel.org
---
 arch/arm/mm/dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 35ff45470dbf..fc3b44028cfb 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -129,8 +129,8 @@ static const struct prot_bits section_bits[] = {
 		.val	= PMD_SECT_USER,
 		.set	= "USR",
 	}, {
-		.mask	= L_PMD_SECT_RDONLY,
-		.val	= L_PMD_SECT_RDONLY,
+		.mask	= L_PMD_SECT_RDONLY | PMD_SECT_AP2,
+		.val	= L_PMD_SECT_RDONLY | PMD_SECT_AP2,
 		.set	= "ro",
 		.clear	= "RW",
 #elif __LINUX_ARM_ARCH__ >= 6
-- 
2.15.0
