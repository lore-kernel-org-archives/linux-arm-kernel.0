From: steve.capper@arm.com (Steve Capper)
Date: Wed, 17 Oct 2018 17:34:57 +0100
Subject: [PATCH V2 2/4] arm64: mm: Introduce DEFAULT_MAP_WINDOW
In-Reply-To: <20181017163459.20175-1-steve.capper@arm.com>
References: <20181017163459.20175-1-steve.capper@arm.com>
Message-ID: <20181017163459.20175-3-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We wish to introduce a 52-bit virtual address space for userspace but
maintain compatibility with software that assumes the maximum VA space
size is 48 bit.

In order to achieve this, on 52-bit VA systems, we make mmap behave as
if it were running on a 48-bit VA system (unless userspace explicitly
requests a VA where addr[51:48] != 0).

On a system running a 52-bit userspace we need TASK_SIZE to represent
the 52-bit limit as it is used in various places to distinguish between
kernelspace and userspace addresses.

Thus we need a new limit for mmap, stack, ELF loader and EFI (which uses
TTBR0) to represent the non-extended VA space.

This patch introduces DEFAULT_MAP_WINDOW and DEFAULT_MAP_WINDOW_64 and
switches the appropriate logic to use that instead of TASK_SIZE.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/elf.h            | 2 +-
 arch/arm64/include/asm/processor.h      | 9 +++++++--
 drivers/firmware/efi/arm-runtime.c      | 2 +-
 drivers/firmware/efi/libstub/arm-stub.c | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 433b9554c6a1..bc9bd9e77d9d 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -117,7 +117,7 @@
  * 64-bit, this is above 4GB to leave the entire 32-bit address
  * space open for things that want to use the area for 32-bit pointers.
  */
-#define ELF_ET_DYN_BASE		(2 * TASK_SIZE_64 / 3)
+#define ELF_ET_DYN_BASE		(2 * DEFAULT_MAP_WINDOW_64 / 3)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 79657ad91397..46c9d9ff028c 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -26,6 +26,8 @@
 
 #ifndef __ASSEMBLY__
 
+#define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS)
+
 /*
  * Default implementation of macro that returns current
  * instruction pointer ("program counter").
@@ -58,13 +60,16 @@
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
+#define DEFAULT_MAP_WINDOW	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
+				TASK_SIZE_32 : DEFAULT_MAP_WINDOW_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64
+#define DEFAULT_MAP_WINDOW	DEFAULT_MAP_WINDOW_64
 #endif /* CONFIG_COMPAT */
 
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
+#define STACK_TOP_MAX		DEFAULT_MAP_WINDOW_64
 
-#define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
 #define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 922cfb813109..952cec5b611a 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -38,7 +38,7 @@ static struct ptdump_info efi_ptdump_info = {
 	.mm		= &efi_mm,
 	.markers	= (struct addr_marker[]){
 		{ 0,		"UEFI runtime start" },
-		{ TASK_SIZE_64,	"UEFI runtime end" }
+		{ DEFAULT_MAP_WINDOW_64, "UEFI runtime end" }
 	},
 	.base_addr	= 0,
 };
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 6920033de6d4..ac297c20ab1e 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -33,7 +33,7 @@
 #define EFI_RT_VIRTUAL_SIZE	SZ_512M
 
 #ifdef CONFIG_ARM64
-# define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE_64
+# define EFI_RT_VIRTUAL_LIMIT	DEFAULT_MAP_WINDOW_64
 #else
 # define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
 #endif
-- 
2.11.0
