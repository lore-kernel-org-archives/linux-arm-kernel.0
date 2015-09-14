From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 14 Sep 2015 13:11:38 +0200
Subject: [PATCH v3 07/10] KVM: arm/arm64: vgic: Allow HW interrupts for
 non-shared devices
In-Reply-To: <55EFF0BC.8090200@linaro.org>
References: <1439212864-12954-1-git-send-email-eric.auger@linaro.org>
 <1439212864-12954-8-git-send-email-eric.auger@linaro.org>
 <20150902194246.GV10991@cbox> <55EFF0BC.8090200@linaro.org>
Message-ID: <20150914111138.GF15712@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, Sep 09, 2015 at 10:41:32AM +0200, Eric Auger wrote:

[...]

> I tried to integrate into the updated state machine for non shared
> mapped IRQ but I fail.

What exactly do you mean when you refer to 'updated state machine' ?

> 
> 1) The first problem encountered is how to reset the level of the IRQ
> (since its completion is not trapped). I added this reset in
> process_queued_irq. I think this was the most natural place since at
> sink time we get aware the IRQ is deactivated at physical distributor
> level. However I observe  failures in vgic_validate_injection. I think
> there is due to a race between update_irq_pending and sync. As soon as
> the guest EOI's the virtual IRQ (and also the pIRQ), a new physical IRQ
> hits and gets injected by irqfd. This injection can happen before the
> sync. So I would be tempted to keep my current strategy of ignoring the
> validate_injection in case of non-shared mapped IRQ and not model the
> level state. The vIRQ directly comes from the HW so it must be valid
> (guest deactivated the previous occurence).

I'm a bit confused about what we are talking about here?

Are you asking about how we should deal with forwarded, level-triggered,
non-shared interrupts?

If that's the case, here are my high-level thoughts:
 - We should not maintain a virtual line state, because this is
   maintained in hardware
 - Ideally we sample the physical distributor pending state at the
   important points (sync/flush).
 - Sampling the physical state may be slow/difficult, so we may
   choose an optimization, for example cache the pending state when the
   host ISR runs and clear the pending state when the interrupt is
   injected and not care about spurious interrupts if the signal is
   lowered after it's raised.

> 
> 2) can_sample.
> once the above problem fixed, next issue is the can_sample failure.
> Queued state also is reset in process_queued_irq and can_sample fails.
> Same punishment. So currently the only manner I found to make this work
> and sample the IRQ only once is to use the pending state which I reset
> when I queue the IRQ.

So queued means that we don't sample the virtual line state, yes?  If
so, then it would make sense to always set the state as queued for
injected forwarded non-shared level-triggered interrupts.

Does this help?

-Christoffer
