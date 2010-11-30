From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 11:03:31 +0000
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm cpu
	hotplug
In-Reply-To: <AANLkTimZfnmVMDZ2faUPpDHHv3oAhM9ZcVEpM0_MyHbq@mail.gmail.com>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>
	<AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>
	<20101129104149.GA10703@n2100.arm.linux.org.uk>
	<AANLkTikHv+Rz7+bZY8Qo2drUQO4fjhJgqORcGFB7B6s7@mail.gmail.com>
	<20101129192407.GA20761@n2100.arm.linux.org.uk>
	<AANLkTimZfnmVMDZ2faUPpDHHv3oAhM9ZcVEpM0_MyHbq@mail.gmail.com>
Message-ID: <20101130110331.GA31054@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 04:17:32PM +0530, Amit Kucheria wrote:
> Since the main aim here is to consolidate as much code here as
> possible while still allowing platforms to override the defaults,
> would you have an objection to the introduction of a struct smp_ops
> that'll allow a platform to override the defaults? This seems to be
> done on other platforms I've briefly looked at.

I see no point to what is being proposed in this thread.  It's _soo_
little code that the platforms have to implement that it really is
not worth the effort.

How do you know whether separating out the cache flushes from the
wait-for-interrupt is an acceptable thing to do?  On the Realview
platforms, I suspect it's not acceptable.  That means your attempts
to move the cache flusing into a separate function from the wait-for-
interrupt will cause problems - as entering a function creates a
stack frame, and therefore writes to memory which can hit the cache.

Leave it as is.  The generic interface for platforms to implement is:

platform_do_lowpower() - does whatever's necessary to idle etc the CPU
platform_cpu_kill() - returns 1 if there's nothing to be done
platform_cpu_disable() - returns 0 if the CPU can be taken offline

Trying to get rid of platform_cpu_kill and platform_cpu_disable, and
then splitting platform_do_lowpower into three new smaller functions
is NOT an improvement.
