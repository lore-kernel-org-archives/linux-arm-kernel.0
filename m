From: holgerschurig@gmail.com (Holger Schurig)
Date: Wed, 16 Jul 2014 10:27:45 +0200
Subject: BUG: i.MX6-FEC: broken TCP tx checksumming
Message-ID: <CAOpc7mFpW=ZDdF3g-MK4TaNje5KBWimUwUgxoebg-wmb+OQ8zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

on my target I use the i:MX6 FEC with kernel 3.16-rc5. Very quickly I
was able to "ping", but TCP (e.g. ssh) didn't work.

I first suspected autonegotiation, because "mii-tool eth0" shows
(wrongly) eth0: negotiated "1000baseT-HD flow-control, link ok".
Despite my switch not a gigabit one ...  Then I found out that
"ethtool eth0" worked better, it displayed "Speed: 100Mb/s", "Duplex:
Full". And with ping working, it couldn't be gigabit-ethernet against
a non-gigabit switch anyway ...

I then looked at linux-next and applied the FEC related patches from
it. To no avail.

Finally I made started wireshark (on the desktop). And Wireshark said:

  Header checksum: 0x0000 [incorrect, should be 0xe65e (may be caused
by "IP checksum offload"?)]

So I tried "ethtool -K eth0 tx off" (on the i.MX6 board) and suddenly
ssh worked.




I think it is unrelated, but together with rc-5 patches I'm using this
linux-next patches:

net: fec: iMX6 FEC does not support half-duplex gigabit
net: fec: fix ethtool set_pauseparam duplex bug
net: fec: fix interrupt handling races
net: fec: use netif_tx_disable() rather than netif_stop_queue()
net: fec: remove checking for NULL phy_dev in fec_enet_close()
net: fec: ensure that a disconnected phy isn't configured
net: fec: stop the phy before shutting down the MAC
net: fec: remove useless fep->opened
net: fec: make rx skb handling more robust
net: fec: clean up transmit descriptor setup
net: fec: ensure fec_enet_free_buffers() properly cleans the rings
net: fec: fix missing kmalloc() failure check in fec_enet_alloc_buffers()
net: fec: improve safety of suspend/resume/transmit timeout paths
net: fec: ensure fec_enet_close() copes with resume failure
net: fec: only restart or stop the device if it is present and running
net: fec: move calls to quiesce/resume packet processing out of fec_restart()
net: fec: remove inappropriate calls around fec_restart()
net: fec: quiesce packet processing before stopping device in fec_suspend()
net: fec: quiesce packet processing before stopping device in fec_set_features()
net: fec: quiesce packet processing before changing features
net: fec: quiesce packet processing when taking link down in
fec_enet_adjust_link()
net: fec: clean up duplex mode handling
net: fec: better implementation of iMX6 ERR006358 quirk
net: fec: replace delayed work with standard work
net: fec: clear receive interrupts before processing a packet
net: fec: reorder ethtool ops to match order in struct declaration
net: fec: add support for dumping transmit ring on timeout
net: fec: remove useless status check in tx reap path
net: fec: consolidate hwtstamp implementation
