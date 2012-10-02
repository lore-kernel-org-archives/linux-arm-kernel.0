From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 2 Oct 2012 15:24:48 -0700
Subject: Problem with mmc DMA on panda board in 3.6
Message-ID: <506B69B0.2010109@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an early report - I'm just checking if anyone else has seen this.

With Linux version v3.6, my PandaBoard (OMAP-based) no longer boots.  The
system appears to fail to initialize the mmc controller.

The kernel log message of interest appears to be this:
[    1.690002] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 6

I can supply full kernel log messages and my .config if needed.

I bisected the code and arrived at the following commit:
-------
commit 26b88520b80695a6fa5fd95b5d97c03f4daf87e0
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Apr 13 12:27:37 2012 +0100

    mmc: omap_hsmmc: remove private DMA API implementation

    Remove the private DMA API implementation from omap_hsmmc, making it
    use entirely the DMA engine API.

    Tested-by: Tony Lindgren <tony@atomide.com>
    Tested-by: Venkatraman S <svenkatr@ti.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
-------
The board works up until this commit.
After this commit, the board hangs during boot after the message:
[    1.852508] Waiting for root device /dev/mmcblk0p3...
(and some other USB and network messages, which I presume
are unrelated.)

My questions are these:
Has anyone else had problems with the PandaBoard (or other OMAP) on 3.6?
Are there any related CONFIG_ variables I could change to try alternatives?
What should I try next to debug this?

 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
