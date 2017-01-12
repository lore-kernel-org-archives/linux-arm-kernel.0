From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jan 2017 14:28:03 +0100
Subject: [PATCH 1/2] dma-mapping: let arch know origin of dma range passed
 to arch_setup_dma_ops()
In-Reply-To: <7d7dc402-e527-c581-0b1c-37713759db31@cogentembedded.com>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <764334db-3400-58c6-cc4b-3f7ce66daa27@cogentembedded.com>
 <7d7dc402-e527-c581-0b1c-37713759db31@cogentembedded.com>
Message-ID: <3013606.q8hexDUEqF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 12, 2017 9:33:32 AM CET Nikita Yushchenko wrote:
> >> Hmm, I think when the dma-ranges are missing, we should either enforce
> >> a 32-bit mask, or disallow DMA completely. It's probably too late for
> >> the latter, I wish we had done this earlier in order to force everyone
> >> on ARM64 to have a valid dma-ranges property for any DMA master.
> > 
> > This can be done over time.
> > 
> > However the very idea of this version of patch is - keep working pieces
> > as-is, thus for now setting enforce_range to false in case of no defined
> > dma-ranges is intentional.
> 
> What we can do is - check bus width (as it is defined in DT) and set
> enforce_range to true if bus is 32-bit
> 
> > What I should re-check is - does rcar dtsi set dma-ranges, and add it if
> > it does not.
> 
> It does not, will have to add.
> 
> In DT bus is defined as 64-bit. But looks like physically it is 32-bit.
> Maybe DT needs fixing.

I think we always assumed that the lack of a dma-ranges property
implied a 32-bit width, as that is the safe fallback as well as the
most common case.

AFAICT, this means you are actually fine on rcar, and all other
platforms will keep working as we enforce it, but might get slowed
down if they relied on the unintended behavior of allowing 64-bit
DMA.

	Arnd
