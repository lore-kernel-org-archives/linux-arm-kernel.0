From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Dec 2013 15:25:56 +0000
Subject: [PATCH] ARM: asm: add readq/writeq methods
In-Reply-To: <52A32C88.9010000@arkona-technologies.de>
References: <52A32C88.9010000@arkona-technologies.de>
Message-ID: <20131207152556.GP4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 07, 2013 at 03:11:20PM +0100, Matthias Mann wrote:
> Add readq/writeq methods for 32 bit ARM to allow transfering 64 bit words over
> PCIe as a single transfer.

Since these asm instructions are not universally implemented, use of these
will lead to build time errors if a driver attempts to make use of these
on an ARM architecture which doesn't support it.

Hence, these need to be conditional - since they first appeared (iirc) in
ARMv5, then they should be conditional on

#if __LINUX_ARM_ARCH__ >= 5

However, there's another issue here.  The use of readq/writeq() is
controlled with various preprocessor or configuration symbols:

#if BITS_PER_LONG >= 64
#ifdef CONFIG_64BIT
#ifndef readq
#ifndef writeq

I much prefer the latter two, as it means drivers can individually
implement the lacking support in a way which is appropriate for the device
they're driving - which is especially important if reading a register has
side effects.  In other words, readq() and writeq() is not something that
can be provided by an arch where no 64-bit read/write IO instructions
exist.

This requires that where an architecture provides them, that they be
accompanied by these definitions:

#define readq readq
#define writeq writeq

to prevent the drivers own private definitions of these accessors
conflicting.
