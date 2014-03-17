From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 17 Mar 2014 14:40:16 +0100
Subject: [PATCH RESEND v2 0/2]: ixp4xx: Fix 3.7 regression for IXP4xx
 ethernet driver
Message-ID: <20140317144016.0508cc4d@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

These two patches fixes the regression introduced in 3.7 by commit
1a4901177574083c35fafc24c4d151c2a7c7647c,

  ixp4xx_eth: avoid calling dma_pool_create() with NULL dev

The patch above is not incorrect itself, but causes the driver to fail
with

  [   33.055473] net eth1: coherent DMA mask is unset
  [   33.055523] net eth1: coherent allocation too big (requested 0x1000 mask 0x0)

The two patches fix this by generalizing and correcting the ixp4xx
dma_set_coherent_mask(), which earlier only dealt with the PCI case.
The second patch simply sets up the mask for the ixp4xx ethernet device.


The patches have been verified on a board with 256MiB memory, one
ipx4xx_eth device and a e100 PCI device, running Linus' tip.


This issue has been discussed before:

   https://lkml.org/lkml/2014/1/2/46
   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/148811.html


This is a resend of the patch series. There was some discussion about it here:

  http://www.spinics.net/lists/arm-kernel/msg313082.html

and if I understand Russels comments (as per the documentation),
drivers should setup the coherent DMA mask even if it happens to be the
platform/CPU default.

ChangeLog:

v2: Move EXPORT_SYMBOL together with dma_set_coherent_mask

// Simon
