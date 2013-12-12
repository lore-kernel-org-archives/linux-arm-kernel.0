From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Dec 2013 20:39:46 +0000
Subject: [PATCH 4/5] arm64: Add missing AT() macros to vmlinux.lds.S
In-Reply-To: <cover.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
Message-ID: <51cf7ba0aab8ae3677673cab65ec560d78a645ce.1386879684.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing AT() macros to vmlinux.lds to generate the sections
properly.  Some elf file tools expect correct paddr values in
vmlinux.

Fixes bad paddr values written to vmlinux like these:

  Program Header:
    LOAD off 0x0000000000010000 vaddr 0xffffffc000080000 paddr 0xffffffc000080000 align 2**16

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 arch/arm64/kernel/vmlinux.lds.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6563b64..065fe40d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -48,11 +48,11 @@ SECTIONS
 
 	. = PAGE_OFFSET + TEXT_OFFSET;
 
-	.head.text : {
+	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
 		_text = .;
 		HEAD_TEXT
 	}
-	.text : {			/* Real text segment		*/
+	.text : AT(ADDR(.text) - LOAD_OFFSET) { /* Real text segment	*/
 		_stext = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
 			*(.exception.text)
@@ -77,11 +77,11 @@ SECTIONS
 	__init_begin = .;
 
 	INIT_TEXT_SECTION(8)
-	.exit.text : {
+	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
 		ARM_EXIT_KEEP(EXIT_TEXT)
 	}
 	. = ALIGN(16);
-	.init.data : {
+	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
 		INIT_DATA
 		INIT_SETUP(16)
 		INIT_CALLS
@@ -89,7 +89,7 @@ SECTIONS
 		SECURITY_INITCALL
 		INIT_RAM_FS
 	}
-	.exit.data : {
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET){
 		ARM_EXIT_KEEP(EXIT_DATA)
 	}
 
-- 
1.8.1.2
