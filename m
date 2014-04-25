From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 25 Apr 2014 09:16:39 +0800
Subject: [PATCH v3 13/13] virt: arm: support hip04 gic
In-Reply-To: <87ppk9v9u0.fsf@approximate.cambridge.arm.com>
References: <1397801156-25682-1-git-send-email-haojian.zhuang@linaro.org>
 <1397801156-25682-14-git-send-email-haojian.zhuang@linaro.org>
 <87ppk9v9u0.fsf@approximate.cambridge.arm.com>
Message-ID: <CAD6h2NQH9Pj2zZkQJAyX6G+ntm0FU+LqdOtH7pKBjNGRV5yx6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2014 20:15, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, Apr 18 2014 at  7:05:56 am BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
>> In HiP04 SoC, the address of GICH_APR & GICH_LR0 registers are different
>> from ARM standard SoC. So add the support of HiP04 SoC in VGIC.
>
> Please explain the differences in the commit message.
>
OK. I'll append it.

>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  arch/arm/kvm/interrupts_head.S  | 23 +++++++++++++++++++----
>>  include/linux/irqchip/arm-gic.h |  3 +++
>>  virt/kvm/arm/vgic.c             | 10 ++++++++--
>>  3 files changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
>> index 76af9302..13e4144 100644
>> --- a/arch/arm/kvm/interrupts_head.S
>> +++ b/arch/arm/kvm/interrupts_head.S
>> @@ -419,7 +419,9 @@ vcpu      .req    r0              @ vcpu pointer always in r0
>>       ldr     r7, [r2, #GICH_EISR1]
>>       ldr     r8, [r2, #GICH_ELRSR0]
>>       ldr     r9, [r2, #GICH_ELRSR1]
>> -     ldr     r10, [r2, #GICH_APR]
>> +     ldr     r10, =gich_apr
>> +     ldr     r10, [r10]
>> +     ldr     r10, [r2, r10]
>>
>>       str     r3, [r11, #VGIC_CPU_HCR]
>>       str     r4, [r11, #VGIC_CPU_VMCR]
>> @@ -435,7 +437,9 @@ vcpu      .req    r0              @ vcpu pointer always in r0
>>       str     r5, [r2, #GICH_HCR]
>>
>>       /* Save list registers */
>> -     add     r2, r2, #GICH_LR0
>> +     ldr     r10, =gich_lr0
>> +     ldr     r10, [r10]
>> +     add     r2, r2, r10
>>       add     r3, r11, #VGIC_CPU_LR
>>       ldr     r4, [r11, #VGIC_CPU_NR_LR]
>>  1:   ldr     r6, [r2], #4
>> @@ -469,10 +473,14 @@ vcpu    .req    r0              @ vcpu pointer always in r0
>>
>>       str     r3, [r2, #GICH_HCR]
>>       str     r4, [r2, #GICH_VMCR]
>> -     str     r8, [r2, #GICH_APR]
>> +     ldr     r6, =gich_apr
>> +     ldr     r6, [r6]
>> +     str     r8, [r2, r6]
>>
>>       /* Restore list registers */
>> -     add     r2, r2, #GICH_LR0
>> +     ldr     r6, =gich_lr0
>> +     ldr     r6, [r6]
>> +     add     r2, r2, r6
>>       add     r3, r11, #VGIC_CPU_LR
>>       ldr     r4, [r11, #VGIC_CPU_NR_LR]
>>  1:   ldr     r6, [r3], #4
>
> So we get four extra memory accesses per world switch, just to find out
> about the new fancy memory map. Let's just say that I'm not exactly
> pleased.
>
> How about encoding that in the field containing the number of LRs? the
> distance between GICH_APR and GICH_LR0 is constant (0x10), so we only
> need to encode the offset of GICH_APR. This way, we only have to read
> one single word from memory. Not pretty, but I'm not really willing to
> impact
>
Yes, it's better.

>
>> @@ -618,3 +626,10 @@ vcpu     .req    r0              @ vcpu pointer always in r0
>>  .macro load_vcpu
>>       mrc     p15, 4, vcpu, c13, c0, 2        @ HTPIDR
>>  .endm
>> +
>> +     .global gich_apr
>> +gich_apr:
>> +     .long   GICH_APR
>> +     .global gich_lr0
>> +gich_lr0:
>> +     .long   GICH_LR0
>> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
>> index 55933aa..653525b 100644
>> --- a/include/linux/irqchip/arm-gic.h
>> +++ b/include/linux/irqchip/arm-gic.h
>> @@ -49,6 +49,8 @@
>>  #define GICH_ELRSR1                  0x34
>>  #define GICH_APR                     0xf0
>>  #define GICH_LR0                     0x100
>> +#define HIP04_GICH_APR                       0x70
>> +#define HIP04_GICH_LR0                       0x80
>>
>>  #define GICH_HCR_EN                  (1 << 0)
>>  #define GICH_HCR_UIE                 (1 << 1)
>> @@ -78,6 +80,7 @@
>>  struct device_node;
>>
>>  extern struct irq_chip gic_arch_extn;
>> +extern unsigned int gich_apr, gich_lr0;
>>
>>  void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
>>                   u32 offset, struct device_node *);
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index 47b2983..010e491 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -1478,8 +1478,14 @@ int kvm_vgic_hyp_init(void)
>>
>>       vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
>>       if (!vgic_node) {
>> -             kvm_err("error: no compatible vgic node in DT\n");
>> -             return -ENODEV;
>> +             vgic_node = of_find_compatible_node(NULL, NULL,
>> +                                                 "hisilicon,hip04-gic");
>> +             if (!vgic_node) {
>> +                     kvm_err("error: no compatible vgic node in DT\n");
>> +                     return -ENODEV;
>> +             }
>> +             gich_apr = HIP04_GICH_APR;
>> +             gich_lr0 = HIP04_GICH_LR0;
>
> Consider using of_find_matching_node_and_match instead, with a set of
> flags for this particular case.
>
OK. I'll use it.

Thanks
Haojian
