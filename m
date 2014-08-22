From: geoff@infradead.org (Geoff Levand)
Date: Fri, 22 Aug 2014 19:49:17 +0000
Subject: [PATCH 8/9] arm64: Add missing AT() macros to vmlinux.lds.S
In-Reply-To: <cover.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
Message-ID: <2f23e828983b41b1b3844da028f698272b04e83c.1408736066.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing arm64 linker script uses some pre-defined section macros from
vmlinux.lds.h, all of which include a section load address attribute of
'AT(ADDR(section) - LOAD_OFFSET)'.  LOAD_OFFSET is not defined for arm64, and
defaults to zero, so this mix of section attributions has no ill effect.

For consistency and to clear the way for a possible definition of LOAD_OFFSET
add any missing AT() macros to vmlinux.lds.S.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 8dc1d46..07d41aa 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -50,11 +50,11 @@ SECTIONS
 
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
@@ -79,11 +79,11 @@ SECTIONS
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
@@ -91,7 +91,7 @@ SECTIONS
 		SECURITY_INITCALL
 		INIT_RAM_FS
 	}
-	.exit.data : {
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET){
 		ARM_EXIT_KEEP(EXIT_DATA)
 	}
 
-- 
1.9.1
