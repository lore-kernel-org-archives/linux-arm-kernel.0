From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Dec 2013 14:19:53 +0100
Subject: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20131217125832.GU4360@n2100.arm.linux.org.uk>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
 <1386925027-16288-2-git-send-email-Li.Xiubo@freescale.com>
 <20131217111020.GF13823@ulmo.nvidia.com>
 <20131217115136.GT4360@n2100.arm.linux.org.uk>
 <20131217122431.GA17210@ulmo.nvidia.com>
 <20131217125832.GU4360@n2100.arm.linux.org.uk>
Message-ID: <20131217131951.GA2329@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 12:58:32PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 17, 2013 at 01:24:33PM +0100, Thierry Reding wrote:
> > On Tue, Dec 17, 2013 at 11:51:36AM +0000, Russell King - ARM Linux wrote:
> > > Same comments here - what memory operations is the wmb() trying to
> > > serialise?  Does this PWM driver somehow end up doing DMA?
> > 
> > Not that I can see. But if my understanding is correct, not using the
> > barriers would allow the compiler and CPU to reorder accesses, and by
> > that cause the register accesses to potentially happen in the wrong
> > order.
> 
> The compiler won't reorder them, but the CPU may if it meets certain
> criteria.  The architecture guarantees that accesses to device memory
> within a (minimum of) 1KB block will be ordered.
> 
> The ARM ARM is slightly ambiguous in how this is applied - in one
> place it says that "Accesses must arrive at any particular memory-mapped
> peripheral or block of memory in program order" and another part it
> says "The size of a memory mapped peripheral, or a block of memory,
> is IMPLEMENTATION DEFINED, but is not smaller than 1KByte.  Note
> This implies that the maximum memory-mapped peripheral size for which
> the architecture guarantees order for all implementations is 1KB."  See
> page A3-148.

None of the ARM ARM versions that I have seem to have page A3-148. Which
version should I be looking at? Not that I'm in any way doubting what
you're saying, I'd just like to make sure to have the correct reference
to look at in the future.

> What this means (to me at least) is that on any SoC, the architecture
> guarantees that accesses _within_ a 1KB device memory block will always
> be ordered, but two accesses outside of a 1KB block _to the same device_
> is implementation defined whether it is ordered or not.

This means at least every ARM SoC would behave that way. Since this
driver doesn't have an explicit dependency on ARM I assume it could
eventually be used on a different architecture. Even more so since
there's Freescale in the name.

> The interesting point here though is that the "note" contradicts the
> first definition if you have (eg) AMBA Primecell peripherals which are
> generally 4KB in size, since if the architecture only guarantees 1KB,
> then accesses _may_ _not_ arrive at one primecell in program order.
> Hence, the note is a direct contradiction of the first definition.

Interesting indeed. Perhaps implementation defined in this case means
that an implementation would have to adjust the size of a memory mapped
peripheral or block of memory accordingly, depending on the largest
block within the SoC.

I suppose, though, that if the architecture doesn't give any guarantees
about it, we can't safely assume that the implementation will.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/5b351e0f/attachment.sig>
