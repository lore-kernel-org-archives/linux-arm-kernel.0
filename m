From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 16:58:19 +0000
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm cpu
	hotplug
In-Reply-To: <4CF5252B.5050109@gmail.com>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>
	<AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>
	<20101129104149.GA10703@n2100.arm.linux.org.uk>
	<AANLkTikHv+Rz7+bZY8Qo2drUQO4fjhJgqORcGFB7B6s7@mail.gmail.com>
	<20101129192407.GA20761@n2100.arm.linux.org.uk>
	<AANLkTimZfnmVMDZ2faUPpDHHv3oAhM9ZcVEpM0_MyHbq@mail.gmail.com>
	<20101130110331.GA31054@n2100.arm.linux.org.uk>
	<4CF5252B.5050109@gmail.com>
Message-ID: <20101130165819.GC2377@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 10:24:11AM -0600, Rob Herring wrote:
> On 11/30/2010 05:03 AM, Russell King - ARM Linux wrote:
>> On Tue, Nov 30, 2010 at 04:17:32PM +0530, Amit Kucheria wrote:
>>> Since the main aim here is to consolidate as much code here as
>>> possible while still allowing platforms to override the defaults,
>>> would you have an objection to the introduction of a struct smp_ops
>>> that'll allow a platform to override the defaults? This seems to be
>>> done on other platforms I've briefly looked at.
>>
>> I see no point to what is being proposed in this thread.  It's _soo_
>> little code that the platforms have to implement that it really is
>> not worth the effort.
>>
> Whether the code can be consolidated or not, the current API does not  
> allow a single kernel binary (ignoring the list of other issues). The  
> introduction of struct smp_ops would help enable both single kernel and  
> default versions of the functions.

True.  However, the "single kernel binary" is a long way off, with a
fair number of fundamental issues.  Currently, the toolchain people seem
to be going in a completely different direction, adding blocks to being
able to build a single binary for several different CPUs.  See the recent
thread on the SWP emulation build failure.

However, that's a different issue to the subject of these patches, which
is to add another _optional_ layer of APIs between the generic ARM SMP
code, and the platform code.

We currently have one API, which is:
- platform_cpu_kill, platform_cpu_die, platform_cpu_disable

What is being proposed in these patches so far is that we introduce
another optional layer which introduces a new set of APIs:
- platform_enter_lowpower, platform_do_lowpower, platform_leave_lowpower
to support the noddy 'spin in a low power loop waiting for wakeup' method.

In order to support platforms which don't want to use the noddy method,
instead of having just three interfaces to deal with being different
between platforms, we instead have _six_ interfaces.

This is not the way to go.  We really don't need to increase the
complexity by adding a 'consolidation' layer on top of what we already
have.

In terms of allowing platform independence, just wrapping these three
(platform_cpu_kill, platform_cpu_die, platform_cpu_disable) into some
smp_ops structure may seem a nice idea, but there's more SMP platform
specifics than just that.  Eg, there's the cross-call support (which must
be initialized with the IRQ controller.)

I don't think wrapping them into something which purports to be a generic
smp_ops structure, and then having to play games with ifdefs because
they're spread across several files with different compilation options
is a sane way forward.

I still come back to my original point though.  Let's first get the
existing support fixed so that we know what we are dealing with, so we
can first see whether the existing APIs are right for everyone, rather
than just blindly believing that they are because most people have
mindlessly cut'n'pasted the Realview code.
