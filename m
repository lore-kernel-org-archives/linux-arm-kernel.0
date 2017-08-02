From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Aug 2017 15:31:23 +0100
Subject: [RFC PATCH v4 4/5] arm64: neon: Remove support for nested or
 hardirq kernel-mode NEON
In-Reply-To: <20170802130051.GG6321@e103592.cambridge.arm.com>
References: <1501249824-18913-1-git-send-email-Dave.Martin@arm.com>
 <1501249824-18913-5-git-send-email-Dave.Martin@arm.com>
 <20170802100224.tllivhe6u54xp3rd@armageddon.cambridge.arm.com>
 <20170802130051.GG6321@e103592.cambridge.arm.com>
Message-ID: <20170802143123.rqoc54xekpqb5hxz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 02:00:52PM +0100, Dave P Martin wrote:
> On Wed, Aug 02, 2017 at 11:02:25AM +0100, Catalin Marinas wrote:
> > On Fri, Jul 28, 2017 at 02:50:23PM +0100, Dave P Martin wrote:
> > > Support for kernel-mode NEON to be nested and/or used in hardirq
> > > context adds significant complexity, and the benefits may be
> > > marginal.  In practice, kernel-mode NEON is not used in hardirq
> > > context, and is rarely used in softirq context (by certain mac80211
> > > drivers).
> > 
> > Just for clarification, the issue we had with hardirq contexts was that
> > we could be interrupted while saving the current FPSIMD state as we
> > don't want to disable IRQs during this. If this was the only aspect,
> 
> Certainly this is an aspect: for SVE we definitely don't want IRQs
> disabled for the whole save/restore -- and I will be building SVE
> support on top of this.
> 
> > your patch looks fine. Note that softirqs may be executed as result of
> > an IRQ (via the irq_exit() function) but local_bh_disable() should
> > protect against such race.
> 
> This is my understanding: any such softirq would get deferred until
> local_bh_enable(), or would run in ksoftirqd.
> 
> There's an assumption here that EFI runtime services calls won't be made
> from softirq context, but I think that's reasonable: softirqs are far
> from general-purpose these days.
> 
> Was there any other concen here that you're aware of?

No. Just wanted to double-check my assumptions were right.

-- 
Catalin
