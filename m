From: holgerschurig@gmail.com (Holger Schurig)
Date: Wed, 16 Jul 2014 16:09:37 +0200
Subject: BUG: i.MX6-FEC: broken TCP tx checksumming
In-Reply-To: <20140716095850.GO21766@n2100.arm.linux.org.uk>
References: <CAOpc7mFpW=ZDdF3g-MK4TaNje5KBWimUwUgxoebg-wmb+OQ8zA@mail.gmail.com>
 <20140716095850.GO21766@n2100.arm.linux.org.uk>
Message-ID: <CAOpc7mHQ8EFn0Xm9yPA=z-et6n-QZVctWVkakFZ=O6qo5f4tLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> hat's again read via the generic phy layer, and that suggests that
> the phy finally reported the correct speed... again, I wonder if
> something in the phy layer is buggy.

It's just miitool that is broken. When the link is up & ready, this happens:

root at mde:~# ethtool eth0
Settings for eth0:
Supported ports: [ TP MII ]
Supported link modes:   10baseT/Half 10baseT/Full
                       100baseT/Half 100baseT/Full
Supported pause frame use: Symmetric
Supports auto-negotiation: Yes
Advertised link modes:  10baseT/Half 10baseT/Full
                       100baseT/Half 100baseT/Full
Advertised pause frame use: Symmetric
Advertised auto-negotiation: Yes
Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                    100baseT/Half 100baseT/Full
Link partner advertised pause frame use: Symmetric
Link partner advertised auto-negotiation: Yes
Speed: 100Mb/s
Duplex: Full
Port: MII
PHYAD: 0
Transceiver: external
Auto-negotiation: on
Link detected: yes
root at mde:~# mii-tool eth0
eth0: negotiated 1000baseT-HD flow-control, link ok

Seems also that things in /sys/class/net are ok:

root at mde:~# cat /sys/class/net/eth0/speed
100
root at mde:~# cat /sys/class/net/eth0/duplex
full

mii-tool calls (according to strace) SIOCGMIIPHY, whereas ethtool uses
SIOCETHTOOL.
