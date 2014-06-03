From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jun 2014 10:56:19 +0100
Subject: Big Endian broken?
Message-ID: <20140603095618.GE933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last night's randconfig build had big endian enabled:

CONFIG_CPU_BIG_ENDIAN=y
CONFIG_CPU_ENDIAN_BE8=y

which found this:

  CC      lib/lockref.o
/tmp/ccWo86hf.s: Assembler messages:
/tmp/ccWo86hf.s:63: Error: even register required -- `strexd r1,r5,r6,[r4]'
/tmp/ccWo86hf.s:135: Error: even register required -- `strexd r1,r5,r6,[r4]'
/tmp/ccWo86hf.s:212: Error: even register required -- `strexd r1,r5,r6,[r4]'
/tmp/ccWo86hf.s:291: Error: even register required -- `strexd r1,r5,r6,[r4]'
/tmp/ccWo86hf.s:398: Error: even register required -- `strexd r1,r5,r6,[r4]'
make[2]: *** [lib/lockref.o] Error 1

It looks to me like a toolchain issue - the compiler has swapped the
register order from (r6,r5) to (r5,r6) for BE, but the assembler still
wants (<even>,<odd>) for this instruction.  Maybe the BE guys can take
a look?

Full config:

http://www.arm.linux.org.uk/developer/build/file.php?lid=8653

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
