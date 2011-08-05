From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 5 Aug 2011 15:51:33 +0200
Subject: GPMI-NAND Status?
Message-ID: <20110805135133.GA26981@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am a bit uncertain how the state of the GPMI-NAND driver currently is, so
I'll try to sum it up here. There is without doubt interest in getting the
driver into mainline from at least Huang, Shawn, Lothar, Koen and me, so I
wonder if we can join forces more effectively. First of all, I want to thank
Huang Shijie for all his work so far which was already quite some effort; this
sum-up is by no means meant as bashing, just trying to understand the status
quo (Sidenote: I am more or less on holiday until Monday, so no time for real
debugging myself. I write this mail so we hopefully gain a common
understanding. When I am back to full strength, I can then start working on
what seems apropriate)

Issues with the current driver I am aware of:

DMA timeouts [1]
================

[    2.560000] [ start_dma_without_bch_irq : 392 ] DMA timeout, last DMA :1
[    3.560000] [ start_dma_with_bch_irq : 427 ] bch timeout!!!

Always reproducible by me when trying to format mtd0. Sometimes(always?) seen
by Koen during boot (on read?). Never seen by Huang? It is currently unclear if
the bug is in the GPMI driver, or in the MXS-DMA driver. Still, I'd say the
issue is a show-stopper. We can't put a driver into mainline which leads to the
above failure. The fact that there is _some_ configuration which works for
someone does not help, it doesn't work for Koen and me at least. We need
reliable drivers in mainline, so the issue needs to be resolved, regardless
where the bug resides.


problem overwriting all-0xff data in NAND [2]
=============================================

Although it occured only when writing JFFS2 images so far, this is a generic
issue and needs to be fixed, right?


ecclayout needs to be used to show that OOB is fully in use [1]
===============================================================

Needed to make it work for JFFS2 and to pass the mtd-testsuite. A driver only
working with UBIFS is surely not ready for mainline.


Pecularities
============

There are a few issues which are odd. I don't know if some are mainly intended
for debugging, yet they shouldn't be in a mainline driver. At least:

* custom sysfs-entries
* custom kernel command line parameters
* namespacing (some functions have no prefix, some have "mil_", some have mx23)
  (I think 'mil' means 'mtd interface layer', but why is that needed?)

Complexity
==========

The driver is not easy to review. I wonder if it makes sense to use incremental
patches for it? maybe making it a staging driver could be a solution for that?
Huang, are you interested in accepting patches or do you prefer we just point
at certain code and you then fix it? Starting with a simpler driver and then
adding stuff might be another option if we can't chase all the bugs in the
current driver.

That being said, I'd think fixing the DMA issue has prio #1 and maybe we can
meet in IRC or something to work that out? Is there interest in that?

Ok, those were my two cents. Your mileages may vary, please give your thoughts,
then. I mainly don't want the driver development to get stalled.

Regards,

   Wolfram

[1] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037200.html
[2] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037104.html
-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110805/e0d99aab/attachment-0001.sig>
