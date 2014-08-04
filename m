From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 4 Aug 2014 17:13:38 +0200
Subject: [RFC] Saving/Restoring the internal state of an interrupt
In-Reply-To: <86r40w1giv.fsf@arm.com>
References: <539F3BDD.2090009@arm.com> <20140804115716.GA524@cbox>
 <87fvhch1x2.fsf@approximate.cambridge.arm.com>
 <20140804132648.GA2471@cbox> <86r40w1giv.fsf@arm.com>
Message-ID: <20140804151338.GA1774@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 03:22:16PM +0100, Marc Zyngier wrote:
> On Mon, Aug 04 2014 at 02:26:48 PM, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Mon, Aug 04, 2014 at 01:31:05PM +0100, Marc Zyngier wrote:
> >> On Mon, Aug 04 2014 at 12:57:16 pm BST, Christoffer Dall
> >> <christoffer.dall@linaro.org> wrote:
> >> > On Mon, Jun 16, 2014 at 07:47:57PM +0100, Marc Zyngier wrote:
> >> >> Thomas, all,
> >> >> 
> >> >> Since ARM has grown some virtualization extensions, there is a
> >> >> particular issue I've carefully avoided to address, and which is now
> >> >> biting me exactly where you think it does.
> >> >> 
> >> >> Let's expose the problem:
> >> >> - We have a per-CPU timer (the architected timer)
> >> >> - This timer is shared across virtual machines
> >> >> - We context-switch the state of the timer on entry/exit of the VM
> >> >> 
> >> >> The state of the timer itself is basically a control word and a
> >> >> comparator value. Not much. Ah yes, one tiny detail: the state of the
> >> >> interrupt controller (the GIC) is also part of the state.
> >> >> 
> >> >> This interrupt state is not the pending state, but the internal state
> >> >> (called the "active" state), indicating if the interrupt is in
> >> >> progress or not. If the interrupt is active (and configured as a level
> >> >> interrupt), then the interrupt can't fire again until the guest EOIs
> >> >> it (there is some special hardware dedicated to this).
> >> >
> >> > Can you clarify this part.  I was under the impression from reading the
> >> > GICv2 specs at least that an active interrupt can become active and
> >> > pending (and the pending part of that would cause the interrupt to fire
> >> > again).  Specifically, I'm thinking about transition A2 in Figure 3-1 in
> >> > the GICv2 spec (ARM IHI 0048B.b).  Am I reading this incorrectly or is
> >> > there something special about the timer in this regard?
> >> 
> >> Nothing special about the timer. Just that the timer being a level
> >> interrupt, the pending state is a direct consequence of the level being
> >> high (as mentionned in the note at the bottom of 1.4.2).
> >> 
> >> You go from Pending to Active-and-Pending, and then to Active (when the
> >> timer is reprogrammed/disabled, though you may go back to A&P if the timer
> >> fires again immediately). Eventually, after the EOI, you go back to
> >> Inactive.
> >> 
> >> Here, the only bit we really care about is the Active bit (Pending
> >> changes anyway, as we save/restore the timer context).
> >> 
> >> Or is there something that I don't understand in your question?
> >> 
> >
> > If not using priorities, what difference does it make if we save/restore
> > the active bit?  The whole point is that a timer that the guest hasn't
> > reprogrammed/disabled should not raise a hardware interrupt, right?
> 
> It makes a massive difference: the interrupt is active on the host, and
> it is what will prevent subsequent (and possibly spurious) timer
> interrupts from being taken.
> 
> > So what I inferred from your text is that we prevent that from happening
> > by restoring the active bit.  But that will still cause the hardware to
> > assert the signal (we will become A&P) and that would raise the
> > interrupt on the hardware, we would trap again, and so on.  Or?
> 
> If the interrupt is already active when you restore the timer state, no
> other timer interrupt will be injected. That's the whole point of the
> active bit.
> 
> It feels like we're talking past each other, or that we're not exatly
> talking about the same thing. If that's of any help, can you have a look
> at the irq_forwarding patches I've posted a while ago?
> 
We're not talking past each other, I've simply 'misread' the spec.  I
find it extremely confusing, because Section 3.2.4 talks specifically
about the CPU interface state machine, and Figure 3-1 correspondingly
talks about an interrupt being pending even though it's already active
(A&P), but that sort of more a distributor or input-side state for the
CPU interface.

Anyway, the pseudo code clears it up, and clarifies that it is only
actually pending if it is not active.  This insight let's me make sense
out of your e-mail, and urges me to go check the QEMU emulation soon.

-Christoffer
