From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 May 2014 22:16:22 +0800
Subject: [PATCH v9 14/14] virt: arm: support hip04 gic
In-Reply-To: <20140520140153.GL5292@lvm>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-15-git-send-email-haojian.zhuang@linaro.org>
 <20140520134441.GK5292@lvm>
 <CAD6h2NQyG1GSneWMpHmYxD-dPS7w9w2fe8vDdj-f834T2yqn1w@mail.gmail.com>
 <20140520140153.GL5292@lvm>
Message-ID: <CAD6h2NQZGBa5U0-tmj=wtsFpcqnV2tHx+_vESrx8+3r7dGpHjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2014 22:01, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Tue, May 20, 2014 at 09:52:53PM +0800, Haojian Zhuang wrote:
>> On 20 May 2014 21:44, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> > On Tue, May 20, 2014 at 09:10:27PM +0800, Haojian Zhuang wrote:
>
> [...]
>
>> >> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> >> index 47b2983..4c0c1e9 100644
>> >> --- a/virt/kvm/arm/vgic.c
>> >> +++ b/virt/kvm/arm/vgic.c
>> >> @@ -76,6 +76,8 @@
>> >>  #define IMPLEMENTER_ARM              0x43b
>> >>  #define GICC_ARCH_VERSION_V2 0x2
>> >>
>> >> +#define vgic_nr_lr(vcpu)     (vcpu->hw_cfg & HWCFG_NR_LR_MASK)
>> >> +
>> >>  /* Physical address of vgic virtual cpu interface */
>> >>  static phys_addr_t vgic_vcpu_base;
>> >>
>> >> @@ -97,7 +99,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
>> >>  static void vgic_update_state(struct kvm *kvm);
>> >>  static void vgic_kick_vcpus(struct kvm *kvm);
>> >>  static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
>> >> -static u32 vgic_nr_lr;
>> >> +static u32 vgic_hw_cfg;
>> >>
>> >>  static unsigned int vgic_maint_irq;
>> >>
>> >> @@ -624,9 +626,9 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
>> >>       struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>> >>       int vcpu_id = vcpu->vcpu_id;
>> >>       int i, irq, source_cpu;
>> >> -     u32 *lr;
>> >> +     u32 *lr, nr_lr = vgic_nr_lr(vgic_cpu);
>> >
>> > This is static for any system post-boot, right?  Can't we set this
>> > global variable once like we did before instead of having to define
>> > these extra variables and do the bit manipulation all over the place?
>> >
>> > -Christoffer
>>
>> I tried to define a global gich_apr variable before. But Marc didn't agree on
>> that. He suggested to use vgic_cpu_nr_lr to save both GICH_APR offset
>> and nr_lr.
>>
>> Adding gich_apr variable should be the simpler implementation.
>>
> You're talking about storing this information on the vgic_cpu struct,
> which is accessed on every world-switch patch.  There, you don't want
> two memory accesses.
>
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 76af9302..b27e43f 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -419,7 +419,9 @@ vcpu        .req    r0              @ vcpu pointer
always in r0
        ldr     r7, [r2, #GICH_EISR1]
        ldr     r8, [r2, #GICH_ELRSR0]
        ldr     r9, [r2, #GICH_ELRSR1]
-       ldr     r10, [r2, #GICH_APR]
+       ldr     r10, =gich_apr
+       ldr     r10, [r10]
+       ldr     r10, [r2, r10]

        str     r3, [r11, #VGIC_CPU_HCR]
        str     r4, [r11, #VGIC_CPU_VMCR]
@@ -435,7 +437,11 @@ vcpu       .req    r0              @ vcpu pointer
always in r0
        str     r5, [r2, #GICH_HCR]

        /* Save list registers */
-       add     r2, r2, #GICH_LR0
+       ldr     r10, =gich_apr
+       ldr     r10, [r10]
+       /* the offset between GICH_APR & GICH_LR0 is 0x10 */
+       add     r10, r10, #0x10
+       add     r2, r2, r10
        add     r3, r11, #VGIC_CPU_LR
        ldr     r4, [r11, #VGIC_CPU_NR_LR]
 1:     ldr     r6, [r2], #4
@@ -469,10 +475,16 @@ vcpu      .req    r0              @ vcpu pointer
always in r0

        str     r3, [r2, #GICH_HCR]
        str     r4, [r2, #GICH_VMCR]
-       str     r8, [r2, #GICH_APR]
+       ldr     r6, =gich_apr
+       ldr     r6, [r6]
+       str     r8, [r2, r6]

        /* Restore list registers */
-       add     r2, r2, #GICH_LR0
+       ldr     r6, =gich_apr
+       ldr     r6, [r6]
+       /* the offset between GICH_APR & GICH_LR0 is 0x10 */
+       add     r6, r6, #0x10
+       add     r2, r2, r6
        add     r3, r11, #VGIC_CPU_LR
        ldr     r4, [r11, #VGIC_CPU_NR_LR]
 1:     ldr     r6, [r3], #4
@@ -618,3 +630,7 @@ vcpu        .req    r0              @ vcpu pointer
always in r0
 .macro load_vcpu
        mrc     p15, 4, vcpu, c13, c0, 2        @ HTPIDR
 .endm
+
+       .global gich_apr
+gich_apr:
+       .long   GICH_APR

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 47b2983..6bf31db 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1470,17 +1470,30 @@ static struct notifier_block vgic_cpu_nb = {
        .notifier_call = vgic_cpu_notify,
 };

+static const struct of_device_id of_vgic_ids[] = {
+       {
+               .compatible = "arm,cortex-a15-gic",
+               .data = (void *)GICH_APR,
+       }, {
+               .compatible = "hisilicon,hip04-gic",
+               .data = (void *)HIP04_GICH_APR,
+       }, {
+       },
+};
+
 int kvm_vgic_hyp_init(void)
 {
        int ret;
        struct resource vctrl_res;
        struct resource vcpu_res;
+       const struct of_device_id *match;

-       vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
+       vgic_node = of_find_matching_node_and_match(NULL, of_vgic_ids, &match);
        if (!vgic_node) {
                kvm_err("error: no compatible vgic node in DT\n");
                return -ENODEV;
        }
+       gich_apr = (unsigned int)match->data;

        vgic_maint_irq = irq_of_parse_and_map(vgic_node, 0);
        if (!vgic_maint_irq) {

It's the implementation of gich_apr in arm32.

We needn't add or change anything in struct vgic_cpu. And both the
assembly code and the code could be much easier.

> Here, on the other hand, you're in host kernel land, and you can do your
> bit-shuffling once, and always access a single static variable like we
> did before, which will simplify the C-code.
>

No bit-shuffling in gich_apr implementation. Is it right?

Regards
Haojian
