From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Thu, 4 Apr 2013 08:27:50 -0700
Subject: [PATCH 2/5] ARM: KVM: arch_timers: zero CNTVOFF upon return to
 host
In-Reply-To: <20130404092939.GB3341@e106331-lin.cambridge.arm.com>
References: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
 <1364404312-4427-3-git-send-email-mark.rutland@arm.com>
 <CAEDV+gKmi16juPvQUO46eMVwtNMR+q4ce8ND_yVM4_O8iOYUXw@mail.gmail.com>
 <20130404092939.GB3341@e106331-lin.cambridge.arm.com>
Message-ID: <CAEDV+gJVq9N-ASm=m58q6umRhLo2aNn6iQNbecTXG9zejWiZCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 2:29 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Christoffer,
>
> On Thu, Apr 04, 2013 at 12:39:27AM +0100, Christoffer Dall wrote:
>> On Wed, Mar 27, 2013 at 10:11 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > To use the virtual counters from the host, we need to ensure that
>> > CNTVOFF doesn't change unexpectedly. When we change to a guest, we
>> > replace the host's CNTVOFF, but we don't restore it when returning to
>> > the host.
>> >
>> > As the host sets CNTVOFF to zero, and never changes it, we can simply
>> > zero CNTVOFF when returning to the host. This patch adds said zeroing to
>> > the return to host path.
>> >
>> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>> > Cc: Christoffer Dall <cdall@cs.columbia.edu>
>> > ---
>> >  arch/arm/kvm/interrupts_head.S | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
>> > index 3c8f2f0..d43cfb5 100644
>> > --- a/arch/arm/kvm/interrupts_head.S
>> > +++ b/arch/arm/kvm/interrupts_head.S
>> > @@ -497,6 +497,10 @@ vcpu       .req    r0              @ vcpu pointer always in r0
>> >         add     r5, vcpu, r4
>> >         strd    r2, r3, [r5]
>> >
>> > +       @ Ensure host CNTVCT == CNTPCT
>> > +       mov     r2, #0
>> > +       mcrr    p15, 4, r2, r2, c14     @ CNTVOFF
>> > +
>> >  1:
>> >  #endif
>> >         @ Allow physical timer/counter access for the host
>> > --
>> > 1.8.1.1
>> >
>> >
>>
>> looks good to me.
>>
>> Merged into kvm-arm-fixes.
>
> As this patch depends on the previous patch (which sets CNTVOFF to 0 in the hyp
> stub), and the rest of the patches depend on both this patch and the previous
> for correct operation, the series really needs to be taken together.
>

I don't see why this patch depends on the prior patches, I see it the
other way around.

> Would you be able to give your ack instead?

But sure, I definitely ack the patch.

>
> This patch is only required because the later patches in this series need it to
> allow the host to use virtual counters, nothing else requires the host's
> CNTVOFF to be 0 at the moment as both physical counters and timers are used by
> the host.
>
I understand, it doesn't hurt either though.

-Christoffer
