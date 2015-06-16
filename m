From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Tue, 16 Jun 2015 15:10:51 +0200
Subject: [BUG] at91: macb: does not work
Message-ID: <5580205B.1030804@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
in v4.1-rc8 does not work ethernet. It normally gets up, but no data are going through.

[    4.400000] macb f802c000.ethernet (unnamed net_device) (uninitialized): invalid hw address, using random
[    4.510000] macb f802c000.ethernet eth0: Cadence MACB rev 0x0001010c at 0xf802c000 irq 37 (52:30:8f:6b:9c:b7)
[    4.520000] macb f802c000.ethernet eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=f802c000.etherne:03, irq=-1)
[   15.510000] macb f802c000.ethernet eth0: link up (100/Full)

/ # ip -s link ls eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
     link/ether a2:61:fe:17:65:b1 brd ff:ff:ff:ff:ff:ff
     RX: bytes  packets  errors  dropped overrun mcast
     0          0        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0

In v4.0.5 it's working.

I bisected it and found:
a848748959d554666b34cffc08ef2d23f4bb2990 is the first bad commit
commit a848748959d554666b34cffc08ef2d23f4bb2990
Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
Date:   Sat Mar 7 07:23:30 2015 +0100

     net: macb: remove #if defined(CONFIG_ARCH_AT91) sections

     With multi platform support those sections could lead to unexpected
     behavior if both ARCH_AT91 and another ARM SoC using the MACB IP are
     selected.
     Add two new capabilities to encode the default MII mode and the presence
     of a CLKEN bit in USRIO register.
     Then define the appropriate config for IPs embedded in at91 SoCs.

     Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
     Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 1c87dbb47362b56e88a0e7256c991c64cf60e0bf af0bcc11f81aebf2c64afa5cd53766d494ea3fdb M	drivers


Jiri
