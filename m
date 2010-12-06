From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 14:34:27 +0000
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <1291644581.3151.89.camel@realization>
References: <20101123102632.GM4693@pengutronix.de>
	<1290521329.3901.14.camel@realization>
	<20101123141713.GQ4693@pengutronix.de>
	<20101124080214.GU4693@pengutronix.de>
	<20101206083306.GI10693@pengutronix.de>
	<1291630492.3151.14.camel@realization>
	<20101206102602.GE29563@n2100.arm.linux.org.uk>
	<1291635442.3151.39.camel@realization>
	<20101206114629.GB31777@n2100.arm.linux.org.uk>
	<1291644581.3151.89.camel@realization>
Message-ID: <20101206143427.GF31777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 03:09:41PM +0100, Alberto Panizzo wrote:
> > And the memblock debug output?
> 
> The following is the complete debug:
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Linux version 2.6.36-10808-ga06e72c-dirty (alberto at realization) (gcc version 4.3.2 (OSELAS.Toolchain-1.99.3) ) #180 PREEMPT Mon Dec 6 14:24:53 CET 2010

Ah ha.

> [    0.000000] mx31_3ds_reserve: Reserved 8388608 bytes from address 0x87800000
> 
> Removed 8 MB from the memory map. Start address 0x87800000 
> 
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  rmo_size    = 0x0
> [    0.000000]  memory.size = 0x7800000
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]	0x0000000080000000 - 0x00000000877fffff, 0x7800000 bytes
> [    0.000000]  reserved.cnt  = 0x1
> [    0.000000]  reserved[0x0]	0x0000000080004000 - 0x0000000080415ed7, 0x411ed8 bytes
> 
> That's true, because otherwise (without reserving memory) I get:
> >>[    0.000000]  memory[0x0]	0x0000000080000000 - 0x0000000087ffffff, 0x8000000 bytes

Ok.

> [    0.000000] Memory: 128MB = 128MB total

Ah ha.

You're trying to use something which requires code that was merged into
2.6.37-rc on a kernel which doesn't have the commits necessary to make
it work...

You need at least the core memblock changes, plus 7dc50ec^..f25b4b4
to make this work.
