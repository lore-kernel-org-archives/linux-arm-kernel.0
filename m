From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jun 2014 11:32:42 +0100
Subject: Big Endian broken?
In-Reply-To: <5340132.TxQQqdITJ3@wuerfel>
References: <20140603095618.GE933@n2100.arm.linux.org.uk>
 <5340132.TxQQqdITJ3@wuerfel>
Message-ID: <20140603103242.GF933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 12:13:37PM +0200, Arnd Bergmann wrote:
> On Tuesday 03 June 2014 10:56:19 Russell King - ARM Linux wrote:
> > Last night's randconfig build had big endian enabled:
> > 
> > CONFIG_CPU_BIG_ENDIAN=y
> > CONFIG_CPU_ENDIAN_BE8=y
> > 
> > which found this:
> > 
> >   CC      lib/lockref.o
> > /tmp/ccWo86hf.s: Assembler messages:
> > /tmp/ccWo86hf.s:63: Error: even register required -- `strexd r1,r5,r6,[r4]'
> > /tmp/ccWo86hf.s:135: Error: even register required -- `strexd r1,r5,r6,[r4]'
> > /tmp/ccWo86hf.s:212: Error: even register required -- `strexd r1,r5,r6,[r4]'
> > /tmp/ccWo86hf.s:291: Error: even register required -- `strexd r1,r5,r6,[r4]'
> > /tmp/ccWo86hf.s:398: Error: even register required -- `strexd r1,r5,r6,[r4]'
> > make[2]: *** [lib/lockref.o] Error 1
> > 
> > It looks to me like a toolchain issue - the compiler has swapped the
> > register order from (r6,r5) to (r5,r6) for BE, but the assembler still
> > wants (<even>,<odd>) for this instruction.  Maybe the BE guys can take
> > a look?
> > 
> > Full config:
> > 
> > http://www.arm.linux.org.uk/developer/build/file.php?lid=8653
> > 
> 
> 
> Which toolchain are you using? I just tried reproducing this but
> it works on linux-next with your config for every version I tried:
> ubuntu 4.6, 4.7, 4.8 and vanilla 4.8.0, 4.8.3, 4.9.0, 4.10-pre,
> and gas 2.23.52.20130913 as well as 2.24.51.20131021.

stock gcc 4.6.4 with stock binutils 2.22.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
