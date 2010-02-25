From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 25 Feb 2010 13:35:32 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B864B4C.9020805@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
	<4B864B4C.9020805@marcansoft.com>
Message-ID: <alpine.LFD.2.00.1002251332190.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Hector Martin wrote:

> If you can programmatically ensure that the decompressors do not use
> anything but GOT entries to access data, that's certainly a better
> solution than what we have now (I don't mean actually "fixing" them as
> in -Dstatic=, just something that makes the build fail if this is not
> the case so someone else can go and make the required changes). Maybe
> building the object and then grepping the relocations for offenders, or
> something like that.

Russell made a patch which simply ends up discarding .data section.

> However, considering my second patch can be adapted to avoid the two
> extra copies, I still think that's a cleaner solution. All I have to do
> is move things around in the linker script so the piggy is at the end of
> the zImage, avoid copying that the first time around (and instead pass
> the old pointer to ROM to the decompressor), and introduce the real
> decompressed uncompressed kernel size to the mix so I can relocate the
> decompressor to ZRELADDR+kernel_size (and fix the relocation check code
> so it uses the real size, not some 4x guess), which would avoid the
> second copy.

You are still copying the actual decompressor code which is less optimal 
than what we already have.  The current solution, as I explained 
already, involves _zero_ copying.


Nicolas
