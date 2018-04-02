From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 2 Apr 2018 22:35:39 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <8e35701f-1bfa-c9c0-62e6-48ed19d7ba37@axentia.se>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon>
 <8e35701f-1bfa-c9c0-62e6-48ed19d7ba37@axentia.se>
Message-ID: <20180402223539.6dff3f38@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Apr 2018 22:23:17 +0200
Peter Rosin <peda@axentia.se> wrote:


> > I don't use devmem2. Is 'readback' information accurate or is it
> > always what's been written? Because when you write 0x33 to 0xFFFFECBC,
> > 0x33 is read back, but just after that, when you read it again it's 0.  
> 
> Looking at the devmem2 source, it seems very likely that the compiler
> optimizes out the read and thus outputs what has been written.

Yep, had a look too, and it's missing a volatile specifier to prevent
that sort of optimizations.

> 
> >> BTW, how do I
> >> know which master is in use for the LCD controller? 8 or 9? Both?  
> > 
> > It's configurable on a per-layer basis through the SIF bit in
> > LCDC_<layer>CFG0. The driver tries to dispatch the load on those 2 AHB
> > masters [1].  
> 
> Ok, I only have one plane (in this case, i.e. no cursor, no overlays etc),
> would that mean that only one master is used?

Yep, it's always using the first one (master 8 on a sama5d3).

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
