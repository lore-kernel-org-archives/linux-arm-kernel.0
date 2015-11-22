From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Nov 2015 19:47:05 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <6840047.0HF9qAEq6r@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <12750898.0A5czJmNqv@wuerfel>
 <CAFEAcA-r_zi0-Q9=sT0YTQJ-HGYzLmoWNqtqN6ZV=01qOeCCMw@mail.gmail.com>
 <6840047.0HF9qAEq6r@wuerfel>
Message-ID: <20151122194704.GJ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 22, 2015 at 08:25:27PM +0100, Arnd Bergmann wrote:
> The question is really about Marvell Dove, MMP and Armada 370,
> which are all based on PJ4 or PJ4B (CPU part : 0x581), so ARMv7-A
> and report idivt support but idiva.

Well, it's pretty hard to test when binutils blocks your ability to
write assembly using the instructions.

root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='cortex-a9+idiv' -marm
/tmp/cc8WPQiB.s: Assembler messages:
/tmp/cc8WPQiB.s:32: Error: selected processor does not support ARM mode `udiv ip,r5,r4'
root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='cortex-a9+idiv' -mthumb
/tmp/ccRzgAlM.s: Assembler messages:
/tmp/ccRzgAlM.s:36: Error: selected processor does not support Thumb mode `udiv r6,r5,r4'
root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='marvell-pj4+idiv' -mthumb
/tmp/cc1JYyFD.s: Assembler messages:
/tmp/cc1JYyFD.s:36: Error: selected processor does not support Thumb mode `udiv r6,r5,r4'
root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='marvell-pj4+idiv' -marm
/tmp/ccEQbQpp.s: Assembler messages:
/tmp/ccEQbQpp.s:32: Error: selected processor does not support ARM mode `udiv ip,r5,r4'

That's binutils 2.24 and gcc 4.8.4 as found on Ubuntu 14.04.  I'm
sorry, but I don't have spare time to work out what the opcodes
would be.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
