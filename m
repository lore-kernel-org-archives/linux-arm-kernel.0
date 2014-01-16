From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jan 2014 12:16:49 +0000
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <52D76BC8.6080405@nvidia.com>
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>
 <20140115154526.GC3571@mudshark.cambridge.arm.com>
 <52D76BC8.6080405@nvidia.com>
Message-ID: <20140116121649.GG30257@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 05:19:04AM +0000, Prashant Gaikwad wrote:
> On Wednesday 15 January 2014 09:15 PM, Will Deacon wrote:
> > On Wed, Jan 15, 2014 at 01:07:07PM +0000, Prashant Gaikwad wrote:
> >> Now arch timer is registerd using generic sched timer, delay
> >> timer registration is the only part remaining in arch ports.
> >> Move this part to drivers clocksource and remove arch timer
> >> from arch ports.
> > What's the advantage in doing this? I'd have thought consolidation, but...
> 
> Primary objective of doing this to use other timers on SoC instead of 
> arch timers. It is observed that on ARM implementations of ARMv8 
> architecture context of per CPU logic of arch timer is not preserved 
> when CPU is powered down and reset is held during powerdown.
> 
> This makes arch timers unusable as wake events for some CPU idle states 
> where CPU core is powered down.
> 
> So we have two options:
> 1. Use system timers as broadcast timers and save/restore arch timers 
> context actross these CPU idle states.
> 2. Disable arch timer and use system timers.

Why can't you use the C3STOP feature so that the arch-timer isn't used when
you go idle?

There are several good reasons to use the architected timers when you can:

  - KVM requires them, as they have hardware support for virtualisation
  - The VDSO can make use of them to implement efficient gtod in userspace
  - They are per-cpu, so no need to broadcasting in software
  - They can generate events and allow userspace to implement efficient
    polling loops

> > What happens if I call udelay on arm64 before the counter has registered?
> 
> I will fix this in next patch. Do you have plan to add busy-loop for 
> arm64? Or I will have to initialize read counter function early.

Well, I assume the virtual counter (cntvct) still ticks on your system? If
so, I would suggest having that as the default delay implementation and
allowing it to be over-ridden later on.

The part I don't understand is why being `unusable as wake events' affects
the delay loop. All we need for that is the counter, the timers are irrelevant.

Will
