From: jintack@cs.columbia.edu (Jintack Lim)
Date: Wed, 1 Feb 2017 03:40:10 -0500
Subject: [RFC v2 06/10] KVM: arm/arm64: Update the physical timer
 interrupt level
In-Reply-To: <20170201080440.GB6226@cbox>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
 <1485479100-4966-7-git-send-email-jintack@cs.columbia.edu>
 <86sho199jx.fsf@arm.com> <20170201080440.GB6226@cbox>
Message-ID: <CAHyh4xjTWK0HeQhX9X6+6Ez706Sh4+=3wMq0b9rmvGTbD8q80g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 3:04 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Sun, Jan 29, 2017 at 03:21:06PM +0000, Marc Zyngier wrote:
>> On Fri, Jan 27 2017 at 01:04:56 AM, Jintack Lim <jintack@cs.columbia.edu> wrote:
>> > Now that we maintain the EL1 physical timer register states of VMs,
>> > update the physical timer interrupt level along with the virtual one.
>> >
>> > Note that the emulated EL1 physical timer is not mapped to any hardware
>> > timer, so we call a proper vgic function.
>> >
>> > Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
>> > ---
>> >  virt/kvm/arm/arch_timer.c | 20 ++++++++++++++++++++
>> >  1 file changed, 20 insertions(+)
>> >
>> > diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
>> > index 0f6e935..3b6bd50 100644
>> > --- a/virt/kvm/arm/arch_timer.c
>> > +++ b/virt/kvm/arm/arch_timer.c
>> > @@ -180,6 +180,21 @@ static void kvm_timer_update_mapped_irq(struct kvm_vcpu *vcpu, bool new_level,
>> >     WARN_ON(ret);
>> >  }
>> >
>> > +static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
>> > +                            struct arch_timer_context *timer)
>> > +{
>> > +   int ret;
>> > +
>> > +   BUG_ON(!vgic_initialized(vcpu->kvm));
>>
>> Although I've added my fair share of BUG_ON() in the code base, I've
>> since reconsidered my position. If we get in a situation where the vgic
>> is not initialized, maybe it would be better to just WARN_ON and return
>> early rather than killing the whole box. Thoughts?
>>
>
> Could we help this series along by saying that since this BUG_ON already
> exists in the kvm_timer_update_mapped_irq function, then it just
> preserves functionality and it's up to someone else (me) to remove the
> BUG_ON from both functions later in life?
>

Sounds good to me :) Thanks!

> Thanks,
> -Christoffer
>
