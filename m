From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 17 Dec 2009 19:04:53 +0000
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <20091217181718.GA4440@n2100.arm.linux.org.uk>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
	<20091217181718.GA4440@n2100.arm.linux.org.uk>
Message-ID: <20091217190453.GA362@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> Let me put it another way: I want this function to terminate with an
> explicit NULL pointer dereference in every case.

__builtin_trap cannot be used because the GCC manual says "The
mechanism used may vary from release to release so you should not rely
on any particular implementation".  It includes calling abort() as a
possible implementation - not ideal.

This is not related to GCC, but I have an ARM system here where
dereferencing NULL does not trap.  You guessed it, it doesn't have a
regular MMU.  But there are other addresses which do trap.  They would
be a much better choice for BUG().

(Aha!  Maybe that's why the kernel just behaves weirdly when it runs
out of memory and eventually triggers a watchdog reboot, with no panic
message.  I'd better try changing BUG() :-)

Even with an MMU, sometimes userspace maps page zero.  For example,
Wine on x86 does that.  (It might be possible to change Wine and
kernel vm86 to avoid it, but it has not happened).

Bug-free userspace behaviour should not stop kernel's BUG() from doing
it's basic job of trapping in the kernel!

It would be quite messy if userspace maps page zero, and then a kernel
BUG() ploughs ahead into __builtin_unreachable() and completely
undefined behaviour, possibly leading to worse behaviour than omitting
the check which called BUG().

Under those circumstances I'd rather see it use __builtin_trap() if
that really does trap :-)

The point of the exercise with __builtin_unreachable() is to reduce
the kernel size by removing the for(;;) loop.  *(int *)0 = 0 isn't the
smallest trapping sequence.  (When it works :-)

So the most compact _and_ reliable sequence for the kernel, on all
architectures, is probably:

    __asm__ volatile("smallest undefined or always-trapping instruction")

followed by __builtin_unreachable(), because GCC documentation _does_
say that asm followed by that will execute the asm and assume the asm
doesn't return.

-- Jamie
