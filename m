From: mkubecek@suse.cz (Michal Kubecek)
Date: Tue, 28 Aug 2018 19:56:48 +0200 (CEST)
Subject: [PATCH net-next 0/2] ethtool: drop get_settings and set_settings ops
Message-ID: <cover.1535477409.git.mkubecek@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Andrew Lunn pointed out in recent discussion, there is only one in tree
driver left which still defines deprecated callbacks get_settings() and
set_settings() in ethtool_ops. First patch converts this driver to
get_link_ksettings() and set_link_ksettings(). Second patch then removes
the deprecated callbacks from struct ethtool_ops and ethtool code which
falls back to them.

This doesn't break old versions of ethtool or any other userspace code
using ETHTOOL_{G,S}SET. We still implement both (old) ETHTOOL_{G,S}SET and
(new) ETHTOOL_{G,S}LINKSETTINGS ioctl commands but after this series both
will be implemented only using {g,s}et_link_ksettings(). The only affected
code would be out of tree NIC drivers which have not been converted yet.

Michal Kubecek (2):
  8390/etherh: convert to ethtool_{get,set}_link_ksettings
  ethtool: drop get_settings and set_settings callbacks

 Documentation/ABI/testing/sysfs-class-net |   4 +-
 drivers/net/ethernet/8390/etherh.c        |  35 ++---
 include/linux/ethtool.h                   |  33 ++---
 include/uapi/linux/ethtool.h              |  15 +-
 net/core/ethtool.c                        | 158 +++++-----------------
 5 files changed, 69 insertions(+), 176 deletions(-)

-- 
2.18.0
