From: anup.patel@linaro.org (Anup Patel)
Date: Tue, 30 Apr 2013 10:58:14 +0530
Subject: [PATCH V2] arm64: KVM: Reset arch_timer upon vcpu reset
In-Reply-To: <CAEDV+gJOMnoWVHU3bqUBUzciy7mx38a1wVWqTP1TMbvS8XXDCg@mail.gmail.com>
References: <1367220500-5690-1-git-send-email-anup.patel@linaro.org>
 <CAEDV+gJOMnoWVHU3bqUBUzciy7mx38a1wVWqTP1TMbvS8XXDCg@mail.gmail.com>
Message-ID: <CALrVBks5Nq5ti9NeozALBxAmkkKE629Lqz0BAHeiKqU8pW9c1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 April 2013 22:10, Christoffer Dall <cdall@cs.columbia.edu> wrote:
> On Mon, Apr 29, 2013 at 12:28 AM, Anup Patel <anup.patel@linaro.org> wrote:
>> This patch does arch_timer reset (i.e. kvm_timer_vcpu_reset()) when
>> a vcpu resetted by kvm_reset_vcpu().
>>
>> The kvm_reset_vcpu() also informs guest timer irq number to arch_timer
>> code via kvm_timer_vcpu_reset().
>
> This commit text did not parse.
>
> Might I suggest:
>
> "Reset the arch_timer on cpu reset and configure guest virtual timer
> irq in the process".

Ok, will change commit description.

>
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  arch/arm64/include/asm/kvm_arch_timer.h |    2 ++
>>  arch/arm64/kvm/reset.c                  |   11 +++++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kvm_arch_timer.h b/arch/arm64/include/asm/kvm_arch_timer.h
>> index eb02273..0f36603 100644
>> --- a/arch/arm64/include/asm/kvm_arch_timer.h
>> +++ b/arch/arm64/include/asm/kvm_arch_timer.h
>> @@ -50,6 +50,8 @@ struct arch_timer_cpu {
>>
>>  int kvm_timer_hyp_init(void);
>>  int kvm_timer_init(struct kvm *kvm);
>> +void kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu,
>> +                         const struct kvm_irq_level *irq);
>>  void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
>>  void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu);
>>  void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu);
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 64e0740..7c9cebc 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -27,6 +27,7 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/kvm_arm.h>
>>  #include <asm/kvm_coproc.h>
>> +#include <asm/kvm_arch_timer.h>
>>
>>  /*
>>   * ARMv8 Reset Values
>> @@ -40,6 +41,11 @@ static struct kvm_regs default_regs_reset32 = {
>>                         COMPAT_PSR_I_BIT | COMPAT_PSR_F_BIT),
>>  };
>>
>> +static const struct kvm_irq_level default_vtimer_irq = {
>> +       .irq = 27,
>> +       .level = 1,
>> +};
>> +
>>  static bool cpu_has_32bit_el1(void)
>>  {
>>         u64 pfr0;
>> @@ -75,6 +81,7 @@ int kvm_arch_dev_ioctl_check_extension(long ext)
>>  int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>  {
>>         struct kvm_regs *cpu_reset;
>> +       const struct kvm_irq_level *cpu_vtimer_irq;
>>
>>         switch (vcpu->arch.target) {
>>         default:
>> @@ -86,6 +93,7 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>                 } else {
>>                         cpu_reset = &default_regs_reset;
>>                 }
>> +               cpu_vtimer_irq = &default_vtimer_irq;
>>                 break;
>>         }
>>
>> @@ -95,5 +103,8 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>         /* Reset system registers */
>>         kvm_reset_sys_regs(vcpu);
>>
>> +       /* Reset arch_timer context */
>> +       kvm_timer_vcpu_reset(vcpu, cpu_vtimer_irq);
>> +
>>         return 0;
>>  }
>> --
>> 1.7.9.5
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm at lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

Regards,
Anup
