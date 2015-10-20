From: salil.mehta@huawei.com (Salil)
Date: Tue, 20 Oct 2015 23:01:14 +0800
Subject: [PATCH net-next 0/4] net:hns: Add support of Hip06 SoC to the
 Hislicon Network Subsystem
Message-ID: <1445353278-130498-1-git-send-email-salil.mehta@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Salil Mehta <salil.mehta@huawei.com>

This patch-set adds support of new Hisilicon Hip06 SoC to the existing
(already part of net-next) HNS ethernet driver for Hip05 SoC. Hip06 is
a multi-core SoC and is a derivative of Hip05 SoC with lots of new
hardware featres supported like RSS, TSO, hardware VLAN assist etc. 

The changes in the driver are mainly due to following:
 1) changes in the DMA descriptor provided by the Hip06 ethernet 
    hardware. These changes need to co-exist with already present
    Hip05 DMA descriptor and its operating functions. The decision
    to choose the correct type of DMA descriptor is taken dynamically
    depending upon the version of the hardware (i.e. V1/hip05 or
    V2/hip06, see alredy existing hisilicon-hns-nic.txt binding file
    for the detailed description version and naming).
 2) To support new features added to the Hip06 ethernet hardware:
    a. RSS (Receive Side Scaling)
    b. TSO (TCP Segment Offload)
    c. Hardware VLAN support (currently we are initializing hardware
       to not assist in stripping the vlan tag at hardware level.
       Proper supoort of this feature and ethtool would come after
       these patches have been accepted)

Kindly note that, this patchset has been based on net-next which
already has Hip05 ethernet driver changes.

Salil Mehta (4):
  net:hns: Add support of Hip06 SoC to the Hislicon Network Subsystem
  net:hns: Add Hip06 "RSS(Receive Side Scaling)" support to HNS Driver
  net:hns: Add Hip06 "TSO(TCP Segment Offload)" support HNS Driver
  net:hns: Add the init code to disable Hip06 "Hardware VLAN assist"

 drivers/net/ethernet/hisilicon/hns/hnae.h          |   58 ++-
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |  119 +++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |  154 ++++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |    5 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |    6 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |   91 +++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |   33 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |   68 ++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h  |    8 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |   83 +++-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  440 ++++++++++++++++----
 drivers/net/ethernet/hisilicon/hns/hns_enet.h      |   12 +
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |   71 +++-
 13 files changed, 1003 insertions(+), 145 deletions(-)

-- 
1.7.9.5
