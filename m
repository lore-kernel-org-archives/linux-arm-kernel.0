From: hector@marcansoft.com (Hector Martin)
Date: Wed, 24 Feb 2010 10:28:03 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100224085126.GC8068@pengutronix.de>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224085126.GC8068@pengutronix.de>
Message-ID: <4B84F123.10309@marcansoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> This is a big regression as this introduces two new copies.  And as
> CONFIG_ZBOOT_ROM isn't primary about saving RAM at the early boot stages
> but for fast booting this is not acceptable.

I'm not seeing any significant performance decrease due to these
optimized copies, compared to the time spent actually uncompressing the
kernel. In fact, it's quite possible that this will speed things up on
some implementations (particularly simpler/older/slower ones), as doing
a block-based copy from ROM to RAM followed by a RAM->RAM inflate can
very well be faster than uncompressing straight from ROM, if the ROM bus
is slower. Inflate causes many small accesses.

If this can be shown to be a real performance issue, it can be fixed by:
1) not copying the actual payload to RAM, instead passing the ROM
address to the decompressor (you still need a gaping hole in RAM since
you can't relocate the other sections up to fill the hole, but you avoid
the copy)
2) keeping track of the true uncompressed kernel size (not just some 4x
expansion guess), so the loader can be placed directly afterwards,
leaving space for the kernel and avoiding the final relocation.

I'll be happy to make these changes if it really makes a difference, but
I'm not convinced right now.

It's worth noting that while debugging this I found a bug in the inflate
stuff that causes inflate to be *much* slower for certain targets,
including some ARM ones (yet nobody appears to have complained). I'll be
submitting a fix for this to LKML, as it affects the generic deflate
implementation.

-- 
Hector Martin (hector at marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
