From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Nov 2009 19:05:44 +0000
Subject: GCC built-in atomic operations and memory barriers
In-Reply-To: <4AF1C361.8090405@45mercystreet.com>
References: <4AF1C361.8090405@45mercystreet.com>
Message-ID: <20091104190544.GA518@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2009 at 07:09:37PM +0100, Toby Douglass wrote:
> This leads me to want to use smp_mb().  However, from what I can see,
> this macro is only available via the linux kernel headers; it's not
> available in user-mode.  Is this correct?

Correct.

And please understand that just because something exists in kernel land
does not give userland a right to make use of it.  (There are people
who believe it does.)

The kernel uses header files as a way to efficiently provide itself with
architecture specific optimized helpers, and these helpers may well only
work in kernel land.  Eg, traditionally, atomic operations on ARM
required interrupts to be disabled across them.  Userspace can not
disable interrupts, and so use of those functions in userland leads to
them becoming inherently non-atomic.

The kernel API is the syscall interface and associated data structures.
It does not include everything you can find in kernel headers.
