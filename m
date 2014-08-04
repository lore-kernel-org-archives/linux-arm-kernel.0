From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 4 Aug 2014 14:11:31 +0200
Subject: [PATCH] arm64: KVM: export current vcpu->pause state via pseudo
 regs
In-Reply-To: <87egx0ilkg.fsf@linaro.org>
References: <1404914112-7298-1-git-send-email-alex.bennee@linaro.org>
 <20140731143538.GI11610@cbox> <87mwbpimgz.fsf@linaro.org>
 <20140731163805.GK11610@cbox>
 <CAFEAcA91efUg3MVpLScNBkxZSEgDP0zNnmxxr055fAz5=vDCoA@mail.gmail.com>
 <20140731165006.GL11610@cbox> <87egx0ilkg.fsf@linaro.org>
Message-ID: <20140804121131.GC524@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 10:48:36AM +0100, Alex Benn?e wrote:
> 
> Christoffer Dall writes:
> 
> > On Thu, Jul 31, 2014 at 05:45:28PM +0100, Peter Maydell wrote:
> >> On 31 July 2014 17:38, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> >> >> > If we are not complaining when setting the pause value to false if it
> >> >> > was true before, then we probably also need to wake up the thread in
> >> >> > case this is called from another thread, right?
> >> >> >
> >> >> > or perhaps we should just return an error if you're trying to un-pause a
> >> >> > CPU through this interface, hmmmm.
> >> >>
> >> >> Wouldn't it be an error to mess with any register when the system is not
> >> >> in a quiescent state? I was assuming that the wake state is dealt with
> >> >> when the run loop finally restarts.
> >> >>
> >> >
> >> > The ABI doesn't really define it as an error (the ABI doesn't enforce
> >> > anything right now) so the question is, does it ever make sense to clear
> >> > the pause flag through this ioctl?  If not, I think we should just err
> >> > on the side of caution and specify in the docs that this is not
> >> > supported and return an error.
> >> 
> >> Consider the case where the reset state of the system is
> >> "CPU 0 running, CPUs 1..N stopped", and we're doing an
> >> incoming migration to a state where all CPUs are running.
> >> In that case we'll be using this ioctl to clear the pause flag,
> >> right? (We'll also obviously need to set the PC and other
> >> register state correctly before resuming the guest.)
> >> 
> > Doh, you're right, I somehow had it in my mind that when you send the
> > thread a signal, the pause flag would be cleared, but that goes against
> > the whole idea of a CPU being turned off for KVM.
> >
> > But wouldn't we then have to also wake up the thread when clearing the
> > pause flag?  It feels strange that the ioctl can clear the pause flag,
> > but keep the thread on a wake-queue, and then userspace has to send the
> > thread a signal of some sort to wake it up?
> <snip>
> 
> Isn't the vCPU off the wait-queue by definition if the ioctl exits and
> you go through the KVM_SET_ONE_REG stuff?
> 
> Once you re-enter the KVM_RUN ioctl it sees the pause_flag as cleared
> and falls straight through into kvm_guest_enter() otherwise it will
> again wait on wait_event_interruptible(*wq, !vcpu->arch.pause).
> 
Yeah, you're right, I forgot we grab the vcpu->mutex.

-Christoffer
