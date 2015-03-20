From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Fri, 20 Mar 2015 14:12:52 +0300
Subject: [PATCH] arm: fix integer overflow in ELF_ET_DYN_BASE
Message-ID: <1426849972-19606-1-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usually ELF_ET_DYN_BASE is 2/3 of TASK_SIZE. With 3G/1G user/kernel
split this is not so, because 2*TASK_SIZE overflows 32 bits,
so the actual value of ELF_ET_DYN_BASE is:
	(2 * TASK_SIZE / 3) = 0x2a000000

When ASLR is disabled PIE binaries will load at ELF_ET_DYN_BASE address.
On 32bit platforms AddressSanitzer uses addresses [0x20000000 - 0x40000000]
for shadow memory [1]. So ASan doesn't work for PIE binaries when ASLR disabled
as it fails to map shadow memory.
Also after Kees's 'split ET_DYN ASLR from mmap ASLR' patchset PIE binaries
has a high chance of loading somewhere in between [0x2a000000 - 0x40000000]
even if ASLR enabled. This makes ASan with PIE absolutely incompatible.

Fix overflow by dividing TASK_SIZE prior to multiplying.
After this patch ELF_ET_DYN_BASE equals to (for CONFIG_VMSPLIT_3G=y):
	(TASK_SIZE / 3 * 2) = 0x7f555554

[1] https://code.google.com/p/address-sanitizer/wiki/AddressSanitizerAlgorithm#Mapping

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
Reported-by: Maria Guseva <m.guseva@samsung.com>
Cc: stable at vger.kernel.org
---
 arch/arm/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index c1ff8ab..1984a92 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -115,7 +115,7 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE	(2 * TASK_SIZE / 3)
+#define ELF_ET_DYN_BASE	(TASK_SIZE / 3 * 2)
 
 /* When the program starts, a1 contains a pointer to a function to be 
    registered with atexit, as per the SVR4 ABI.  A value of 0 means we 
-- 
2.3.3
