From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Nov 2015 20:58:08 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151122194704.GJ8644@n2100.arm.linux.org.uk>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <6840047.0HF9qAEq6r@wuerfel> <20151122194704.GJ8644@n2100.arm.linux.org.uk>
Message-ID: <4527012.vmieWOaE32@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 November 2015 19:47:05 Russell King - ARM Linux wrote:
> On Sun, Nov 22, 2015 at 08:25:27PM +0100, Arnd Bergmann wrote:
> > The question is really about Marvell Dove, MMP and Armada 370,
> > which are all based on PJ4 or PJ4B (CPU part : 0x581), so ARMv7-A
> > and report idivt support but idiva.
> 
> Well, it's pretty hard to test when binutils blocks your ability to
> write assembly using the instructions.
> 
> root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='cortex-a9+idiv' -marm
> /tmp/cc8WPQiB.s: Assembler messages:
> /tmp/cc8WPQiB.s:32: Error: selected processor does not support ARM mode `udiv ip,r5,r4'
> root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='cortex-a9+idiv' -mthumb
> /tmp/ccRzgAlM.s: Assembler messages:
> /tmp/ccRzgAlM.s:36: Error: selected processor does not support Thumb mode `udiv r6,r5,r4'
> root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='marvell-pj4+idiv' -mthumb
> /tmp/cc1JYyFD.s: Assembler messages:
> /tmp/cc1JYyFD.s:36: Error: selected processor does not support Thumb mode `udiv r6,r5,r4'
> root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='marvell-pj4+idiv' -marm
> /tmp/ccEQbQpp.s: Assembler messages:
> /tmp/ccEQbQpp.s:32: Error: selected processor does not support ARM mode `udiv ip,r5,r4'
> 
> That's binutils 2.24 and gcc 4.8.4 as found on Ubuntu 14.04.  I'm
> sorry, but I don't have spare time to work out what the opcodes
> would be.
> 

does it work with -mcpu=cortex-a15?  I've tried crosstool as versions
2.23.52.20130913, 2.24.0.20141017 and 2.25.51.20150518, and they
all seem to behave as expected, failing with -mcpu=cortex-a9 and
marvell-pj4 but succeeding with -mcpu=cortex-a15 or marvell-pj4+idiv.

I've also found some /proc/cpuinfo output to cross-reference SoCs
to their core names.

		variant	part	revision	name		features
mmp2:		0	0x581	5		PJ4		idivt
dove:		0	0x581	5		PJ4		idivt
Armada 370	1	0x581	1		PJ4B		idivt
mmp3:		2	0x584	2		PJ4-MP		idiva idivt lpae
Armada XP	2	0x584	2		PJ4-MP		idiva idivt lpae
Berlin		2	0x584	2		PJ4-MP		idiva idivt lpae

	Arnd
