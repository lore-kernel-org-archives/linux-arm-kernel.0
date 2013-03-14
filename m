From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 14 Mar 2013 08:57:33 +0000
Subject: [kvmarm] [PATCH 14/29] arm64: KVM: guest one-reg interface
In-Reply-To: <5140E2C0.7010009@codeaurora.org>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-15-git-send-email-marc.zyngier@arm.com>
 <513F6659.7060500@codeaurora.org>
 <513F6E86.4040902@arm.com> <513FA70B.2040600@codeaurora.org>
 <51402F52.6020808@arm.com> <5140E2C0.7010009@codeaurora.org>
Message-ID: <CAFEAcA8DkB0tMN6V1fi=teujm0hWji-O9ZF8+iOswTOihEjFcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2013 20:34, Christopher Covington <cov@codeaurora.org> wrote:
> My guess at the goal of the code cited above in this email is that it's trying
> to sanity check that virtualization will work. Rather than taking a default
> deny approach with a hand-maintained white list of virtualization-supporting
> machine identifiers, why not check that EL2 is implemented on the current
> system and if it's not implied by that, that the timer and interrupt
> controller are suitable as well?

I think the question of "how much do we need to virtualize to allow
us to expose a different CPU to the guest than the host" is not yet
one that's been answered; so for the moment we support only
"guest == host == A57" [or == A15 on armv7]. When somebody has added
support for a second type of host/guest CPU then I think the process
of going through that work will make it much clearer how much
'new cpu' support is needed and what can be coded to work with any
virt-capable cpu. Until then I think it's safer to simply lock out
the unsupported combinations. That way anybody trying to run KVM on
a different CPU will be able to see that they have work to do and it's
not expected to work out of the box just yet.

We don't support other guests than A57 currently because you need to
implement emulation code for the imp-def registers for a guest CPU.
Again, I suspect the process of adding support for a 2nd guest CPU
will make it obvious what can be done generically and what really
does need to be per-CPU.

One thing I'm a bit worried about is the possibility that we accidentally
by-default allow the guest access to some new sysreg that didn't
exist on the A57 [or A15 for 32 bit] that turns out to be a security
hole (since both guest and host kernel run at EL1). But I think
trapping the whole of the impdef sysreg space should cover that.

-- PMM
