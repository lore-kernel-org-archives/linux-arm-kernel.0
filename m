From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 9 Mar 2015 19:12:46 +0100
Subject: [PATCH v2] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <20150309180645.GD8656@n2100.arm.linux.org.uk>
References: <1425556302-3370-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150309180645.GD8656@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu8yDK_U_J-yeA4QRypNT=TKjxNtkyiKnJaogacDt5_jrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 March 2015 at 19:06, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Mar 05, 2015 at 12:51:42PM +0100, Ard Biesheuvel wrote:
>> @@ -393,6 +393,20 @@ static void __init cpuid_init_hwcaps(void)
>>       vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
>>       if (vmsa >= 5)
>>               elf_hwcap |= HWCAP_LPAE;
>> +
>> +     /* check for supported v8 Crypto instructions */
>> +     isar5 = read_cpuid_ext(CPUID_EXT_ISAR5);
>> +
>> +     switch ((isar5 >> 4) & 0xf) {
>> +     case 2: elf_hwcap2 |= HWCAP2_PMULL;     /* pmull implies aes */
>> +     case 1: elf_hwcap2 |= HWCAP2_AES;
>> +     }
>> +     if (((isar5 >> 8) & 0xf) == 1)
>> +             elf_hwcap2 |= HWCAP2_SHA1;
>> +     if (((isar5 >> 12) & 0xf) == 1)
>> +             elf_hwcap2 |= HWCAP2_SHA2;
>> +     if (((isar5 >> 16) & 0xf) == 1)
>> +             elf_hwcap2 |= HWCAP2_CRC32;
>
> Reading through the ARMv7 ARM, the ISAR registers seem to work in a way
> that "feature >= N" is sufficient to test for something (in other words,
> the feature revision bits build on previous instructions added by older
> revisions of that feature.)
>

There was quite some discussion about that when we implemented this
for arm64. Perhaps Steve wants to elaborate on the details, because I
don't remember them exactly.

> Hence why PMULL implies AES - that follows the same pattern.  So, I wonder
> if those == should all be >=, and there should be a "default:" before
> "case 2:" with the zero case handled separately.
>

Quoting from my version of the ARM ARM (DDI0487A_d):

AES, bits [7:4]
Indicates whether AES instructions are implemented in AArch32.
0000 No AES instructions implemented.
0001 AESE, AESD, AESMC, and AESIMC implemented.
0010 As for 0001 , plus PMULL/PMULL2 instructions operating on 64-bit
data quantities.
All other values are reserved.

Even though they are obviously not bitfields, 'reserved' to me
suggests that it is still incorrect to assume both PMULL and AES
capability for values not listed yet > 0b0010.
The same applies to the other blocks: all other values are reserved.

-- 
Ard.
