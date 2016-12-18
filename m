From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 18 Dec 2016 15:04:24 +0000
Subject: [PATCH] ARM: disallow ARM_THUMB for ARMv4 builds
In-Reply-To: <20161218141630.GP14217@n2100.armlinux.org.uk>
References: <20161216091457.2452987-1-arnd@arndb.de>
 <CAKv+Gu93Gtkh7spA-HUHNKSmDjhK_nuwR9KaDu8=S2GDyhUJCA@mail.gmail.com>
 <4112999.Nl7pxYH1YF@wuerfel>
 <CAKv+Gu_1zbAB45SQ=702_v3H=RetLFsgknmp52iTSV9M4GSqHg@mail.gmail.com>
 <20161218141630.GP14217@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu_KTB+EyQw6-DHEAgswCDvxJTpwH0pJ+ZqB4vz30jrNLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 December 2016 at 14:16, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Sun, Dec 18, 2016 at 11:57:00AM +0000, Ard Biesheuvel wrote:
>> On 16 December 2016 at 21:51, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday, December 16, 2016 5:20:22 PM CET Ard Biesheuvel wrote:
>> >>
>> >> Can't we use the old
>> >>
>> >> tst lr, #1
>> >> moveq pc, lr
>> >> bx lr
>> >>
>> >> trick? (where bx lr needs to be emitted as a plain opcode to hide it
>> >> from the assembler)
>> >>
>> >
>> > Yes, that should work around the specific problem in theory, but back
>> > when Jonas tried it, it still didn't work. There may also be other
>> > problems in that configuration.
>> >
>>
>> This should do the trick as well, I think:
>>
>> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
>> index 9f157e7c51e7..3bfb32010234 100644
>> --- a/arch/arm/kernel/entry-armv.S
>> +++ b/arch/arm/kernel/entry-armv.S
>> @@ -835,7 +835,12 @@ ENDPROC(__switch_to)
>>
>>         .macro  usr_ret, reg
>>  #ifdef CONFIG_ARM_THUMB
>> +#ifdef CONFIG_CPU_32v4
>> +       str     \reg, [sp, #-4]!
>> +       ldr     pc, [sp], #4
>> +#else
>>         bx      \reg
>> +#endif
>>  #else
>>         ret     \reg
>>  #endif
>>
>> with the added benefit that we don't clobber the N and Z flags. Of
>> course, this will result in all CPUs using a non-optimal sequence if
>> support for v4 is compiled in.
>
> We don't clobber those flags anyway.  bx doesn't change any of the flags.
> 'ret' devolves into either bx or a mov instruction.  A mov instruction
> without 's' does not change the flags either.
>

The 'added benefit' is with respect to the tst/moveq/bx sequence,
which clobbers the N and Z flags.

> So there is no "added benefit".  In fact, there's only detrimental
> effects.  str and ldr are going to be several cycles longer than the
> plain mov.
>

Yes, but the kuser helpers are documented as preserving all flags and
registers except the ones that are documents as clobbered. I agree it
is highly unlikely that clobbering the N and Z flags is going to break
anything, but it is an ABI change nonetheless.

> In any case, the "CONFIG_CPU_32v4" alone doesn't hack it, we also have
> CONFIG_CPU_32v3 to also consider.
>

I don't think there are any configurations where CONFIG_CPU_32v3 are
CONFIG_ARM_THUMB are both enabled. The ARMv4 case is significant
because it can be enabled as part of a v4/v5 multiplatform
configuration.

> In any case, I prefer the solution previously posted - to test bit 0 of
> the PC, and select the instruction based on that.  It'll take some
> assembly level macros to handle all cases.
>

The only issue I spotted is that the kuser_get_tls routine has only
two instruction slots for the return sequence, but we can easily work
around that by moving the TLS hardware instruction around in the
template (and update the memcpy accordingly in kuser_init()

It does appear that the tst/moveq/bx failed to work correctly when
tested on FA526, according to the link quoted by Arnd. But the below
builds ok for me on a v4/v4t/v5 multiarch configuration (apologies on
behalf of Gmail for the whitespace corruption, I can resend it as a
proper patch)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 9f157e7c51e7..e849965e3136 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -833,9 +833,21 @@ ENDPROC(__switch_to)
  */
  THUMB( .arm )

+ .irp i, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14
+ .set .Lreg_\i, \i
+ .endr
+ .set .Lreg_ip, 12
+ .set .Lreg_lr, 14
+
  .macro usr_ret, reg
 #ifdef CONFIG_ARM_THUMB
+#if defined(CONFIG_CPU_32v3) || defined(CONFIG_CPU_32v4)
+ tst \reg, #1 @ preserves the C and V flags
+ moveq pc, \reg
+ .word 0xe12fff10 | .Lreg_\reg @ correct order for LE and BE32
+#else
  bx \reg
+#endif
 #else
  ret \reg
 #endif
@@ -1001,11 +1013,10 @@ kuser_cmpxchg32_fixup:
 __kuser_get_tls: @ 0xffff0fe0
  ldr r0, [pc, #(16 - 8)] @ read TLS, set in kuser_get_tls_init
  usr_ret lr
- mrc p15, 0, r0, c13, c0, 3 @ 0xffff0fe8 hardware TLS code
  kuser_pad __kuser_get_tls, 16
- .rep 3
  .word 0 @ 0xffff0ff0 software TLS value, then
- .endr @ pad up to __kuser_helper_version
+ mrc p15, 0, r0, c13, c0, 3 @ 0xffff0ff4 hardware TLS code
+ .word 0 @ pad up to __kuser_helper_version

 __kuser_helper_version: @ 0xffff0ffc
  .word ((__kuser_helper_end - __kuser_helper_start) >> 5)
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index bc698383e822..7746090bd930 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -777,10 +777,10 @@ static void __init kuser_init(void *vectors)

  /*
  * vectors + 0xfe0 = __kuser_get_tls
- * vectors + 0xfe8 = hardware TLS instruction at 0xffff0fe8
+ * vectors + 0xff4 = hardware TLS instruction at 0xffff0ff4
  */
  if (tls_emu || has_tls_reg)
- memcpy(vectors + 0xfe0, vectors + 0xfe8, 4);
+ memcpy(vectors + 0xfe0, vectors + 0xff4, 4);
 }
 #else
 static inline void __init kuser_init(void *vectors)
