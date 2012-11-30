From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 01:45:52 -0500
Subject: [PATCH v4 11/14] KVM: ARM: Demux CCSIDR in the userspace API
In-Reply-To: <20121119150349.GD3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154328.2836.78376.stgit@chazy-air>
 <20121119150349.GD3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98qLwZSAiKo+UqtQz5P+d1LM8gq7ARRYWLwd+b4obcxFVPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 10:03 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Nov 10, 2012 at 03:43:28PM +0000, Christoffer Dall wrote:
>> The Cache Size Selection Register (CSSELR) selects the current Cache
>> Size ID Register (CCSIDR).  You write which cache you are interested
>> in to CSSELR, and read the information out of CCSIDR.
>>
>> Which cache numbers are valid is known by reading the Cache Level ID
>> Register (CLIDR).
>>
>> To export this state to userspace, we add a KVM_REG_ARM_DEMUX
>> numberspace (17), which uses 8 bits to represent which register is
>> being demultiplexed (0 for CCSIDR), and the lower 8 bits to represent
>> this demultiplexing (in our case, the CSSELR value, which is 4 bits).
>>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
>
> [...]
>
>>  Documentation/virtual/kvm/api.txt |    2
>>  arch/arm/include/uapi/asm/kvm.h   |    9 ++
>>  arch/arm/kvm/coproc.c             |  163 ++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 171 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 9671cd2..bf8f99c 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -1804,6 +1804,8 @@ ARM 32-bit CP15 registers have the following id bit patterns:
>>  ARM 64-bit CP15 registers have the following id bit patterns:
>>    0x4003 0000 000F <zero:1> <zero:4> <crm:4> <opc1:4> <zero:3>
>>
>> +ARM CCSIDR registers are demultiplexed by CSSELR value:
>> +  0x4002 0000 0011 00 <csselr:8>
>>
>>  4.69 KVM_GET_ONE_REG
>>
>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>> index a807d9a..78a629c 100644
>> --- a/arch/arm/include/uapi/asm/kvm.h
>> +++ b/arch/arm/include/uapi/asm/kvm.h
>> @@ -80,6 +80,15 @@ struct kvm_arch_memory_slot {
>>  #define KVM_REG_ARM_CORE             (0x0010 << KVM_REG_ARM_COPROC_SHIFT)
>>  #define KVM_REG_ARM_CORE_REG(name)   (offsetof(struct kvm_regs, name) / 4)
>>
>> +/* Some registers need more space to represent values. */
>> +#define KVM_REG_ARM_DEMUX            (0x0011 << KVM_REG_ARM_COPROC_SHIFT)
>> +#define KVM_REG_ARM_DEMUX_ID_MASK    0x000000000000FF00
>> +#define KVM_REG_ARM_DEMUX_ID_SHIFT   8
>> +#define KVM_REG_ARM_DEMUX_ID_CCSIDR  (0x00 << KVM_REG_ARM_DEMUX_ID_SHIFT)
>> +#define KVM_REG_ARM_DEMUX_VAL_MASK   0x00000000000000FF
>> +#define KVM_REG_ARM_DEMUX_VAL_SHIFT  0
>> +
>> +
>>  /* KVM_IRQ_LINE irq field index values */
>>  #define KVM_ARM_IRQ_TYPE_SHIFT               24
>>  #define KVM_ARM_IRQ_TYPE_MASK                0xff
>> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
>> index 95a0f5e..9ce5861 100644
>> --- a/arch/arm/kvm/coproc.c
>> +++ b/arch/arm/kvm/coproc.c
>> @@ -35,6 +35,12 @@
>>   * Co-processor emulation
>>   *****************************************************************************/
>>
>> +/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
>> +static u32 cache_levels;
>> +
>> +/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>> +#define CSSELR_MAX 12
>> +
>>  int kvm_handle_cp10_id(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  {
>>       kvm_inject_undefined(vcpu);
>> @@ -548,11 +554,112 @@ static int set_invariant_cp15(u64 id, void __user *uaddr)
>>       return 0;
>>  }
>>
>> +static bool is_valid_cache(u32 val)
>> +{
>> +     u32 level, ctype;
>> +
>> +     if (val >= CSSELR_MAX)
>> +             return -ENOENT;
>> +
>> +     /* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
>> +        level = (val >> 1);
>> +        ctype = (cache_levels >> (level * 3)) & 7;
>> +
>> +     switch (ctype) {
>> +     case 0: /* No cache */
>> +             return false;
>> +     case 1: /* Instruction cache only */
>> +             return (val & 1);
>> +     case 2: /* Data cache only */
>> +     case 4: /* Unified cache */
>> +             return !(val & 1);
>> +     case 3: /* Separate instruction and data caches */
>> +             return true;
>> +     default: /* Reserved: we can't know instruction or data. */
>> +             return false;
>> +     }
>> +}
>> +
>> +/* Which cache CCSIDR represents depends on CSSELR value. */
>> +static u32 get_ccsidr(u32 csselr)
>> +{
>> +     u32 ccsidr;
>> +
>> +     /* Make sure noone else changes CSSELR during this! */
>> +     local_irq_disable();
>> +     /* Put value into CSSELR */
>> +     asm volatile("mcr p15, 2, %0, c0, c0, 0" : : "r" (csselr));
>
> You need an isb() here, otherwise you might still address the wrong
> cache (the two accesses don't hazard in the CPU).
>
that was just totally obvious ;)
