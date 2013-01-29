From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 13:31:48 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <CAKohpo=rD9=dEaPkKYcj55K4_ebdnU7qjv2TZBUwqHAB+Kk+aw@mail.gmail.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291035.30265.arnd@arndb.de>
 <CAKohpo=rD9=dEaPkKYcj55K4_ebdnU7qjv2TZBUwqHAB+Kk+aw@mail.gmail.com>
Message-ID: <201301291331.48427.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Viresh Kumar wrote:
> You can still keep fargs as is and just fill them as:
> 
>        fargs.cfg_lo = 0;
> 
> if (DMA_TO_DEV)
>        // dest is periph
>        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 11;
> else if (DEV_TO_DMA)
>        // src is periph
>        fargs.cfg_hi = be32_to_cpup(dma_spec->args+0) << 7;
> 
> The field size is 4 bits.

Ah, good. So I guess the "dma-requests" property should actually
be "16" then.

Does this mean that an implicit zero request line means memory?

Could we have device-to-device DMAs with this controller, and if
we can, should we have both 'src' and 'dst' fields? Are the
two number ranges sharing the same address space, i.e. is
request '7' as the destination guaranteed to be the same device
as request '7' in the source?

If we need two lines, we could interleave them with the bus
master numbers:

dmas = <&dwdma0 // controller
	7   // source request 7
	1   // source master 1
	0   // dest   request 0
	0>, // dest   master 1
       <&dwdma0
	0   // source request 0
	0   // source master 0
	8   // dest   request 8
	1>; // dest   master 1

In theory, we could use bit-stuffing to put them all into
a single 32 bit word I guess, but generally people don't
seem to like that for new bindings.

> > Thanks a lot for the input. When I fix the above, are actually able
> > to test the changes, or have you lost access to the hardware when
> > leaving ST?
> 
> I don't have any sort of access for testing these :(
> But, Vipul might try these at his end.

Ok, I see.

	Arnd
