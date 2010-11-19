From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Nov 2010 11:48:31 +0000
Subject: [PATCH 1/5] ARM: pgtable: switch order of Linux vs hardware page
	tables
In-Reply-To: <E1PIloA-0007qU-ME@rmk-PC.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
	<E1PIloA-0007qU-ME@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTik043UX-cXyriVAwzFTNNTtCTcxYd6VN_gYqCFe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2010 17:28, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -158,7 +156,7 @@ ENTRY(cpu_v7_set_pte_ext)
> ? ? ? ?tstne ? r1, #L_PTE_PRESENT
> ? ? ? ?moveq ? r3, #0
>
> - ? ? ? str ? ? r3, [r0]
> + ? ? ? str ? ? r3, [r0, #2048]!

Thumb-2 build gives "offset out of range".  We need to do a separate
ADD for this case.

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 688deda..9aba33c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -186,7 +186,9 @@ ENTRY(cpu_v7_set_pte_ext)
 	tstne	r1, #L_PTE_PRESENT
 	moveq	r3, #0

-	str	r3, [r0, #2048]!
+ ARM(	str	r3, [r0, #2048]!	)
+ THUMB(	str	r3, [r0, #2048]		)
+ THUMB(	add	r0, r0, #2048		)
 #endif	/* CONFIG_ARM_LPAE */
 	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
 #endif


-- 
Catalin
