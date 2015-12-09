From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:54 +0000
Subject: [RFC PATCH 19/20] arm64: ensure _stext and _etext are page-aligned
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-20-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we have separate ALIGN_DEBUG_RO{,_MIN} directives to align
_etext and __init_begin. While we ensure that __init_begin is
page-aligned, we do not provide the same guarantee for _etext. This is
not problematic currently as the alignemtn of __init_begin is suffucient
to prevent issues when we modify permissions.

Subsequent patches will assume page alignment of segments of the kernel
we wish to map with different permissions. To ensure this, move _etext
after the ALIGN_DEBUG_RO_MIN for the init section. This renders the
prior ALIGN_DEBUG_RO irrelevant, and hence it is removed. Likewise,
upgrade to ALIGN_DEBUG_RO_MIN(PAGE_SIZE) for _stext.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f943a84..7de6c39 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -94,7 +94,7 @@ SECTIONS
 		_text = .;
 		HEAD_TEXT
 	}
-	ALIGN_DEBUG_RO
+	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
@@ -115,10 +115,9 @@ SECTIONS
 	RO_DATA(PAGE_SIZE)
 	EXCEPTION_TABLE(8)
 	NOTES
-	ALIGN_DEBUG_RO
-	_etext = .;			/* End of text and rodata section */
 
 	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
+	_etext = .;			/* End of text and rodata section */
 	__init_begin = .;
 
 	INIT_TEXT_SECTION(8)
-- 
1.9.1
