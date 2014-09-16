From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 16 Sep 2014 12:31:46 +0200
Subject: [PATCH 0/3] Fixes for CNS3xxx platform
Message-ID: <m3d2av3lgt.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

1. Fix debug UART.

The debug UART ("earlyprintk") has never worked on this platform. This
should be hardly a surprise, given that the Cavium Econa CNS3xxx CPU has
8250-compatible UARTs (instead of AMBA ports) and the addresses (all the
debug UART code, in fact) seem to be simply copied unchanged from
a random other platform :-)

The patch makes it work.

2. Fix logical PCIe topology.

The CNS3xxx code used a hack which made the kernel "think" that it's not
necessary to go through the root PCIe bridge in order to reach other
PCI(e) devices. This was the source of regression described in
https://lkml.org/lkml/2014/2/28/150 (#2). Broken since v3.12-rc1.
Actually, going through the root bridge is necessary and the patch fixes
this problem.

3. Fix PCIe read size limit.
This fixes a (probably rare) PCI setup bug.


All of this stuff has been tested on Gateworks Laguna platform,
masqueraded as the CNS3xxx devel board, with v3.17-rc5. I guess this is
v3.17 material, though it doesn't make much sense for "stable" branches.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
