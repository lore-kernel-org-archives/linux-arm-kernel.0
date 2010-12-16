From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 23:28:49 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
Message-ID: <20101216232849.GY9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 05:09:48PM -0600, Andrei Warkentin wrote:
> On Thu, Dec 16, 2010 at 5:34 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > On Wed, Dec 15, 2010 at 05:45:13PM -0600, Andrei Warkentin wrote:
> > > This is my first time on linux-arm-kernel, and while I've read the
> > > FAQ, hopefully I don't screw up too badly :).
> > >
> > > Anyway, we're on a dual-core ARMv7 running 2.6.36, and during
> > > stability stress testing saw the following:
> > > 1) After a number hotplug iterations, CPU1 fails to set its online bit
> > > quickly enough and __cpu_up() times-out.
> > > 2) CPU1 eventually completes its startup and sets the bit, however,
> > > since _cpu_up() failed, CPU1's active bit is never set.
> >
> > Why is your CPU taking soo long to come up? ?We wait one second in the
> > generic code, which is the time taken from the platform code being happy
> > that it has successfully started the CPU. ?Normally, platforms wait an
> > additional second to detect the CPU entering the kernel.
> 
> It seems twd_calibrate_rate is the culprit (although in our case,
> since the clock is the same to both CPUs, there is no point in
> calibrating).

twd_calibrate_rate() should only run once at boot.  Once it's run,
taking CPUs offline and back online should not cause the rate to be
recalibrated.

> See, the SMP logic is sensitive to system load at the moment.

I don't think it is - it sounds like you're explicitly causing the twd
rate to be recalculated every time you're bringing a CPU online, which
is not supposed to happen.

> Since boot_secondary is supposed to return failure on failing
> to up the secondary, maybe there is no point doing a timed wait for
> the online bit, since you are guaranteed to get there.

If you're starving the secondary CPU of soo much bus bandwidth that it's
taking more than one second for it to be marked online, the delay loop
calibration is going to fail too.  If you can starve it of bus bandwidth
from the primary CPU, then you have badly designed hardware too - you'll
gain very little benefit from a SMP system if you can't sensibly run both
CPUs at the same time without starving one or other.

What I'm saying is that if it's taking more than one second to setup
the local timer (which should be a few register writes) and calibrate
the delay loop, you're going to have bigger problems and your system is
already in an unstable situation.

Please post your SMP support code so it can be reviewed, which'll help
eliminate it from being the cause.
