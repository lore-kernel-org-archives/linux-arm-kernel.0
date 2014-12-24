From: ben@decadent.org.uk (Ben Hutchings)
Date: Wed, 24 Dec 2014 16:54:28 +0100
Subject: [PATCH] ARM: mm: Enable PXN when running non-LPAE kernel on LPAE
 processor
Message-ID: <1419436468.4705.105.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VMSA field of MMFR0 (bottom 4 bits) is incremented for each
added feature.  PXN is supported if the value is >= 4 and LPAE
is supported if it is >= 5.

In case a kernel with CONFIG_ARM_LPAE disabled is used on a
processor that supports LPAE, we can still use PXN in short
descriptors.  So check for >= 4 not == 4.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Jungseung Lee <js07.lee@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
This worked for me in QEMU's vexpress-a15 emulation, but I don't have
real hardware available to test with right now.

Ben.

 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index cda7c40..0872dc0 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -530,7 +530,7 @@ static void __init build_mem_type_table(void)
 	 * in the Short-descriptor translation table format descriptors.
 	 */
 	if (cpu_arch == CPU_ARCH_ARMv7 &&
-		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) == 4) {
+		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) >= 4) {
 		user_pmd_table |= PMD_PXNTABLE;
 	}
 #endif

-- 
Ben Hutchings
If more than one person is responsible for a bug, no one is at fault.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141224/1cd76870/attachment-0001.sig>
