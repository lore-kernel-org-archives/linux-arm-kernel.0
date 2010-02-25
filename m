From: hector@marcansoft.com (Hector Martin)
Date: Thu, 25 Feb 2010 11:05:00 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100225093859.GA19870@n2100.arm.linux.org.uk>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>	<20100224223418.GB25587@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>	<20100224234215.GA21985@n2100.arm.linux.org.uk>	<4B85BCE0.7000903@marcansoft.com>	<20100225000114.GB21985@n2100.arm.linux.org.uk>	<4B85C4A4.4060005@marcansoft.com>	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
Message-ID: <4B864B4C.9020805@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> I wonder if we can get around this problem a slightly different way -
> instead of building the decompressor into misc.c, build it as a separate
> PIC object without the -Dstatic= stuff, and verify that it contains no
> read-write data.

You're still going to have issues if it uses read-only data and accesses
it via an offset from the GOT, though.

> Then we can tailor our misc.c not to use static data (which is the real
> problem - not the functions being static), and the -Dstatic= hack will
> go away.

If you can programmatically ensure that the decompressors do not use
anything but GOT entries to access data, that's certainly a better
solution than what we have now (I don't mean actually "fixing" them as
in -Dstatic=, just something that makes the build fail if this is not
the case so someone else can go and make the required changes). Maybe
building the object and then grepping the relocations for offenders, or
something like that.

However, considering my second patch can be adapted to avoid the two
extra copies, I still think that's a cleaner solution. All I have to do
is move things around in the linker script so the piggy is at the end of
the zImage, avoid copying that the first time around (and instead pass
the old pointer to ROM to the decompressor), and introduce the real
decompressed uncompressed kernel size to the mix so I can relocate the
decompressor to ZRELADDR+kernel_size (and fix the relocation check code
so it uses the real size, not some 4x guess), which would avoid the
second copy.

-- 
Hector Martin (hector at marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
