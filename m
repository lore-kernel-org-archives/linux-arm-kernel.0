From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jun 2011 12:23:02 +0100
Subject: i.MX consolidation patches
In-Reply-To: <20110602103407.GA32632@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601210855.663A3CEFB4E@gemini.denx.de>
	<BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com>
	<20110602103407.GA32632@pengutronix.de>
Message-ID: <20110602112302.GV3660@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 12:34:07PM +0200, Sascha Hauer wrote:
> > * Assuming all ARM kernels are PIC (guaranteed, right?)
> 
> zImages are. The restriction here is:
> 
> config AUTO_ZRELADDR
>         bool "Auto calculation of the decompressed kernel image address"
>         depends on !ZBOOT_ROM && !ARCH_U300
>         help
>           ZRELADDR is the physical address where the decompressed kernel
>           image will be placed. If AUTO_ZRELADDR is selected, the address
>           will be determined at run-time by masking the current IP with
>           0xf8000000. This assumes the zImage being placed in the first 128MB
>           from start of memory.
> 
> So U-Boot could interpret load address being set to 0xffffffff as 'put it
> somewhere in the first 128MB it jump to this address'.

Sascha, I think you're mixing stuff up.

The decompressor is carefully coded to be relocatable provided ZBOOT_ROM=n.
This will be the case for all zImages built to run from RAM.  ZBOOT_ROM
needs to be set to 'y' if you're building a zImage to run directly from
flash, in which case you're not copying it into RAM first.

Even a ZBOOT_ROM=y image can be booted from RAM, but there are additional
restrictions on its placement (as it has the .bss address in RAM hard-coded.)
But let's ignore this case because it adds far more complexity than is
required.

The only thing to bear in mind is that we place the page tables at 16K
into RAM, so the zImage should not be loaded below the low 32K of RAM.
So that implies that uboot must not load a 'relocatable' uImage below
START_OF_RAM + 32K.

Now, AUTO_ZRELADDR allows us to calculate where to place the _decompressed_
kernel by placing it 32K into the start of the 128MB region which the
decompressor is running from.  So that restricts the upper boundary to
START_OF_RAM + 128M.

Note that it's fine to place the decompressor where the decompressed
image will be located, as the decompressor sorts itself out.  However,
that does add some additional overhead, so it may be worth making this
offset a parameter which can be set in uboot.  Default it to 32K, but
allow users to change it if they want to avoid that overlap.

> > * Assuming all ARM kernels start at entry point 0 (true for Image and zImage)
> 
> You mean that the entry point is load address + 0? That should be true.
> Even if not, when the load address is 0xffffffff, the entry point field
> could still describe an offset into the image.

All ARM kernels are entered at the first address of the image.
