From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 10 May 2013 17:38:42 -0700
Subject: [PATCH v3 30/32] arm64: KVM: enable initialization of a 32bit vcpu
In-Reply-To: <51892DA4.4050401@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-31-git-send-email-marc.zyngier@arm.com>
 <20130423230229.GN20569@gmail.com> <5177E303.7050801@arm.com>
 <CAEDV+g+OL+37w9jA8=0WGea5FgW5y3mazqFzv9GLxDgjCe6dtg@mail.gmail.com>
 <51892DA4.4050401@arm.com>
Message-ID: <20130511003842.GE30999@chazy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 05:36:52PM +0100, Marc Zyngier wrote:
> On 24/04/13 18:17, Christoffer Dall wrote:
> > On Wed, Apr 24, 2013 at 6:49 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >> On 24/04/13 00:02, Christoffer Dall wrote:
> >>> On Mon, Apr 08, 2013 at 05:17:32PM +0100, Marc Zyngier wrote:
> >>>> Wire the init of a 32bit vcpu by allowing 32bit modes in pstate,
> >>>> and providing sensible defaults out of reset state.
> >>>>
> >>>> This feature is of course conditioned by the presence of 32bit
> >>>> capability on the physical CPU, and is checked by the KVM_CAP_ARM_EL1_32BIT
> >>>> capability.
> >>>>
> >>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>>> ---
> >>>>  arch/arm64/include/asm/kvm_host.h |  2 +-
> >>>>  arch/arm64/include/uapi/asm/kvm.h |  1 +
> >>>>  arch/arm64/kvm/guest.c            |  6 ++++++
> >>>>  arch/arm64/kvm/reset.c            | 25 ++++++++++++++++++++++++-
> >>>>  include/uapi/linux/kvm.h          |  1 +
> >>>>  5 files changed, 33 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> >>>> index d44064d..c3ec107 100644
> >>>> --- a/arch/arm64/include/asm/kvm_host.h
> >>>> +++ b/arch/arm64/include/asm/kvm_host.h
> >>>> @@ -34,7 +34,7 @@
> >>>>  #include <asm/kvm_vgic.h>
> >>>>  #include <asm/kvm_arch_timer.h>
> >>>>
> >>>> -#define KVM_VCPU_MAX_FEATURES 1
> >>>> +#define KVM_VCPU_MAX_FEATURES 2
> >>>>
> >>>>  /* We don't currently support large pages. */
> >>>>  #define KVM_HPAGE_GFN_SHIFT(x)      0
> >>>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> >>>> index 5b1110c..5031f42 100644
> >>>> --- a/arch/arm64/include/uapi/asm/kvm.h
> >>>> +++ b/arch/arm64/include/uapi/asm/kvm.h
> >>>> @@ -75,6 +75,7 @@ struct kvm_regs {
> >>>>  #define KVM_VGIC_V2_CPU_SIZE                0x2000
> >>>>
> >>>>  #define KVM_ARM_VCPU_POWER_OFF              0 /* CPU is started in OFF state */
> >>>> +#define KVM_ARM_VCPU_EL1_32BIT              1 /* CPU running a 32bit VM */
> >>>>
> >>>>  struct kvm_vcpu_init {
> >>>>      __u32 target;
> >>>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> >>>> index 47d3729..74ef7d5 100644
> >>>> --- a/arch/arm64/kvm/guest.c
> >>>> +++ b/arch/arm64/kvm/guest.c
> >>>> @@ -93,6 +93,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >>>>      if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
> >>>>              unsigned long mode = (*(unsigned long *)valp) & COMPAT_PSR_MODE_MASK;
> >>>>              switch (mode) {
> >>>> +            case COMPAT_PSR_MODE_USR:
> >>>> +            case COMPAT_PSR_MODE_FIQ:
> >>>> +            case COMPAT_PSR_MODE_IRQ:
> >>>> +            case COMPAT_PSR_MODE_SVC:
> >>>> +            case COMPAT_PSR_MODE_ABT:
> >>>> +            case COMPAT_PSR_MODE_UND:
> >>>>              case PSR_MODE_EL0t:
> >>>>              case PSR_MODE_EL1t:
> >>>>              case PSR_MODE_EL1h:
> >>>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> >>>> index bc33e76..a282d35 100644
> >>>> --- a/arch/arm64/kvm/reset.c
> >>>> +++ b/arch/arm64/kvm/reset.c
> >>>> @@ -35,11 +35,27 @@ static struct kvm_regs default_regs_reset = {
> >>>>      .regs.pstate = PSR_MODE_EL1h | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
> >>>>  };
> >>>>
> >>>> +static struct kvm_regs default_regs_reset32 = {
> >>>> +    .regs.pstate = (COMPAT_PSR_MODE_SVC | COMPAT_PSR_A_BIT |
> >>>> +                    COMPAT_PSR_I_BIT | COMPAT_PSR_F_BIT),
> >>>> +};
> >>>> +
> >>>> +static bool cpu_has_32bit_el1(void)
> >>>> +{
> >>>> +    u64 pfr0;
> >>>> +
> >>>> +    pfr0 = read_cpuid(ID_AA64PFR0_EL1);
> >>>> +    return !!(pfr0 & 0x20);
> >>>
> >>> again we don't need the double negation
> >>
> >> I still hold that it makes things more readable.
> >>
> >>>> +}
> >>>> +
> >>>>  int kvm_arch_dev_ioctl_check_extention(long ext)
> >>>>  {
> >>>>      int r;
> >>>>
> >>>>      switch (ext) {
> >>>> +    case KVM_CAP_ARM_EL1_32BIT:
> >>>> +            r = cpu_has_32bit_el1();
> >>>> +            break;
> >>>>      default:
> >>>>              r = 0;
> >>>>      }
> >>>> @@ -62,7 +78,14 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >>>>
> >>>>      switch (vcpu->arch.target) {
> >>>>      default:
> >>>> -            cpu_reset = &default_regs_reset;
> >>>> +            if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> >>>> +                    if (!cpu_has_32bit_el1())
> >>>> +                            return -EINVAL;
> >>>
> >>> I'm not sure EINVAL is appropriate here, the value specified was not
> >>> incorrect, it's that the hardware doesn't support it. ENXIO, ENODEV, and
> >>> add that in Documentation/virtual/kvm/api.txt ?
> >>
> >> Not sure. If you ended up here, it means you tried to start a 32bit
> >> guest on a 64bit-only CPU, despite KVM_CAP_ARM_EL1_32BIT telling you
> >> that your CPU is not 32bit capable.
> >>
> >> This is clearly an invalid input, isn't it?
> >>
> > check the API documentation for this ioctl, I don't think that's the
> > type of invalid input meant when describing the meaning of EINVAL. If
> > you feel strongly about it of course it's no big deal, but I think
> > EINVAL is so overloaded anyway that telling the user something more
> > specific would be great, but I'll leave it up to you.
> 
> [bit late on this one...]
> 
> Here's what the documentation says:
> <quote>
> 4.77 KVM_ARM_VCPU_INIT
> 
> Capability: basic
> Architectures: arm, arm64
> Type: vcpu ioctl
> Parameters: struct struct kvm_vcpu_init (in)
> Returns: 0 on success; -1 on error
> Errors:
>   EINVAL:    the target is unknown, or the combination of features is invalid.
>   ENOENT:    a features bit specified is unknown.
> </quote>
> 
> When this call fails, it is because you've requested a feature
> that is invalid for this CPU. To me, that exactly fits the
> EINVAL entry copied above.
> 
> Or am I completely misunderstanding it?
> 
I read the EINVAL to say that you supplied something which is invalid
for the software interface and you should fix your user space code.

The fact that you're requesting a feature that your hardware doesn't
support is a different thing IMHO.

-Christoffer
