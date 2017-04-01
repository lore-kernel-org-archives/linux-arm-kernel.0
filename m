From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 1 Apr 2017 15:25:50 +0800
Subject: [PATCH net-next 0/4] ixgbe: enable Relaxed Order for ARM64
Message-ID: <1491031554-19516-1-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IXGBE_ALLOW_RELAXED_ORDER will enable Relaxed Ordering (RO) which allows
transactions that do not have any order of completion requirements to
complete more efficiently compare to the Stricted Ordering (SO) for ixbge
nic card. Some architecture will see high write-to-memory performance when RO is
enabled on the data transactions just like the SPARC did.

The aarch64 could both support Relaxed Ordering (RO) and Stricted Ordering (SO),
so enable this config could get much more better performance, didn't see any
adverse effects.

The ARCH_WANT_RELAX_ORDER looks more general and would cause misleading and
ambiguous, and till now only ixgbe could enable this "flag", so rename this
config more specific.

After discussion with the architecture maintainer, enable this config in driver
looks more appropriate to compatible several architecture just like SPARC and ARM64,
maybe we need more discussion about this, so let's begin by this patch set.

In the last patch 1a8b6d76(net:add one common config ...), Mao only fix the
config name issue for 82599 pf, but the 82598 and 82599 vf still need to be fixed,
so rename the config all in the drivers to instead of CONFIG_SPARC.

Ding Tianhong (4):
  ixgbe: sparc: rename the ARCH_WANT_RELAX_ORDER to
    IXGBE_ALLOW_RELAXED_ORDER
  ixgbe: ixgbevf: Clear the CONFIG_SPARC for ixgbevf and 82598
  ixgbe: move IXGBE_ALLOW_RELAXED_ORDER from architecture to driver
  ixgbe: enable IXGBE_ALLOW_RELAXED_ORDER for ARM64

 arch/Kconfig                                      | 3 ---
 arch/sparc/Kconfig                                | 1 -
 drivers/net/ethernet/intel/Kconfig                | 4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c    | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c   | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.9.0
