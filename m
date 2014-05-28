From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 28 May 2014 06:56:44 -0700
Subject: [PATCH v3 14/14] ARM64: KVM: fix big endian issue in
 access_vm_reg for 32bit guest
In-Reply-To: <20140528091438.GL16428@lvm>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-15-git-send-email-victor.kamensky@linaro.org>
 <20140526175225.GF31431@lvm>
 <CAA3XUr15fJu3vRU3Hq=fajiRCd1gvkdmvJfsa3Te4N-3puwcWA@mail.gmail.com>
 <20140528091438.GL16428@lvm>
Message-ID: <CAA3XUr3=jeNqP6FMSki8Mij-ENu7X+nBRrQ2p_bUODw_9jmgog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 May 2014 02:14, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Tue, May 27, 2014 at 11:11:57PM -0700, Victor Kamensky wrote:
>> On 26 May 2014 10:52, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> > On Tue, May 13, 2014 at 09:14:06AM -0700, Victor Kamensky wrote:
>> >> Fix isssue with 32bit guests running on top of BE KVM host. Guest
>> >> state is retored with double word read operations. Within the high
>> >
>> > restored (spell check should catch this).
>> >
>> > "Guest state is restored with double word read operations."  I don't
>> > know what this sentence is supposed to tell me.
>> >
>> >> and low word data is already byteswap. This code effectively swaps
>> >
>> > "data is already byteswap" is not English.  data is already byteswapped?
>> >
>> >> two words within 64bit value.
>> >>
>> >> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> >> ---
>> >>  arch/arm64/kvm/sys_regs.c | 14 ++++++++++++--
>> >>  1 file changed, 12 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> >> index 060c3a9..4438b47 100644
>> >> --- a/arch/arm64/kvm/sys_regs.c
>> >> +++ b/arch/arm64/kvm/sys_regs.c
>> >> @@ -51,6 +51,16 @@ static u32 cache_levels;
>> >>  /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>> >>  #define CSSELR_MAX 12
>> >>
>> >> +/* Word access indexes for 64bit vm accessor */
>> >> +#ifdef CONFIG_CPU_BIG_ENDIAN
>> >> +#define CP15_REG_MSW_INDEX 0
>> >> +#define CP15_REG_LSW_INDEX 1
>> >> +#else
>> >> +#define CP15_REG_MSW_INDEX 1
>> >> +#define CP15_REG_LSW_INDEX 0
>> >> +#endif
>> >> +
>> >> +
>> >>  /* Which cache CCSIDR represents depends on CSSELR value. */
>> >>  static u32 get_ccsidr(u32 csselr)
>> >>  {
>> >> @@ -137,9 +147,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
>> >>       if (!p->is_aarch32) {
>> >>               vcpu_sys_reg(vcpu, r->reg) = val;
>> >>       } else {
>> >> -             vcpu_cp15(vcpu, r->reg) = val & 0xffffffffUL;
>> >> +             vcpu_cp15(vcpu, r->reg + CP15_REG_LSW_INDEX) = val & 0xffffffffUL;
>> >>               if (!p->is_32bit)
>> >> -                     vcpu_cp15(vcpu, r->reg + 1) = val >> 32;
>> >> +                     vcpu_cp15(vcpu, r->reg + CP15_REG_MSW_INDEX) = val >> 32;
>> >>       }
>> >>       return true;
>> >>  }
>> >> --
>> >> 1.8.1.4
>> >>
>> > I really don't like this. If anything I feel like it should be
>> > abstracted inside vcpu_cp15,
>>
>> good point, please see revised proposal below
>>
>> > but wouldn't it be cleaner to do something
>> > along the lines of:
>> >
>> > u64 *regstore = (u64 *)vcpu->arch.ctxt.cp15[r->reg];
>> > if (p->is_32bit)
>> >         val &= 0xffffffffUL;
>> > *regstore = val;
>>
>> I don't think above will be correct. The way I read
>> it the following hypothetical instructions sequence
>>
>> mcrr    p15, 0, r6, r7, c2    @ TTBR 0
>> mcr    p15, 0, r6, c2, c0, 0 @ 32bit TTBR 0
>>
>> will get TTBR 0 high word to 0, when mrc instruction executes, but
>> it should be left unchanged in case of 'p->is_32bit'
>>
>> How about something like following? Is it move into right direction?
>>
>> From b0a7793b03d9c62f7b9c53a317cb2d19a75c935b Mon Sep 17 00:00:00 2001
>> From: Victor Kamensky <victor.kamensky@linaro.org>
>> Date: Mon, 12 May 2014 13:57:21 -0700
>> Subject: [PATCH] ARM64: KVM: fix big endian issue in access_vm_reg for 32bit
>>  guest
>>
>> Fix issue with 32bit guests running on top of BE KVM host.
>> Indexes of high and low words of 64bit cp15 register are
>> swapped in case of big endian code, since 64bit cp15 state is
>> restored or saved with double word write or read instruction.
>>
>> Define helper macros to access high low words of 64bit cp15
>> register.
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> ---
>>  arch/arm64/include/asm/kvm_host.h | 8 ++++++++
>>  arch/arm64/kvm/sys_regs.c         | 4 ++--
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h
>> b/arch/arm64/include/asm/kvm_host.h
>> index 0a1d697..e9d2e11 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -140,6 +140,14 @@ struct kvm_vcpu_arch {
>>  #define vcpu_sys_reg(v,r)    ((v)->arch.ctxt.sys_regs[(r)])
>>  #define vcpu_cp15(v,r)        ((v)->arch.ctxt.cp15[(r)])
>>
>> +#ifdef CONFIG_CPU_BIG_ENDIAN
>> +#define vcpu_cp15_64_high(v,r) ((v)->arch.ctxt.cp15[((r) + 0)])
>> +#define vcpu_cp15_64_low(v,r) ((v)->arch.ctxt.cp15[((r) + 1)])
>> +#else
>> +#define vcpu_cp15_64_high(v,r) ((v)->arch.ctxt.cp15[((r) + 1)])
>> +#define vcpu_cp15_64_low(v,r) ((v)->arch.ctxt.cp15[((r) + 0)])
>> +#endif
>> +
>>  struct kvm_vm_stat {
>>      u32 remote_tlb_flush;
>>  };
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index a13e7e7..b243e07 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -137,9 +137,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
>>      if (!p->is_aarch32) {
>>          vcpu_sys_reg(vcpu, r->reg) = val;
>>      } else {
>> -        vcpu_cp15(vcpu, r->reg) = val & 0xffffffffUL;
>> +        vcpu_cp15_64_low(vcpu, r->reg) = val & 0xffffffffUL;
>>          if (!p->is_32bit)
>> -            vcpu_cp15(vcpu, r->reg + 1) = val >> 32;
>> +            vcpu_cp15_64_high(vcpu, r->reg) = val >> 32;
>>      }
>>      return true;
>>  }
>> --
>> 1.8.1.4
>
> This is definitely much better than the original patch.
>
>>
>> > But I think the thing that bothers me in general with all these patches
>> > is that they deal specially with a lot of situations where the data
>> > structure was designed specifically to make the code easy to read, and
>> > now it just becomes a really complicated mess.  Have you carefully
>> > considered other options, redesigning the data structure layout etc.?
>>
>> I have considered different options and I am open for
>> suggestions. Bytesswaps quite often could be done in different
>> places but achieve the same result. In several cases I initially
>> developed patch that deals with BE issue in one way and
>> reworked to make it more compact less intrusive. For example
>> in this particular case order of high and low words of 64bit cp15
>> register could be kept the same in BE/LE cases but code that
>> save/restore it could be changed to do byteswap. My opinion
>> that proposed option is more clean.
>>
> What I was thinking is to avoid packing 64-bit values as two 32-bit
> values, so for example having two separate arrays on the kvm_cpu_context
> struct, one for 32-bit coprocessor registers and one for 64-bit
> coprocessor registers.

They cannot be separate it is the same data with two ways
to access: as 64bit value or low word 32bit value. Typically it is LPAE
cp15 memory related registers like TTBR0, as in mcrr, mcr example
in my previous response. mcrr will update high and low word values
of TTBR0, mcr will update only low word of it.

Thanks,
Victor

> That would sort of follow Benjamin Herrenschmidt's manatra about always
> using the correctly typed values everywhere to avoid endianness issues.
>
> Did you look at that approach?  Does it blow up?
>
> -Christoffer
