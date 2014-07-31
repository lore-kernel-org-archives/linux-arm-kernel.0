From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 31 Jul 2014 17:53:56 +0100
Subject: [PATCH] arm64: KVM: export current vcpu->pause state via pseudo
 regs
In-Reply-To: <20140731165006.GL11610@cbox>
References: <1404914112-7298-1-git-send-email-alex.bennee@linaro.org>
 <20140731143538.GI11610@cbox> <87mwbpimgz.fsf@linaro.org>
 <20140731163805.GK11610@cbox>
 <CAFEAcA91efUg3MVpLScNBkxZSEgDP0zNnmxxr055fAz5=vDCoA@mail.gmail.com>
 <20140731165006.GL11610@cbox>
Message-ID: <CAFEAcA-6dEBcOZYOP69G8z+6hxCTBdhV9Tv9vBA1C6kSc7UkJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2014 17:50, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Thu, Jul 31, 2014 at 05:45:28PM +0100, Peter Maydell wrote:
>> Consider the case where the reset state of the system is
>> "CPU 0 running, CPUs 1..N stopped", and we're doing an
>> incoming migration to a state where all CPUs are running.
>> In that case we'll be using this ioctl to clear the pause flag,
>> right? (We'll also obviously need to set the PC and other
>> register state correctly before resuming the guest.)
>>
> Doh, you're right, I somehow had it in my mind that when you send the
> thread a signal, the pause flag would be cleared, but that goes against
> the whole idea of a CPU being turned off for KVM.
>
> But wouldn't we then have to also wake up the thread when clearing the
> pause flag?  It feels strange that the ioctl can clear the pause flag,
> but keep the thread on a wake-queue, and then userspace has to send the
> thread a signal of some sort to wake it up?

I have no idea about the implementation, I just know what
the user-facing ABI ought to look like. In particular userspace
definitely shouldn't have to send the thread any kind of
signal, it should just use KVM_RUN as usual and that should
cause the vCPU to either remain powered-down or start
executing code, as appropriate for the state we've just set.

-- PMM
