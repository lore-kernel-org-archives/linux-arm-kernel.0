From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 16 Sep 2010 14:09:01 +0200
Subject: colibri-pxa320/AX88796: phy-read/write problems
Message-ID: <4C9208DD.8000805@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

my hardware is a toradex colibri PXA320 board using latest stable
Kernel 2.6.35.4. The Ethernet controller is a AX88796BI.

Ethernet is working, but access via MDIO to the AX's internal phy is
broken. The contents of all registers is 0xffff.

The userspace tool "mii-diag" illustrates the problem:
root at grabowski:~ mii-diag
Using the default interface 'eth0'.
Basic registers of MII PHY #16:  ffff ffff ffff ffff ffff ffff ffff ffff.
  No MII transceiver present!.
  Use '--force' to view the information anyway.

If I switch on the phy_debug in the ax88796 driver we see that the
0xffff are read via "ax_phy_read()" from the hardware, this means it's
not a problem in the userspace.

This is the debug output from the phy register accesses of the generic
mii code, which is polling the link status every 2 seconds.

[   20.946342] ax_phy_issueaddr: dev c77ec000, 0010, 0001, 2
[   20.946416] ax_phy_read: 0010.0001 => read ffff
[   20.946429] ax_phy_issueaddr: dev c77ec000, 0010, 0001, 2
[   20.946502] ax_phy_read: 0010.0001 => read ffff
[   22.946336] ax_phy_issueaddr: dev c77ec000, 0010, 0001, 2
[   22.946410] ax_phy_read: 0010.0001 => read ffff
[   22.946423] ax_phy_issueaddr: dev c77ec000, 0010, 0001, 2
[   22.946496] ax_phy_read: 0010.0001 => read ffff

Is this a known problem? It occurs with several colibri boards. Can
someone with a colibri board or a different board with the ax88796 chip
try to reproduce the problem.

cheers, Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100916/07ef4880/attachment.sig>
