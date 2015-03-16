From: slash.tmp@free.fr (Mason)
Date: Mon, 16 Mar 2015 09:44:46 +0100
Subject: read_cpuid_id() in arch/arm/kernel/setup.c
In-Reply-To: <5505C40C.1050001@free.fr>
References: <55030A68.6070002@free.fr>
 <20150313161953.GS8656@n2100.arm.linux.org.uk> <550312BB.8020902@free.fr>
 <20150313164546.GV8656@n2100.arm.linux.org.uk> <5505C40C.1050001@free.fr>
Message-ID: <550697FE.1020804@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/2015 18:40, Mason wrote:

> On 13/03/2015 17:45, Russell King - ARM Linux wrote:
> 
>> Yes, this one I like - and it probably fixes a potential latent bug
>> where the compiler was free to re-order that mrc outside of the if()
>> statement.
>>
>> Please wrap it up as a normal submission, thanks.
> 
> Proposed patch at the end of this message.
> 
> I'm now puzzling over why it's required to have "memory"
> in read_cpuid_ext's clobber list, and not in read_cpuid's?

Same player shoot again.

-- >8 --
Date: Sun, 15 Mar 2015 17:59:53 +0100
Subject: [PATCH] Use read_cpuid_ext() macro instead of inline asm

In commit 067e710b9a98 ("ARM: 7801/1: prevent gcc 4.5 from reordering extended
CP15 reads above is_smp() test") Paul Walmsley fixed read_cpuid_ext() and added
the following comment.

    The memory clobber prevents gcc 4.5 from reordering the mrc before
    any is_smp() tests, which can cause undefined instruction aborts on
    ARM1136 r0 due to the missing extended CP15 registers.

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
