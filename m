From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed,  4 Dec 2013 16:44:42 +0100
Subject: [PATCH RFCv2 0/6] net: phy: Ethernet PHY powerdown optimization
In-Reply-To: <1384978913-8052-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1384978913-8052-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1386171888-28190-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of an RFC sent earlier [1] to reduce power consumption of network
PHYs with link that are either unused or the corresponding netdev is down.

In contrast to RFCv1, this now integrates phy_suspend/phy_resume transparent
to the netdev drivers. Also, phy_suspend now only suspends the PHY if WOL is
disabled. Moreover, the phy state machine calls phy_suspend on entering
HALTED state.

Again, a branch with RFCv2 applied to v3.13-rc2 can also be found at
https://github.com/shesselba/linux-dove.git topic/ethphy-power-rfc-v2

[1] http://lwn.net/Articles/574426/

Sebastian Hesselbarth (6):
  net: mv643xx_eth: properly start/stop phy device
  net: phy: marvell: provide genphy suspend/resume
  net: phy: provide phy_resume/phy_suspend helpers
  net: phy: resume/suspend PHYs on attach/detach
  net: phy: suspend unused PHYs on mdio_bus in late_initcall
  net: phy: suspend phydev when going to HALTED

 drivers/net/ethernet/marvell/mv643xx_eth.c |    4 +++-
 drivers/net/phy/marvell.c                  |   22 ++++++++++++++++++++++
 drivers/net/phy/mdio_bus.c                 |   25 +++++++++++++++++++++++++
 drivers/net/phy/phy.c                      |    6 +++++-
 drivers/net/phy/phy_device.c               |   27 +++++++++++++++++++++++++++
 include/linux/phy.h                        |    2 ++
 6 files changed, 84 insertions(+), 2 deletions(-)

---
Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: netdev at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.7.2.5
