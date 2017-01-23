From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 Jan 2017 12:06:39 +0100
Subject: [PATCH v10 7/8] arm/arm64: vgic: Implement
 KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO ioctl
In-Reply-To: <CAFEAcA8bZUPC2YTBYTVY3oB4MJFJcKOgT77PN3vkp5gPjVRPgA@mail.gmail.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <1480576187-5012-8-git-send-email-vijay.kilari@gmail.com>
 <20170120195338.GH13531@cbox>
 <CAFEAcA8bZUPC2YTBYTVY3oB4MJFJcKOgT77PN3vkp5gPjVRPgA@mail.gmail.com>
Message-ID: <20170123110639.GA15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 10:16:04AM +0000, Peter Maydell wrote:
> On 20 January 2017 at 19:53, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > So last time we had a discussion about whether or not the API should
> > support any random order of restoring the registers, but I cannot see
> > how we can support that, because how can we tell the difference between
> > the following two scenarios without knowing if an interrupt is
> > edge-triggered or level triggered:
> >
> >   (1) Clearing the line_level for an edge-triggered interrupt after
> >       having set it to pending, which means it should stay pending.
> 
> This is userspace doing:
>  * set pending-latch to 1
>  * set linelevel to 0
> 
> right? The pending state is pending-latch | (linelevel & ~edge_trigger),
> and you can recalculate that when userspace updates either of the
> pending-latch state or linelevel. (It will be temporarily wrong
> before userspace has told the kernel about all the state, but
> that's fine because we won't try to run the VM until we've finished
> loading everything.)
> 
> >   (2) Clearing the line_level for a level-triggered interrupt when the
> >       state is already pending for some reason, but the soft_pending
> >       (latch) state is not set, in which case the pending state should
> >       be removed.
> 
> This is userspace doing
>  * set pending-latch to 0
>  * set line_level to 0
> 
> and thus the pending state goes to 0 (same calculation as above).
> 
> pending is always a pure logical function of pending-latch,
> linelevel and edge-trigger bits, so as long as you recalculate
> it at the right time then it shouldn't matter which order userspace
> tells you about the three things in.
> 

ok, I think you're right that it can be done this way, but it has the
unfortunate consequence of having to change a lot of the implementation.

The reason is that we store the latch state in two different variables,
depening on whether it's an edge- or level-triggered interrupts.

We use the irq->pending field for the computed result (using above
calculaiton) for level interrupts based on irq->line_level and
irq->soft_pending.  soft_pending is the latch state for level interrupts
only.

For edge triggered interrupts the computed result and the latch state
are alway the same (right?) so we we only use the irq->pending field for
that.

But unless I didn't have enough coffee this morning, this only works if
you have a-priori knowledge of which interrupts are level and which are
edge.  When this is not the case, as in the case of order-free
save/restore, then I think the only solution is to rework the logic so
that the soft_pending field is used for the latch state for both edge
and level interrupts, and the pending field is just the internal
computed value.

Thoughts?

Andre, Marc, Eric, do you agree with the above?

(I wonder how we could go through an entire redesign of the vgic and
still have issues like this, but I do remember we all felt tired when we
finally got to design the soft_pending stuff.)

Thanks,
-Christoffer
