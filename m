From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 18:52:27 +0100
Subject: [PATCH v2 1/4] ARM: force linker to use PIC veneers
In-Reply-To: <1427219550-21636-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427219550-21636-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427219550-21636-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a very large kernel, it is up to the linker to decide
when and where to insert stubs to allow calls to functions that are
out of range for the ordinary b/bl instructions.

However, since the kernel is built as a position dependent binary,
these stubs (aka veneers) may contain absolute addresses, which will
break far calls performed with the MMU off.

For instance, the call from __enable_mmu() in the .head.text section
to __turn_mmu_on() in the .idmap.text section may be turned into
something like this:

c0008168 <__enable_mmu>:
c0008168:       f020 0002       bic.w   r0, r0, #2
c000816c:       f420 5080       bic.w   r0, r0, #4096
c0008170:       f000 b846       b.w     c0008200 <____turn_mmu_on_veneer>
[...]
c0008200 <____turn_mmu_on_veneer>:
c0008200:       4778            bx      pc
c0008202:       46c0            nop
c0008204:       e59fc000        ldr     ip, [pc]
c0008208:       e12fff1c        bx      ip
c000820c:       c13dfae1        teqgt   sp, r1, ror #21
[...]
c13dfae0 <__turn_mmu_on>:
c13dfae0:       4600            mov     r0, r0
[...]

After adding --pic-veneer to the LDFLAGS, the veneer is emitted like
this instead:

c0008200 <____turn_mmu_on_veneer>:
c0008200:       4778            bx      pc
c0008202:       46c0            nop
c0008204:       e59fc004        ldr     ip, [pc, #4]
c0008208:       e08fc00c        add     ip, pc, ip
c000820c:       e12fff1c        bx      ip
c0008210:       013d7d31        teqeq   sp, r1, lsr sp
c0008214:       00000000        andeq   r0, r0, r0

Note that this particular example is best addressed by moving
.head.text and .idmap.text closer together, but this issue could
potentially affect any code that needs to execute with the
MMU off.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index eb7bb511f853..ae5b33527f32 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -13,7 +13,7 @@
 # Ensure linker flags are correct
 LDFLAGS		:=
 
-LDFLAGS_vmlinux	:=-p --no-undefined -X
+LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 LDFLAGS_MODULE	+= --be8
-- 
1.8.3.2
