From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Nov 2015 20:03:26 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <4527012.vmieWOaE32@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <6840047.0HF9qAEq6r@wuerfel>
 <20151122194704.GJ8644@n2100.arm.linux.org.uk>
 <4527012.vmieWOaE32@wuerfel>
Message-ID: <20151122200326.GK8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 22, 2015 at 08:58:08PM +0100, Arnd Bergmann wrote:
> does it work with -mcpu=cortex-a15?  I've tried crosstool as versions
> 2.23.52.20130913, 2.24.0.20141017 and 2.25.51.20150518, and they
> all seem to behave as expected, failing with -mcpu=cortex-a9 and
> marvell-pj4 but succeeding with -mcpu=cortex-a15 or marvell-pj4+idiv.

Appears not:

root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='cortex-a15+idiv' -marm
/tmp/ccSovg32.s: Assembler messages:
/tmp/ccSovg32.s:32: Error: selected processor does not support ARM mode `udiv ip,r5,r4'
root at cubox:~# gcc -O2 -o idiv idiv.c -Wa,-mcpu='cortex-a15+idiv' -mthumb
/tmp/cchbT3EE.s: Assembler messages:
/tmp/cchbT3EE.s:36: Error: selected processor does not support Thumb mode `udiv r6,r5,r4'

Same without the +idiv.

> I've also found some /proc/cpuinfo output to cross-reference SoCs
> to their core names.
> 
> 		variant	part	revision	name		features
> mmp2:		0	0x581	5		PJ4		idivt
> dove:		0	0x581	5		PJ4		idivt

Yes, that agrees with my dove.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
