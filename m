From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Aug 2010 17:43:18 +0200
Subject: thumb2 user binaries with v6/v7 combined kernel
In-Reply-To: <20100805150608.GE23473@n2100.arm.linux.org.uk>
References: <201008051642.04950.arnd@arndb.de>
	<20100805150608.GE23473@n2100.arm.linux.org.uk>
Message-ID: <201008051743.19002.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 August 2010, Russell King - ARM Linux wrote:
> On Thu, Aug 05, 2010 at 04:42:04PM +0200, Arnd Bergmann wrote:
> > I've been trying to run a multi-CPU kernel for armv6 and armv7
> > and noticed that thumb2 binaries sometimes crash with SIGILL.
> > 
> > The only problem appears to be that when __LINUX_ARM_ARCH__
> > is set to 6, the kernel does not correctly decode some instructions.
> 
> Well, I've been thinking that we should create two new macros to
> replace __LINUX_ARM_ARCH__:
> 
> __LINUX_MIN_ARM_ARCH__
> __LINUX_MAX_ARM_ARCH__
> 
> which will be the range of architecture versions we're building for,
> and test them in appropriate places.  Eg, in this case, we want to
> know if __LINUX_MAX_ARM_ARCH__ >= 7.

Yes, makes sense.

> > The patch below illustrates the problem, if I apply that, I'm
> > able to run all my thumb2 user space code. Unfortunately,
> > I can't use the ldrht instruction there, because the kernel
> > is built with -march=armv6. The patch breaks the exception
> > handling, and I couldn't figure out how to fix that.
> 
> What we could do is use -march=armv6 (it has to be the lowest
> architecture version to stop the compiler issuing instructions which
> don't exist in previous architectures) but pass -mcpu=all to the
> assembler - or even a -march= option which represents the highest
> architecture we want to build for.

That should at least work for isb/dsb/msb and similar instructions
in code that gets binary patching or that is only run on certain
CPUs.

> But... that's not going to help in this case because we don't want
> ldrht instructions here on ARMv6 CPUs without T2 support.  I think
> this is another place which would benefit from run-time patching
> of the kernel text.

Yes, at least if it's performance critical. I was thinking it would
be enought to do an explicit access_ok() check or similar here instead
of the ldrht, which would work on all arch levels, though it would not
strictly be necessary if we never see T2 insns in user space.

	Arnd
