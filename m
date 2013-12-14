From: geoff@infradead.org (Geoff Levand)
Date: Fri, 13 Dec 2013 16:20:13 -0800
Subject: [PATCH v2 1/5] arm64: Remove unused __data_loc variable
In-Reply-To: <cover.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
Message-ID: <1386980413.1002.94.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The __data_loc variable is an unused left over from the 32 bit arm implementation.
Remove that variable and adjust the __mmap_switched startup routine accordingly.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
v2: Change from fixing up the linker script to removing the __data_loc variable
    altogether.

Catalin,

As discussed, I removed all reference to __data_loc and _edata_loc, and also
the use of _data in the __mmap_switched routine, as is was just used in a
compare.  

I guess the data segment copy I removed is to support XIP.  This change
seems to work OK for me in a casual boot test.

Please consider.

-Geoff

 arch/arm64/kernel/head.S        | 10 ----------
 arch/arm64/kernel/vmlinux.lds.S |  2 --
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c68cca5..0b281ff 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -482,8 +482,6 @@ ENDPROC(__create_page_tables)
 	.type	__switch_data, %object
 __switch_data:
 	.quad	__mmap_switched
-	.quad	__data_loc			// x4
-	.quad	_data				// x5
 	.quad	__bss_start			// x6
 	.quad	_end				// x7
 	.quad	processor_id			// x4
@@ -498,15 +496,7 @@ __switch_data:
 __mmap_switched:
 	adr	x3, __switch_data + 8
 
-	ldp	x4, x5, [x3], #16
 	ldp	x6, x7, [x3], #16
-	cmp	x4, x5				// Copy data segment if needed
-1:	ccmp	x5, x6, #4, ne
-	b.eq	2f
-	ldr	x16, [x4], #8
-	str	x16, [x5], #8
-	b	1b
-2:
 1:	cmp	x6, x7
 	b.hs	2f
 	str	xzr, [x6], #8			// Clear BSS
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5161ad9..8a75386 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -99,11 +99,9 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	_data = .;
-	__data_loc = _data - LOAD_OFFSET;
 	_sdata = .;
 	RW_DATA_SECTION(64, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
-	_edata_loc = __data_loc + SIZEOF(.data);
 
 	BSS_SECTION(0, 0, 0)
 	_end = .;
-- 
1.8.1.2
