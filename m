From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Jan 2011 15:14:43 +0100
Subject: [PATCH v4 01/19] ARM: Make the argument to virt_to_phys() "const
	volatile"
In-Reply-To: <20110125102905.GC11507@n2100.arm.linux.org.uk>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<201101251100.11052.arnd@arndb.de>
	<20110125102905.GC11507@n2100.arm.linux.org.uk>
Message-ID: <201101251514.43808.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 January 2011, Russell King - ARM Linux wrote:
> > Stephen, you might want to have a look at why the warning even appears
> > on MSM. Most uses of 'volatile' are misguided, and there could be an
> > actual bug in there.
> 
> It's actually the right thing - look at x86's definition:
> 
> static inline phys_addr_t virt_to_phys(volatile void *address)

Yes, the definition of virt_to_phys using a volatile pointer makes sense
because it allows you to pass volatile pointers, even if it doesn't
make any volatile accesses itself, hence my Acked-by.

However, marking variables as volatile needs to be done very carefully,
and the particular use in arch/arm/mach-msm/smd.c looks suspicious.
I don't think it can cause any actual harm to add volatile to the
smd_half_channel variables, but it disables some optimizations that
gcc can otherwise make, and it's not a replacement for locking or
atomic accesses.

	Arnd
