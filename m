From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Sep 2013 17:39:31 +0100
Subject: [PATCH 3/4] Add physical count arch timer support for clocksource
 in ARMv7.
In-Reply-To: <CAK3cCBwu4somtfc9J1ZDVcC-iYD1qDJwSWzWeOomTqY9tQA2kg@mail.gmail.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
 <CAK3cCBwu4somtfc9J1ZDVcC-iYD1qDJwSWzWeOomTqY9tQA2kg@mail.gmail.com>
Message-ID: <5231EE43.5090900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/13 17:07, cinifr wrote:
>> This cannot be a compile-time option as above in a multiplatform build.
>> Other paltforms (e.g. KVM guests) *must* use the virtual counters to get
>> any semblance of a consistent view of time.
> Yes I accept compile-time option is not perfect  in my pre email,
> But,Why Ohter paltforms *must* use the virtual counters? I think KVM
> should not limit how to use arch timer in its guest OS. Of cause, if
> KVM guest use vct can be more efficiency then that use pct. but KVM
> should and must support guest OS to access pct.

The virtual counter is there for a good reason: it allows a virtual
machine to:
- see its time starting at zero
- be migrated to another host without seeing time shifting one way or
another.

So using the physical counter in a VM is a recipe for disaster if you're
doing any kind of time tracking. The counter being used for
sched_clock(), we cannot afford to see it being shifted one way or another.

If you have issues with the use of the virtual counter, I suggest you
fix your firmware to have a consistent CNTVOFF across CPUs. And/or even
better, boot your kernel in HYP mode, as it will take care of setting
CNTVOFF to zero.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
