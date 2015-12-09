From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:37 +0000
Subject: [RFC PATCH 02/20] arm64: Remove redundant padding from linker script
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we place an ALIGN_DEBUG_RO between text and data for the .text
and .init sections, and depending on configuration each of these may
result in up to SECTION_SIZE bytes worth of padding (for
DEBUG_RODATA_ALIGN).

We make no distinction between the text and data in each of these
sections at any point when creating the initial page tables in head.S.
We also make no distinction when modifying the tables; __map_memblock,
fixup_executable, mark_rodata_ro, and fixup_init only work at section
granularity. Thus this padding is unnecessary.

For the spit between init text and data we impose a minimum alignment of
16 bytes, but this is also unnecessary. The init data is output
immediately after the padding before any symbols are defined, so this is
not required to keep a symbol for linker a section array correctly
associated with the data. Any objects within the section will be given
at least their usual alignment regardless.

This patch removes the redundant padding.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1ee2c39..a64340d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -112,7 +112,6 @@ SECTIONS
 		*(.got)			/* Global offset table		*/
 	}
 
-	ALIGN_DEBUG_RO
 	RO_DATA(PAGE_SIZE)
 	EXCEPTION_TABLE(8)
 	NOTES
@@ -127,7 +126,6 @@ SECTIONS
 		ARM_EXIT_KEEP(EXIT_TEXT)
 	}
 
-	ALIGN_DEBUG_RO_MIN(16)
 	.init.data : {
 		INIT_DATA
 		INIT_SETUP(16)
-- 
1.9.1
