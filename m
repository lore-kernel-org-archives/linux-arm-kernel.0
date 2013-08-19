From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Aug 2013 09:58:54 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <52115268.4010100@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308172112.30773.arnd@arndb.de> <52115268.4010100@gmail.com>
Message-ID: <201308190958.54613.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 August 2013, Sebastian Hesselbarth wrote:
> AFAIK, there is Armada 1500 (88de3100) used in every Google TV 2nd Gen
> devices, some older multimedia boxes also used Armada 1000 (88de3010),
> and Chromecast comprises Armada 1500-mini (88de3005).

According to the chromecast kernel sources (which seem to have all the
gtv stuff in them), they changed the CPU core between minor versons
of the 88de3100:

PJ4 based:

- MV88DE3100_BG2_A0
- MV88DE3100_BG2_A1

Cortex-A5 or Cortex-A9 based:

- MV88DE3100_BG2_CD
- MV88DE3100_BG2_CZ
- MV88DE3100_BG3

Those are Kconfig strings, I don't know how those correspond to
chip identification registers or labels printed on the SoC package.

> We should be able to find out if it is PJ4B or Cortex-A9 by checking
> any CPU register?

/proc/cpuinfo will tell you what core you have, see
http://wiki.casthacks.com/index.php?title=Google_ChromeCast_Specs:

CPU implementer : 0x41     # 0x41 == ARM Ltd
CPU architecture: 7        # 0x07 == ARMv7
CPU variant     : 0x3      # 0x03 == Core revision r3
CPU part        : 0xc09    # 0xc0? == Cortex-A?, 0xc09 == A9
CPU revision    : 0        # 0x00 == minor revision r3p0

On http://forum.gtvhacker.com/star-vap430-f40/topic972.html, I found
this for a PJ4 based 88de3100:

CPU implementer : 0x56
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0x584
CPU revision    : 1

Comparing those to other bits I found on the web, it actually seems to
be a PJ4B rather than the original PJ4.

	Arnd
