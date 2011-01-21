From: stanleymiao@gmail.com (Stanley.Miao)
Date: Fri, 21 Jan 2011 18:51:27 +0800
Subject: [PATCH 2/3] support ARM BE8 mode on a little endian machine
In-Reply-To: <20110121094649.GG13235@n2100.arm.linux.org.uk>
References: <1295419487-31185-1-git-send-email-stanley.miao@windriver.com>
	<1295419487-31185-3-git-send-email-stanley.miao@windriver.com>
	<20110121094649.GG13235@n2100.arm.linux.org.uk>
Message-ID: <AANLkTika2nhjFG96g+R73oR-NuBJA92s86yQjVjNP=qF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Jan 19, 2011 at 02:44:46PM +0800, Stanley.Miao wrote:
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index a00055d..a33075b 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -131,6 +131,9 @@ start:
>> ? ? ? ? ? ? ? mov ? ? r0, r0
>> ? ? ? ? ? ? ? .endr
>>
>> +#ifdef CONFIG_BE8_ON_LE
>> + ? ? ? ? ? ? setend ?be
>> +#endif
>
> This should not be before the magic numbers.

I will move it downward in V3.

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -131,9 +131,6 @@ start:
                mov     r0, r0
                .endr

-#ifdef CONFIG_BE8_ON_LE
-               setend  be
-#endif
                b       1f
                .word   0x016f2818              @ Magic numbers to
help the loader
                .word   start                   @ absolute load/run
zImage address
@@ -141,6 +138,10 @@ start:
 1:             mov     r7, r1                  @ save architecture ID
                mov     r8, r2                  @ save atags pointer

+#ifdef CONFIG_BE8_ON_LE
+               setend  be
+#endif
+
 #ifndef __ARM_ARCH_2__

>
>> ? ? ? ? ? ? ? b ? ? ? 1f
>> ? ? ? ? ? ? ? .word ? 0x016f2818 ? ? ? ? ? ? ?@ Magic numbers to help the loader
>> ? ? ? ? ? ? ? .word ? start ? ? ? ? ? ? ? ? ? @ absolute load/run zImage address
>> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
>> index f1e5a9b..1504d09 100644
>> --- a/arch/arm/include/asm/setup.h
>> +++ b/arch/arm/include/asm/setup.h
>> @@ -173,15 +173,20 @@ struct tagtable {
>> ? ? ? int (*parse)(const struct tag *);
>> ?};
>>
>> +#ifdef CONFIG_BE8_ON_LE
>> +#define read_tag(a) ?le32_to_cpu(a)
>> +#else
>> +#define read_tag(a) ?a
>> +#endif
>
> I think this is going to cause sparse errors. ?Has it been checked with
> sparse?

Yes, no sparse error.

>
> What about those structures which contain u8's and u16's ? ?These can't
> be dealt with a le32_to_cpu().

I will add read_tag32 and read_tag16 in V3.  u8 is not needed.

Stanley.

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
