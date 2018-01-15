From: aleksey.makarov@cavium.com (Aleksey Makarov)
Date: Mon, 15 Jan 2018 18:44:55 +0600
Subject: [PATCH net-next v6 0/2] net: thunderx: add support for PTP clock
Message-ID: <20180115124500.14872-1-aleksey.makarov@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for IEEE 1588 Precision Time Protocol
to Cavium ethernet driver.

The first patch adds support for the Precision Time Protocol Clocks and
Timestamping coprocessor (PTP) found on Cavium processors.
It registers a new PTP clock in the PTP core and provides functions
to use the counter in BGX, TNS, GTI, and NIC blocks.

The second patch introduces support for the PTP protocol to the
Cavium ThunderX ethernet driver.

v6:
- check if ptp_clock_register() returns NULL (Richard Cochran)
- fix doc comment for cavium_ptp_enable() (Richard Cochran)
- fix a function call formatting; use defined constant (Richard Cochran)
- add comments for `tx_ptp_skbs` and `ptp_skb` (Richard Cochran)
- use adjfine() instead of adjfreq() (Richard Cochran)
- add Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

v5: https://lkml.kernel.org/r/20171211141435.2915-1-aleksey.makarov at cavium.com
- fix the file headers (add SPDX tags, remove advertisment) (Philippe Ombredanne)
- use "imply" instead of "select" (Richard Cochran)
- add some code in cavium_ptp_get() for the case when the PTP driver has not been
  registered with the PTP core

v4: https://lkml.kernel.org/r/20171208103442.19354-1-aleksey.makarov at cavium.com
- use IS_ENABLED. This fixes compilation of the ptp as a module (David Miller)
- select PTP_1588_CLOCK, not depend on it.  This fixes a build warning.
- change u64 to __be64.  This fixes the sparse warning
  "warning: cast to restricted __be64"
- make nicvf_config_hwtstamp() static. This fixes the sparse warning
  "warning: symbol 'nicvf_config_hwtstamp' was not declared. Should it be static?"

v3: https://lkml.kernel.org/r/20171206133100.26436-1-aleksey.makarov at cavium.com
- rebase to net-next

v2: https://lkml.kernel.org/r/20171117134909.8954-1-aleksey.makarov at cavium.com
- use readq()/writeq() in place of cavium_ptp_reg_read()/cavium_ptp_reg_write(),
  don't use readq_relaxed()/writeq_relaxed() (David Daney)

v1: https://lkml.kernel.org/r/20171107190704.15458-1-aleksey.makarov at cavium.com

Radoslaw Biernacki (1):
  net: add support for Cavium PTP coprocessor

Sunil Goutham (1):
  net: thunderx: add timestamping support

 drivers/net/ethernet/cavium/Kconfig                |  13 +
 drivers/net/ethernet/cavium/Makefile               |   1 +
 drivers/net/ethernet/cavium/common/Makefile        |   1 +
 drivers/net/ethernet/cavium/common/cavium_ptp.c    | 353 +++++++++++++++++++++
 drivers/net/ethernet/cavium/common/cavium_ptp.h    |  70 ++++
 drivers/net/ethernet/cavium/thunder/nic.h          |  36 +++
 drivers/net/ethernet/cavium/thunder/nic_main.c     |  56 +++-
 drivers/net/ethernet/cavium/thunder/nic_reg.h      |   1 +
 .../net/ethernet/cavium/thunder/nicvf_ethtool.c    |  29 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   | 169 +++++++++-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  26 ++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  |  29 ++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |   4 +
 13 files changed, 782 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/cavium/common/Makefile
 create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.c
 create mode 100644 drivers/net/ethernet/cavium/common/cavium_ptp.h

-- 
2.15.1
