From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 25 Aug 2017 12:25:57 -0400
Subject: [PATCH 0/3] make XIP kernel .data compressed in ROM
Message-ID: <20170825162600.15709-1-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series provides the ability to store the kernel .data
segment compressed in ROM. It has to be copied to RAM anyway so
storing it uncompressed is arguably a waste of ROM resources.

While at it, the copying of .data (when not compressed) and the
clearing of .bss is performed using optimized string routines rather
than doing it one word at a time. And throw in small linker script
cleanups for good measure.

This is also available here:

http://git.linaro.org/people/nicolas.pitre/linux xip_zdata

diffstat:

 arch/arm/Kconfig                    | 11 ++++
 arch/arm/boot/Makefile              | 13 ++++-
 arch/arm/boot/deflate_xip_data.sh   | 62 ++++++++++++++++++++++
 arch/arm/kernel/Makefile            |  5 ++
 arch/arm/kernel/head-common.S       | 85 +++++++++++++++++++------------
 arch/arm/kernel/head-inflate-data.c | 63 +++++++++++++++++++++++
 arch/arm/kernel/vmlinux-xip.lds.S   | 22 +++-----
 arch/arm/kernel/vmlinux.lds.S       |  4 +-
 8 files changed, 215 insertions(+), 50 deletions(-)
