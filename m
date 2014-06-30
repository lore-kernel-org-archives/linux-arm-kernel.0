From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 30 Jun 2014 14:20:53 -0700
Subject: [RFC PATCH 2/6] arm/arm64: KVM: Rename irq_active to irq_queued
In-Reply-To: <40b2b2cd240d39950a3aa98c53c36fad@www.loen.fr>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
 <1402779067-34478-3-git-send-email-christoffer.dall@linaro.org>
 <40b2b2cd240d39950a3aa98c53c36fad@www.loen.fr>
Message-ID: <20140630212053.GA20104@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 22, 2014 at 12:25:02PM +0100, Marc Zyngier wrote:
> On 2014-06-14 21:51, Christoffer Dall wrote:
> >We have a special bitmap on the distributor struct to keep track
> >of when
> >level-triggered interrupts are queued on the list registers.  This
> >was
> >named irq_active, which is confusing, because the active state of an
> >interrupt as per the GIC spec is a different thing, not specifically
> >related to edge-triggered/level-triggered configurations but rather
> >indicates an interrupt which has been ack'ed but not yet eoi'ed.
> >
> >Rename the bitmap and the corresponding accessor functions to
> >irq_queued
> >to clarify what this is actually used for.
> 
> While I agree that irq_active is confusing, I would tend to object
> to irq_queued for similar reasons. Edge interrupts get queued as
> well.

yeah, but this is never checked for edge-triggered IRQs so I don't find
that part confusing.  I find the queued word suitable, because we set in
in the _queue function and unset it in the unqueue function.

> 
> What this bit does is to allow or forbid resampling of a level
> interrupt.
> 
> How about irq_resample instead? That would mandate a small refactor
> of the code (a bit set to one would allow resampling, which is the
> opposite of the current logic), but would look better, I believe.
> 
> What do you think?
> 
hmm, maybe.  Feel like illustrating what you mean exactly in form of a
patch?

-Christoffer
