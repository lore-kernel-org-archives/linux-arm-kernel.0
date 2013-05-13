From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Sun, 12 May 2013 22:53:54 -0700
Subject: [PATCH] ARM: KVM: prevent NULL pointer dereference with KVM ioctl
In-Reply-To: <20130513051352.GA64337@ubuntu>
References: <1367931313-14839-1-git-send-email-andre.przywara@linaro.org>
 <518A2098.9010909@arm.com> <20130513051352.GA64337@ubuntu>
Message-ID: <CAEDV+g+difK63VWM5Q0yWfJ2Jtn2AUAUB2L6-z0RU1KQ1Y4HkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 12, 2013 at 10:13 PM, Christoffer Dall
<cdall@cs.columbia.edu> wrote:
> On Wed, May 08, 2013 at 10:53:28AM +0100, Marc Zyngier wrote:
>> On 07/05/13 13:55, Andre Przywara wrote:
>> > Some ARM KVM VCPU ioctls require the vCPU to be properly initialized
>> > with the KVM_ARM_VCPU_INIT ioctl before being used with further
>> > requests. KVM_RUN checks whether this initialization has been
>> > done, but other ioctls do not.
>> > Namely KVM_GET_REG_LIST will dereference an array with index -1
>> > without initialization and thus leads to a kernel oops.
>> > Fix this by adding checks before executing the ioctl handlers.
>> >
>> > Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>> > ---
>> >  arch/arm/kvm/arm.c | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> > index c1fe498..0c571ff 100644
>> > --- a/arch/arm/kvm/arm.c
>> > +++ b/arch/arm/kvm/arm.c
>> > @@ -893,6 +893,11 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>> >     case KVM_SET_ONE_REG:
>> >     case KVM_GET_ONE_REG: {
>> >             struct kvm_one_reg reg;
>> > +
>> > +           /* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
>> > +           if (unlikely(vcpu->arch.target < 0))
>> > +                   return -ENOEXEC;
>> > +
>> >             if (copy_from_user(&reg, argp, sizeof(reg)))
>> >                     return -EFAULT;
>> >             if (ioctl == KVM_SET_ONE_REG)
>> > @@ -905,6 +910,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>> >             struct kvm_reg_list reg_list;
>> >             unsigned n;
>> >
>> > +           /* Make sure they initialize the vcpu with KVM_ARM_VCPU_INIT */
>> > +           if (unlikely(vcpu->arch.target < 0))
>> > +                   return -ENOEXEC;
>> > +
>> >             if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
>> >                     return -EFAULT;
>> >             n = reg_list.n;
>> >
>>
>> So we also have the same snippet in kvm_arch_vcpu_ioctl_run().
>>
>> Can you create a static function (kvm_vcpu_initialized?) containing that
>> code and make all three sites use it?
>>
> Andre, will you re-spin your patch as per Marc's comments?
>
oh, never mind, missed it when I looked over the mails.

-Christoffer
