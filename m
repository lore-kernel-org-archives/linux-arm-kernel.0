From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Aug 2010 16:06:08 +0100
Subject: thumb2 user binaries with v6/v7 combined kernel
In-Reply-To: <201008051642.04950.arnd@arndb.de>
References: <201008051642.04950.arnd@arndb.de>
Message-ID: <20100805150608.GE23473@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 05, 2010 at 04:42:04PM +0200, Arnd Bergmann wrote:
> I've been trying to run a multi-CPU kernel for armv6 and armv7
> and noticed that thumb2 binaries sometimes crash with SIGILL.
> 
> The only problem appears to be that when __LINUX_ARM_ARCH__
> is set to 6, the kernel does not correctly decode some instructions.

Well, I've been thinking that we should create two new macros to
replace __LINUX_ARM_ARCH__:

__LINUX_MIN_ARM_ARCH__
__LINUX_MAX_ARM_ARCH__

which will be the range of architecture versions we're building for,
and test them in appropriate places.  Eg, in this case, we want to
know if __LINUX_MAX_ARM_ARCH__ >= 7.

> The patch below illustrates the problem, if I apply that, I'm
> able to run all my thumb2 user space code. Unfortunately,
> I can't use the ldrht instruction there, because the kernel
> is built with -march=armv6. The patch breaks the exception
> handling, and I couldn't figure out how to fix that.

What we could do is use -march=armv6 (it has to be the lowest
architecture version to stop the compiler issuing instructions which
don't exist in previous architectures) but pass -mcpu=all to the
assembler - or even a -march= option which represents the highest
architecture we want to build for.

But... that's not going to help in this case because we don't want
ldrht instructions here on ARMv6 CPUs without T2 support.  I think
this is another place which would benefit from run-time patching
of the kernel text.
