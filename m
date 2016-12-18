From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 18 Dec 2016 11:57:00 +0000
Subject: [PATCH] ARM: disallow ARM_THUMB for ARMv4 builds
In-Reply-To: <4112999.Nl7pxYH1YF@wuerfel>
References: <20161216091457.2452987-1-arnd@arndb.de>
 <CAKv+Gu93Gtkh7spA-HUHNKSmDjhK_nuwR9KaDu8=S2GDyhUJCA@mail.gmail.com>
 <4112999.Nl7pxYH1YF@wuerfel>
Message-ID: <CAKv+Gu_1zbAB45SQ=702_v3H=RetLFsgknmp52iTSV9M4GSqHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2016 at 21:51, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday, December 16, 2016 5:20:22 PM CET Ard Biesheuvel wrote:
>>
>> Can't we use the old
>>
>> tst lr, #1
>> moveq pc, lr
>> bx lr
>>
>> trick? (where bx lr needs to be emitted as a plain opcode to hide it
>> from the assembler)
>>
>
> Yes, that should work around the specific problem in theory, but back
> when Jonas tried it, it still didn't work. There may also be other
> problems in that configuration.
>

This should do the trick as well, I think:

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 9f157e7c51e7..3bfb32010234 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -835,7 +835,12 @@ ENDPROC(__switch_to)

        .macro  usr_ret, reg
 #ifdef CONFIG_ARM_THUMB
+#ifdef CONFIG_CPU_32v4
+       str     \reg, [sp, #-4]!
+       ldr     pc, [sp], #4
+#else
        bx      \reg
+#endif
 #else
        ret     \reg
 #endif

with the added benefit that we don't clobber the N and Z flags. Of
course, this will result in all CPUs using a non-optimal sequence if
support for v4 is compiled in.
