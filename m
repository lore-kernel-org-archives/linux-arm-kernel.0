From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 25 Oct 2016 17:48:36 +0100
Subject: [PATCH 2/2] arm64: Support systems without FP/ASIMD
In-Reply-To: <CAKv+Gu9mzX5dUgkJzDYEwxP+u9RVL=RWdsPepQ-UeCCxpx1j_g@mail.gmail.com>
References: <1477403433-2279-1-git-send-email-suzuki.poulose@arm.com>
 <1477403433-2279-3-git-send-email-suzuki.poulose@arm.com>
 <CAKv+Gu9mzX5dUgkJzDYEwxP+u9RVL=RWdsPepQ-UeCCxpx1j_g@mail.gmail.com>
Message-ID: <a29f3668-4caf-5c88-82c0-8e2208fb285c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/16 15:00, Ard Biesheuvel wrote:
> Hi Suzuki,
>
> On 25 October 2016 at 14:50, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> The arm64 kernel assumes that FP/ASIMD units are always present
>> and accesses the FP/ASIMD specific registers unconditionally. This
>> could cause problems when they are absent. This patch adds the
>> support for kernel handling systems without FP/ASIMD by skipping the
>> register access within the kernel. For kvm, we trap the accesses
>> to FP/ASIMD and inject an undefined instruction exception to the VM.
>>
>> The callers of the exported kernel_neon_begin_parital() should
>> make sure that the FP/ASIMD is supported.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> ---
>>  arch/arm64/crypto/aes-ce-ccm-glue.c |  2 +-
>>  arch/arm64/crypto/aes-ce-cipher.c   |  2 ++
>>  arch/arm64/crypto/ghash-ce-glue.c   |  2 ++
>>  arch/arm64/crypto/sha1-ce-glue.c    |  2 ++
>>  arch/arm64/include/asm/cpufeature.h |  8 +++++++-
>>  arch/arm64/include/asm/neon.h       |  3 ++-
>>  arch/arm64/kernel/cpufeature.c      | 15 +++++++++++++++
>>  arch/arm64/kernel/fpsimd.c          | 14 ++++++++++++++
>>  arch/arm64/kvm/handle_exit.c        | 11 +++++++++++
>>  arch/arm64/kvm/hyp/hyp-entry.S      |  9 ++++++++-
>>  arch/arm64/kvm/hyp/switch.c         |  5 ++++-
>>  11 files changed, 68 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/crypto/aes-ce-ccm-glue.c b/arch/arm64/crypto/aes-ce-ccm-glue.c
>> index f4bf2f2..d001b4e 100644
>> --- a/arch/arm64/crypto/aes-ce-ccm-glue.c
>> +++ b/arch/arm64/crypto/aes-ce-ccm-glue.c
>> @@ -296,7 +296,7 @@ static struct aead_alg ccm_aes_alg = {
>>
>>  static int __init aes_mod_init(void)
>>  {
>> -       if (!(elf_hwcap & HWCAP_AES))
>> +       if (!(elf_hwcap & HWCAP_AES) || !system_supports_fpsimd())
>
> This looks weird to me. All crypto extensionsinstructions except CRC
> operate strictly on FP/ASIMD registers, and so support for FP/ASIMD is
> implied by having HWCAP_AES. In other words, I think it makes more
> sense to sanity check that the info registers are consistent with each
> other in core code than modifying each user (which for HWCAP_xxx
> includes userland) to double check that the world is sane.

You're right. I will respin it.
Btw, I think we need the following feature check for the above. I will send
that in and remove the explicit HWCAP_AES check.

module_cpu_feature_match(AES, aes_mod_init());

Cheers
Suzuki
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
