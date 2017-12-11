From: gengdongjiu@huawei.com (gengdongjiu)
Date: Mon, 11 Dec 2017 20:47:00 +0800
Subject: [RESEND PATCH] arm64: v8.4: Support for new floating point
 multiplication variant
In-Reply-To: <20171211115947.GS12608@e103592.cambridge.arm.com>
References: <1512833322-35503-1-git-send-email-gengdongjiu@huawei.com>
 <20171211115947.GS12608@e103592.cambridge.arm.com>
Message-ID: <4c6d83f1-e8f3-46d7-f3cd-af2db77e3a9c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/12/11 19:59, Dave P Martin wrote:
> On Sat, Dec 09, 2017 at 03:28:42PM +0000, Dongjiu Geng wrote:
>> ARM v8.4 extensions include support for new floating point
>> multiplication variant instructions to the AArch64 SIMD
> 
> Do we have any human-readable description of what the new instructions
> do?
> 
> Since the v8.4 spec itself only describes these as "New Floating
> Point Multiplication Variant", I wonder what "FHM" actually stands
> for.Thanks for the point out.
In fact, this feature only adds two instructions:
FP16 * FP16 + FP32
FP16 * FP16 - FP32

The spec call this bit to ID_AA64ISAR0_EL1.FHM, I do not know why it will call
"FHM", I  think call it "FMLXL" may be better, which can stand for FMLAL/FMLSL instructions.

> 
> Maybe something like "widening half-precision floating-point multiply
> accumulate" is acceptable wording consistent with the existing
> architecture, but I just made that up, so it's not official ;)
how about something like "performing a multiplication of each FP16 element of one
vector with the corresponding FP16 element of a second vector, and to
add or subtract this without an intermediate rounding to the
corresponding FP32 element in a third vector."?

> 
>> instructions set. Let the userspace know about it via a
>> HWCAP bit and MRS emulation.
>>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>> My platform supports this feature, so I need to add it.
>> ---
>>  Documentation/arm64/cpu-feature-registers.txt | 4 +++-
>>  arch/arm64/include/asm/sysreg.h               | 1 +
>>  arch/arm64/include/uapi/asm/hwcap.h           | 1 +
>>  arch/arm64/kernel/cpufeature.c                | 2 ++
>>  arch/arm64/kernel/cpuinfo.c                   | 1 +
>>  5 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
>> index bd9b3fa..a70090b 100644
>> --- a/Documentation/arm64/cpu-feature-registers.txt
>> +++ b/Documentation/arm64/cpu-feature-registers.txt
>> @@ -110,7 +110,9 @@ infrastructure:
>>       x--------------------------------------------------x
>>       | Name                         |  bits   | visible |
>>       |--------------------------------------------------|
>> -     | RES0                         | [63-48] |    n    |
>> +     | RES0                         | [63-52] |    n    |
>> +     |--------------------------------------------------|
>> +     | FHM                          | [51-48] |    y    |
> 
> You also need to update Documentation/arm64/elf_hwcaps.txt.
I will update it, thanks for the point out

> 
> Otherwise, looks OK.
Appreciate for your review.

> 
> Cheers
> ---Dave
> 
>>       |--------------------------------------------------|
>>       | DP                           | [47-44] |    y    |
>>       |--------------------------------------------------|
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 08cc885..1818077 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -419,6 +419,7 @@
>>  #define SCTLR_EL1_CP15BEN    (1 << 5)
>>
>>  /* id_aa64isar0 */
>> +#define ID_AA64ISAR0_FHM_SHIFT               48
>>  #define ID_AA64ISAR0_DP_SHIFT                44
>>  #define ID_AA64ISAR0_SM4_SHIFT               40
>>  #define ID_AA64ISAR0_SM3_SHIFT               36
>> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
>> index cda76fa..f018c3d 100644
>> --- a/arch/arm64/include/uapi/asm/hwcap.h
>> +++ b/arch/arm64/include/uapi/asm/hwcap.h
>> @@ -43,5 +43,6 @@
>>  #define HWCAP_ASIMDDP                (1 << 20)
>>  #define HWCAP_SHA512         (1 << 21)
>>  #define HWCAP_SVE            (1 << 22)
>> +#define HWCAP_ASIMDFHM               (1 << 23)
>>
>>  #endif /* _UAPI__ASM_HWCAP_H */
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index c5ba009..bc7e707 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -123,6 +123,7 @@ static int __init register_cpu_hwcaps_dumper(void)
>>   * sync with the documentation of the CPU feature register ABI.
>>   */
>>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
>> +     ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_FHM_SHIFT, 4, 0),
>>       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_DP_SHIFT, 4, 0),
>>       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SM4_SHIFT, 4, 0),
>>       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SM3_SHIFT, 4, 0),
>> @@ -991,6 +992,7 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
>>       HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM3_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SM3),
>>       HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM4_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SM4),
>>       HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_DP_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDDP),
>> +     HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_FHM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDFHM),
>>       HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_FP),
>>       HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
>>       HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>> index 1e25545..7f94623 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -76,6 +76,7 @@
>>       "asimddp",
>>       "sha512",
>>       "sve",
>> +     "asimdfhm",
>>       NULL
>>  };
>>
>> --
>> 1.9.1
>>
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> 
> .
> 
