From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 22 May 2015 17:29:20 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <15864413.ed8EFg1NLl@wuerfel>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
 <15864413.ed8EFg1NLl@wuerfel>
Message-ID: <CALszF6D-3pXHtyVMwhO0JkT-dCSSB98UNDHNN7-LD04Wdgd2cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-22 16:50 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> [one small request as I have four armv7-m folks on Cc already:
>  could one of you try to fix the warning that I get with every
>  single build: "/git/arm-soc/arch/arm/kernel/head-nommu.S: Assembler
> messages: /git/arm-soc/arch/arm/kernel/head-nommu.S:167: Warning:
> Use of r13 as a source register is deprecated when r15 is the
> destination register."]

Moving r13 to r12 and returning r12 seems to do the job (see below).
But I don't know if there is a more elegant way, and if it is also
valid for other architectures than armv7-m.
I can propose a patch if someone can confirm it is valid.

Regards,
Maxime

-------------------------------------------------------------------------------------------------------------

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index aebfbf7..e84bdad 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -164,7 +164,8 @@ __after_proc_init:
 #endif
        mcr     p15, 0, r0, c1, c0, 0           @ write control reg
 #endif /* CONFIG_CPU_CP15 */
-       ret     r13
+       mov     r12, r13
+       ret     r12
 ENDPROC(__after_proc_init)
        .ltorg
