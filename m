From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 30 Nov 2013 14:17:38 -0300
Subject: [RFC/PATCH v2] NAND bus-width detection extreme makeover
Message-ID: <1385831859-19170-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another iteration of this proposal, although Brian Norris already said
he didn't like the v1. I guess I'm stubborn ;-)

This patch removes the flash device bus-width configuration, prior to
the device detection. With this modification, a NAND driver *shouldn't*
need to set the device width, but can instead obtain the detected
bus-width after the call to nand_scan_ident() and perform any neccessary
action.

As usual, this has been tested on a AM335x board with 8-bit and 16-bit devices,
which were successfully detected and nandtest'ed, using ONFI and flash-based
detection.

Improving from v1, now driver's shouldn't need *any* modification to work in
both 8-bit and 16-bit modes (although I'm only testing the omap2-nand driver).

Brian and others:

I'm no longer talking about removing any property or option :-), but merely
fixing our current incapability of detecting x16 devices by ONFI. I think
we can discuss about the DT property or the future of NAND_BUSWIDTH_AUTO
in another thread.

Probably there's more work needed along the lines of Uwe's patch to
fix other ONFI-related usage.

Changes from v1:

  * In addition to setting nand_set_default to x8 for the detection phase,
    this commit now clears the NAND_BUSWIDTH_16 flag from chip->options
    as it prevented device from getting detected.

  * This v2 no longer removes the NAND_BUSWIDTH_AUTO option. We can do that
    later after some proper discussion.

Ezequiel Garcia (1):
  mtd: nand: Fix ONFI detection of 16-bit width NAND devices

 drivers/mtd/nand/nand_base.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

-- 
1.8.1.5
