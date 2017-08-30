From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Aug 2017 22:55:42 -0400
Subject: [PATCH v2 0/5] make XIP kernel .data compressed in ROM
Message-ID: <20170830025547.30347-1-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series provides the ability to store the XIP kernel .data
segment compressed in ROM. It has to be copied to RAM anyway so
storing it uncompressed is arguably a waste of ROM resources.

While at it, the copying of .data (when not compressed) and the
clearing of .bss is now performed using optimized string routines
rather than doing it one word at a time.

This work highlighted some defficiencies in linker scripts, especially
the XIP one. So this also includes linker script cleanups and fixes.

This series is also available here:

http://git.linaro.org/people/nicolas.pitre/linux xip_zdata

Changes from v1:

- Added major fixes to vmlinux-xip.lds.S
- Added extra cleanups to vmlinux.lds.S
- improvements to deflate_xip_data.sh for easier debugging
- __bss_stop aligned to 64 bits for stack usage in the XIP case
- Various commit message clarifications
 
diffstat:

 arch/arm/Kconfig                    | 11 ++++
 arch/arm/boot/Makefile              | 13 ++++-
 arch/arm/boot/deflate_xip_data.sh   | 64 +++++++++++++++++++++
 arch/arm/kernel/Makefile            |  5 ++
 arch/arm/kernel/head-common.S       | 85 +++++++++++++++++-----------
 arch/arm/kernel/head-inflate-data.c | 62 ++++++++++++++++++++
 arch/arm/kernel/vmlinux-xip.lds.S   | 94 ++++++++++++++-----------------
 arch/arm/kernel/vmlinux.lds.S       | 40 ++-----------
 8 files changed, 256 insertions(+), 118 deletions(-)
