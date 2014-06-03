From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Jun 2014 12:13:37 +0200
Subject: Big Endian broken?
In-Reply-To: <20140603095618.GE933@n2100.arm.linux.org.uk>
References: <20140603095618.GE933@n2100.arm.linux.org.uk>
Message-ID: <5340132.TxQQqdITJ3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 June 2014 10:56:19 Russell King - ARM Linux wrote:
> Last night's randconfig build had big endian enabled:
> 
> CONFIG_CPU_BIG_ENDIAN=y
> CONFIG_CPU_ENDIAN_BE8=y
> 
> which found this:
> 
>   CC      lib/lockref.o
> /tmp/ccWo86hf.s: Assembler messages:
> /tmp/ccWo86hf.s:63: Error: even register required -- `strexd r1,r5,r6,[r4]'
> /tmp/ccWo86hf.s:135: Error: even register required -- `strexd r1,r5,r6,[r4]'
> /tmp/ccWo86hf.s:212: Error: even register required -- `strexd r1,r5,r6,[r4]'
> /tmp/ccWo86hf.s:291: Error: even register required -- `strexd r1,r5,r6,[r4]'
> /tmp/ccWo86hf.s:398: Error: even register required -- `strexd r1,r5,r6,[r4]'
> make[2]: *** [lib/lockref.o] Error 1
> 
> It looks to me like a toolchain issue - the compiler has swapped the
> register order from (r6,r5) to (r5,r6) for BE, but the assembler still
> wants (<even>,<odd>) for this instruction.  Maybe the BE guys can take
> a look?
> 
> Full config:
> 
> http://www.arm.linux.org.uk/developer/build/file.php?lid=8653
> 


Which toolchain are you using? I just tried reproducing this but
it works on linux-next with your config for every version I tried:
ubuntu 4.6, 4.7, 4.8 and vanilla 4.8.0, 4.8.3, 4.9.0, 4.10-pre,
and gas 2.23.52.20130913 as well as 2.24.51.20131021.

I get the same even-odd pair for all versions:

gcc-4.6
        strexd          r1, r2, r3, [r4]        @ res, new, lockref
gcc-4.7
        strexd          r1, r2, r3, [r8]        @ res, new, lockref
gcc-4.8
        strexd          r1, r2, r3, [r8]        @ res, new, lockref
gcc-4.9
        strexd          r1, r2, r3, [r4]        @ res, new, lockref
gcc-4.10
        strexd          ip, r2, r3, [r4]        @ res, new, lockref

	Arbd
