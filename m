From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 22:29:43 +0000
Subject: [PATCH 00/48] PL08x DMA
Message-ID: <20110103222943.GB4572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the current state of play with the PL08x driver - a massive 48
patches.  The diffstat doesn't look too impresive:

 drivers/dma/amba-pl08x.c   | 1040 +++++++++++++++++++++-----------------------
 include/linux/amba/pl08x.h |   56 ++--
 2 files changed, 520 insertions(+), 576 deletions(-)

except that the two files comprise some 2300 lines, so this covers
about a quarter of the driver.

The obvious fixes come first in the series, followed by the simpler
changes, gradually progressing towards more and more invasive stuff.

One thing I really don't like are APIs where a lock is held across two
calls - especially when it can be easily worked around.  Patches 45
and 46 which sort this are intentionally towards the end.

Another thing to point out is that platforms can now control which
buses the PL08x uses for transfers for memory, peripherals, etc.
The logic in pl08x_select_bus() is intentionally non-symetric to
prevent both source and destination transfers ending up on the same
bus when both are available.  However, the logic is only well
defined for non-zero values of the source and destination bus masks:

src dst M1      M2
01  01  SRC+DST
01  10  SRC     DST
01  11  SRC     DST
10  01  DST     SRC
10  10          SRC+DST
10  11  DST     SRC
11  01  DST     SRC
11  10  SRC     DST
11  11  SRC     DST

(src/dst bit0 = M1 available, bit1 = M2 available)

If they happen to be zero, then the result is:

src dst M1      M2
00  00          SRC+DST
00  01  DST     SRC    
00  10          SRC+DST
00  11  DST     SRC    
01  00  SRC     DST    
10  00          SRC+DST
11  00          SRC+DST

so not quite what would be expected - so don't have zero bus masks.
