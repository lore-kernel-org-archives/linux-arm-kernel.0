From: david@protonic.nl (David Jander)
Date: Wed, 28 Oct 2015 10:48:54 +0100
Subject: BUG: fsl FEC ethernet tx checksum offloading doesn't work with RMII
 interface
Message-ID: <20151028104854.025430ce@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

I was unable to figure out who's maintaining
drivers/net/ethernet/freescale/fec_main.c, so I hope someone can help out on
this list...

We have a board with a RMII phy connected to an i.MX6S. The hardware seems to
be ok, since I can receive and transmit ethernet frames without drops or
errors. However only simple things like ping and dhcp seemed to work. TCP/IP
connections could not be made. When looking at both ends with tcpdump, I
realized that all transmitted packages arrived at the other end with the TCP
and IP header checksums zeroed-out.

After issuing the following command, TCP/IP started working correctly:

$ ethtool --offload eth0 tx off

This works around the issue. For some reason, when the FEC is in RMII mode, it
isn't filling in the checksums.

On another board with an RGMII phy the same kernel works fine without the need
to disable offloading. What can possibly relate this functionality to the
choice of MAC interface?

Best regards,

-- 
David Jander
Protonic Holland.
