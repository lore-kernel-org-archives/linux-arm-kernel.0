From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 13:51:14 +0000
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <20120717152826.2bf75948@skate>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <201207171312.06987.arnd@arndb.de> <20120717152826.2bf75948@skate>
Message-ID: <201207171351.15034.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, Thomas Petazzoni wrote:
> And then, on PowerPC, which accessors do you use to access
> SoC-peripherals that are not on the PCI bus?

PowerPC has in_le32/out_le32 and variants of those, which unfortunately
are not defined for most other architectures, so you cannot use them
in portable code. They are the same as readl/writel, but without the
PCI error handling.

> For example, drivers/tty/serial/mpsc.c uses writel/readl, so a
> conversion to/from little-endian is done when writing/reading
> registers. Are those memory-mapped devices little-endian even though
> they are used on big-endian PowerPCs?
> 
> I apologize for the silly questions, but I'm trying to make some sense
> out of these numerous I/O and memory accessors.

All combinations of little/big endian CPUs and peripherals have been
done in the past, including peripherals that switch their endianess
dynamically when you change the mode of the CPU, and those that come
with an extra register to add byte-swapping for operating systems
that don't deal with it.

It's all a big mess and there is no good solution that anyone has
managed to come with to cover all possibilities. My recommendation
is generally to use the little-endian accessors when they work,
and have your bus-specific or driver-specific wrapper around those
when the endianess is not always the same.

	Arnd
