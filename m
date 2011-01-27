From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:57:14 +0000
Subject: [PATCH 00/10] Fix CLCD framebuffer formats and consolidate ARM
	platform CLCD support
Message-ID: <20110127125714.GD25968@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes the framebuffer formatting for the various
CLCD colour modes - including those which the CLCD doesn't actually
support.

PL110 in TFT mode only supports 888 and 5551 connectivity.  Some ARM
platforms have additional muxing on their outputs which rewire this
to allow the 5551 output to be used in 565 mode:

FBMEM bit (RGB)	5551	565
0		R0	R0
1		R1	R1
2		R2	R2
3		R3	R3
4		R4	R4
5		G0	G0
6		G1	G1
7		G2	G2
8		G3	G3
9		G4	G4
10		B0	G5
11		B1	B0
12		B2	B1
13		B3	B2
14		B4	B3
15		I	B4

This means that when BGR mode is selected, it in green mapping to bits
0, 9, 8, 7, 6, 5 in the framebuffer, which is not sane.  There appears
to be no external MUX selection for this format.

PL111 on the other hand supports 888, 5551, 565 and 444 natively, so it
can support RGB and BGR pixel formats directly.

Introduce a set of capabilities one bit for each format (RGB888, BGR888,
RGB5551, BGR5551 etc) describing what formats the panel itself can support,
and also what the board can support.  These are combined, and from that
we select the appropriate 16bpp pixel format which the panel and board can
support.  Where a panel and board combination supports multiple 16bpp
formats, pick the closest format to the requested format.

Implementations which do not supply the capabilities fall back to the old
way of doing things, which is based on the cntl register to indicate
whether we should be using RGB or BGR mode.

This then allows us to unify the CLCD support across Integrator, Versatile,
Realview and Versatile Express.  This has been successfully tested on:

Integrator/CP - RGB565, RGB5551, BGR5551.
Versatile PB926 - RGB565, BGR565, RGB5551, BGR5551.
Realview EB ARM11MPcore - RGB565, BGR565, RGB5551, BGR5551, RGB444, BGR444.
