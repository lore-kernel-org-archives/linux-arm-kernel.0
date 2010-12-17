From: murali@embeddedwireless.com (murali at embeddedwireless.com)
Date: Fri, 17 Dec 2010 00:11:52 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com><20101216113407.GO9937@n2100.arm.linux.org.uk><AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
Message-ID: <601836471-1292544654-cardhu_decombobulator_blackberry.rim.net-1859917571-@b4.c1.bise3.blackberry>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sent by Maxis from my BlackBerry? smartphone

-----Original Message-----
From: Andrei Warkentin <andreiw@motorola.com>
Sender: linux-arm-kernel-bounces at lists.infradead.org
Date: Thu, 16 Dec 2010 17:09:48 
To: Russell King - ARM Linux<linux@arm.linux.org.uk>
Cc: <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] Make SMP secondary CPU up more resilient to failure.

On Thu, Dec 16, 2010 at 5:34 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Wed, Dec 15, 2010 at 05:45:13PM -0600, Andrei Warkentin wrote:
> > This is my first time on linux-arm-kernel, and while I've read the
> > FAQ, hopefully I don't screw up too badly :).
> >
> > Anyway, we're on a dual-core ARMv7 running 2.6.36, and during
> > stability stress testing saw the following:
> > 1) After a number hotplug iterations, CPU1 fails to set its online bit
> > quickly enough and__cpu_up() times-out.
> > 2) CPU1 eventually completes its startup and sets the bit, however,
> > since_cpu_up() failed, CPU1's active bit is never set.
>
> Why is your CPU taking soo long to come up? ?We wait one second in the
> generic code, which is the time taken from the platform code being happy
> that it has successfully started the CPU. ?Normally, platforms wait an
> additional second to detect the CPU entering the kernel.

It seems twd_calibrate_rate is the culprit (although in our case,
since the clock is the same to both CPUs, there is no point in
calibrating).
We've seen this only when the device was under stress test load.

>
> > 2) Additionally I ensure that if the CPU comes up later than it were
> > supposed to (shouldn't, but...), then it will not start initializing
> > behind cpu_up's back (which is not really undoable). This solves the
> > problem with both cpu_up+secondary_start_kernel races and with
> > platform_cpu_kill+secondary_start_kernel races.
>
> Why would you have platform_cpu_kill() running at the same time - firstly,
> hotplug events are serialized, and secondly the platform_cpu_kill() path
> should wait up to five seconds for the CPU to go offline. ?If it doesn't
> go offline within five seconds it's dead (and maybe we should mark it
> not present.)
>

That's the platform_cpu_kill I invoke when I time out waiting for the
online bit. Sorry, wasn't being clear. Just trying
to show I didn't introduce any races :).

See, the SMP logic is sensitive to system load at the moment. Since
boot_secondary is supposed to return failure on failing
to up the secondary, maybe there is no point doing a timed wait for
the online bit, since you are guaranteed to get there.
But right now, you end up in a situation where there is a timeout, but
the CPU is up and running and registered.
And this causes bad behavior later when you try to down it.

>_______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
