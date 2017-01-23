From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 Jan 2017 14:42:05 +0100
Subject: [PATCH v10 7/8] arm/arm64: vgic: Implement
 KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO ioctl
In-Reply-To: <CAFEAcA9Odatt_JUshMXnBiq0DyO7LEN=yCWnjwHPyO8uj2tJNw@mail.gmail.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <1480576187-5012-8-git-send-email-vijay.kilari@gmail.com>
 <20170120195338.GH13531@cbox>
 <CAFEAcA8bZUPC2YTBYTVY3oB4MJFJcKOgT77PN3vkp5gPjVRPgA@mail.gmail.com>
 <20170123110639.GA15850@cbox>
 <CAFEAcA9Odatt_JUshMXnBiq0DyO7LEN=yCWnjwHPyO8uj2tJNw@mail.gmail.com>
Message-ID: <20170123134205.GE15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 11:41:41AM +0000, Peter Maydell wrote:
> On 23 January 2017 at 11:06, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > ok, I think you're right that it can be done this way, but it has the
> > unfortunate consequence of having to change a lot of the implementation.
> >
> > The reason is that we store the latch state in two different variables,
> > depening on whether it's an edge- or level-triggered interrupts.
> >
> > We use the irq->pending field for the computed result (using above
> > calculaiton) for level interrupts based on irq->line_level and
> > irq->soft_pending.  soft_pending is the latch state for level interrupts
> > only.
> >
> > For edge triggered interrupts the computed result and the latch state
> > are alway the same (right?) so we we only use the irq->pending field for
> > that.
> >
> > But unless I didn't have enough coffee this morning, this only works if
> > you have a-priori knowledge of which interrupts are level and which are
> > edge.  When this is not the case, as in the case of order-free
> > save/restore, then I think the only solution is to rework the logic so
> > that the soft_pending field is used for the latch state for both edge
> > and level interrupts, and the pending field is just the internal
> > computed value.
> 
> I *think* you could fudge it by saying "when the config changes
> from edge to level, copy the current irq->pending into irq->soft_pending".
> Then you can always read the latch state (it's soft_pending
> if level, otherwise pending), and writing it is "set both if
> level, just irq->pending if edge". That in turn gives you enough
> information I think to cope with restores of all of (config,
> level, pending-latch) in any order. It feels a bit fragile, though.

Right, thanks for working this out.  I agree it's fragile and I cannot
seem to easily convince myself it would be correct, so I sent out a
patch to get rid of the pending cached state which should simplify the
save/restore patches as well.

Assuming the other VGIC suspects don't object to that, I suggest we base
these patches on top of that one and see if we can convince ourselves
that it's correct then.

Thanks,
-Christoffer
