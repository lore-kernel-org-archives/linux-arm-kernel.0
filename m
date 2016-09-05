From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 5 Sep 2016 11:24:02 +0100
Subject: [PATCH v3 9/9] arm64: Work around systems with mismatched cache
 line sizes
In-Reply-To: <CAKv+Gu92Z=k0NXSL2UayuxWv-=wH1aJ3r-ByXxexWmz6sfE7zw@mail.gmail.com>
References: <1473069509-2317-1-git-send-email-suzuki.poulose@arm.com>
 <1473069509-2317-10-git-send-email-suzuki.poulose@arm.com>
 <CAKv+Gu92Z=k0NXSL2UayuxWv-=wH1aJ3r-ByXxexWmz6sfE7zw@mail.gmail.com>
Message-ID: <d7277900-068a-98fc-4f52-4f619ba96cf8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/16 11:10, Ard Biesheuvel wrote:
> On 5 September 2016 at 10:58, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> +/*
>> + * read_ctr - read CTR_EL0. If the system has mismatched
>> + * cache line sizes, provide the system wide safe value.
>> + */
>> +       .macro  read_ctr, reg
>> +alternative_if_not ARM64_MISMATCHED_CACHE_LINE_SIZE
>> +       mrs     \reg, ctr_el0                   // read CTR
>> +       nop
>> +       nop
>> +alternative_else
>> +       adr_l   \reg, arm64_ftr_reg_ctrel0      // Read system wide safe CTR value
>> +       ldr     \reg, [\reg, #ARM64_FTR_SYSVAL] // from arm64_ftr_reg_ctrel0.sys_val
>
> You should be able to use
>
> ldr_l \reg, arm64_ftr_reg_ctrel0 + ARM64_FTR_SYSVAL
>
> here, and save one instruction.

I had given a thought about that and chose the above to account for a
rare chance of arm64_ftr_reg_ctrel0 spanning across a 4K boundary. But,
you are right, ldr_l could treat (arm64_ftr_reg_ctrel0 + ARM64_FTR_SYSVAL)
as the symbol address and still get the right offset.

Suzuki
