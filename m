From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 30 Nov 2014 11:10:56 +0100
Subject: [PATCH 5/7] KVM: arm64: guest debug, add support for single-step
In-Reply-To: <CAFEAcA-cjM9yUXi6tc79UP0fBKAagtFKQgV3iAjz5DWr9yxZUQ@mail.gmail.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-6-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA-cjM9yUXi6tc79UP0fBKAagtFKQgV3iAjz5DWr9yxZUQ@mail.gmail.com>
Message-ID: <20141130101056.GB484@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 07:27:06PM +0000, Peter Maydell wrote:
> On 25 November 2014 at 16:10, Alex Benn?e <alex.bennee@linaro.org> wrote:
> > This adds support for single-stepping the guest. As userspace can and
> > will manipulate guest registers before restarting any tweaking of the
> > registers has to occur just before control is passed back to the guest.
> > Furthermore while guest debugging is in effect we need to squash the
> > ability of the guest to single-step itself as we have no easy way of
> > re-entering the guest after the exception has been delivered to the
> > hypervisor.
> 
> A corner case I don't think this patch handles: if the debugger
> tries to single step an insn which is emulated by the
> hypervisor (because it's a load/store which is trapped and
> handled as emulated mmio in userspace) then we won't
> correctly update the single-step state machine (and so we'll end
> up incorrectly stopping after the following insn rather than
> before, I think).
> 
> You should be able to achieve this effect by simply always clearing
> the guest's PSTATE.SS when you advance the PC to skip the emulated
> instruction (cf the comment in the pseudocode SSAdvance() function).
> 
> I think we should also be doing this PC advance on return from
> userspace's handling of the mmio rather than before we drop back
> to userspace as we do now, but I can't remember why I think that.
> Christoffer, I don't suppose you recall, do you? I think it was
> you I had this conversation with on IRC a month or so back...
> 
I don't remember clearly, no.  Was it not during lunch at LCU we had
this conversation?

In any case, I think it was related to how userspace observes the state
of the CPU, because when you do the MMIO operation emulation in
userspace, currently if you observe the PC though GET_ONE_REG, you'll
see a PC pointing to the next instruction, not the one you're emulating
which is strange.

Not sure what the relation to a guest single-stepping itself was.

-Christoffer
