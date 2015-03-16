From: slash.tmp@free.fr (Mason)
Date: Tue, 17 Mar 2015 00:30:37 +0100
Subject: read_cpuid_id() in arch/arm/kernel/setup.c
In-Reply-To: <55075673.5010600@free.fr>
References: <55030A68.6070002@free.fr>
 <20150313161953.GS8656@n2100.arm.linux.org.uk> <550312BB.8020902@free.fr>
 <20150313164546.GV8656@n2100.arm.linux.org.uk> <5505C40C.1050001@free.fr>
 <550697FE.1020804@free.fr>
 <alpine.DEB.2.02.1503161641000.29420@utopia.booyaka.com>
 <55075673.5010600@free.fr>
Message-ID: <5507679D.1080307@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/2015 23:17, Mason wrote:

> Will post an (hopefully) improved commit message ASAP.

-- >8 --
Date: Sun, 15 Mar 2015 17:59:53 +0100
Subject: [PATCH] Use read_cpuid_ext() macro instead of inline asm

Replace inline asm statement in __get_cpu_architecture() with equivalent macro
invocation, i.e. read_cpuid_ext(CPUID_EXT_MMFR0);

As an added bonus, this squashes a potential bug described by Paul Walmsley
in commit 067e710b9a98 ("ARM: 7801/1: prevent gcc 4.5 from reordering extended
CP15 reads above is_smp() test").

Signed-off-by: Mason <slash.tmp@free.fr>
---
 arch/arm/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e55408e..1d60beb 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -246,12 +246,9 @@ static int __get_cpu_architecture(void)
 		if (cpu_arch)
 			cpu_arch += CPU_ARCH_ARMv3;
 	} else if ((read_cpuid_id() & 0x000f0000) == 0x000f0000) {
-		unsigned int mmfr0;
-
 		/* Revised CPUID format. Read the Memory Model Feature
 		 * Register 0 and check for VMSAv7 or PMSAv7 */
-		asm("mrc	p15, 0, %0, c0, c1, 4"
-		    : "=r" (mmfr0));
+		unsigned int mmfr0 = read_cpuid_ext(CPUID_EXT_MMFR0);
 		if ((mmfr0 & 0x0000000f) >= 0x00000003 ||
 		    (mmfr0 & 0x000000f0) >= 0x00000030)
 			cpu_arch = CPU_ARCH_ARMv7;
-- 
2.3.2
