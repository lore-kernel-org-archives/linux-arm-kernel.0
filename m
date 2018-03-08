From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 Mar 2018 13:46:34 +0000
Subject: [PATCH v4 5/5] arm64/kernel: enable A53 erratum #8434319 handling
 at runtime
In-Reply-To: <20180308134512.GA18452@arm.com>
References: <20180306171535.25681-1-ard.biesheuvel@linaro.org>
 <20180306171535.25681-6-ard.biesheuvel@linaro.org>
 <20180308134512.GA18452@arm.com>
Message-ID: <CAKv+Gu_4xYW=kc3WGmMpneUqboasdJNFAZ19oCOws9=wgADz7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2018 at 13:45, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Mar 06, 2018 at 05:15:35PM +0000, Ard Biesheuvel wrote:
>> Omit patching of ADRP instruction at module load time if the current
>> CPUs are not susceptible to the erratum.
>
> [...]
>
>> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
>> index 534bf1d47119..1a583ccace00 100644
>> --- a/arch/arm64/kernel/module-plts.c
>> +++ b/arch/arm64/kernel/module-plts.c
>> @@ -158,7 +158,8 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
>>                       break;
>>               case R_AARCH64_ADR_PREL_PG_HI21_NC:
>>               case R_AARCH64_ADR_PREL_PG_HI21:
>> -                     if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419))
>> +                     if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) ||
>> +                         !cpus_have_const_cap(ARM64_WORKAROUND_843419))
>>                               break;
>>
>>                       /*
>> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
>> index 89217704944e..47b40aaa1a5d 100644
>> --- a/arch/arm64/kernel/module.c
>> +++ b/arch/arm64/kernel/module.c
>> @@ -201,6 +201,7 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, __le32 *place, u64 val,
>>  static int reloc_insn_adrp(struct module *mod, __le32 *place, u64 val)
>>  {
>>       if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) ||
>> +         !cpus_have_const_cap(ARM64_WORKAROUND_843419) ||
>
> Mind if I drop the IS_ENABLED check here and in the hunk above? The
> const_cap check along should be sufficient, no?
>

Without the IS_ENABLED() check, the code will always be present in the
object file.

I have no strong preference either way, though.
