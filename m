From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 7 Aug 2013 20:33:57 +0200
Subject: [PATCH 16/17] Add EFI stub for ARM
In-Reply-To: <20130807180548.GA12592@localhost.localdomain>
References: <1375847113-24884-1-git-send-email-roy.franz@linaro.org>
 <1375847113-24884-17-git-send-email-roy.franz@linaro.org>
 <20130807180548.GA12592@localhost.localdomain>
Message-ID: <20130807183357.GN18151@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 07:05:54PM +0100, Dave Martin wrote:
> Is it possible for this allocation to fail -- i.e., because UEFI has
> put us in an unsuitable location which is within the first 128MB of
> RAM, such that we can't pick a suitable location without overlap?
> 
> For the time being though, I think this is impossible because the
> decompressed Image can't exceed ~32MB (so the zImage should not
> exceed that either, and both can fit inside 128MB.  It doesn't
> matter if UEFI's initial load location overlaps the decompressed
> Image).
> 
> If UEFI put reserved regions with the first 128MB we're likely to
> be dead anyway, so we shouldn't assume we'll have to cope with that
> for now...

There is no reason we would be dead unless we end up not being able
to allocate regions for FDT and initrd within range.

There could be some boot services region lying around, that will
be reusable before we even jump to the decompressor. Or there could
be some badly placed runtime code lying where it can safely remain.

Are there additional kernel regions to worry about?

> > +		@ Save return values of efi_entry
> > +		stmfd	sp!, {r0, r3}
> > +		bl	cache_clean_flush
> > +		bl	cache_off
> 
> Why turn the cache off?  Does that mean that EFI may launch images with
> the cache enabled?
 
Yup.

> If so, are we guaranteed that VA=PA?  Otherwise simply turning the MMU
> off is not safe.

Yes, VA=PA is guaranteed.
 
> (Hmm, the UEFI spec seems to suggest "yes" for these questions)
 
:)

/
    Leif
