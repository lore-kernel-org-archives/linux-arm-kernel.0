From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 06 Jun 2012 15:17:35 +0200
Subject: [PATCH/RFC 0/2] ARM: DMA-mapping: new extensions for buffer sharing
 (part 2)
Message-ID: <1338988657-20770-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a continuation of the dma-mapping extensions posted in the
following thread:
http://thread.gmane.org/gmane.linux.kernel.mm/78644

We noticed that some advanced buffer sharing use cases usually require
creating a dma mapping for the same memory buffer for more than one
device. Usually also such buffer is never touched with CPU, so the data
are processed by the devices.

>From the DMA-mapping perspective this requires to call one of the
dma_map_{page,single,sg} function for the given memory buffer a few
times, for each of the devices. Each dma_map_* call performs CPU cache
synchronization, what might be a time consuming operation, especially
when the buffers are large. We would like to avoid any useless and time
consuming operations, so that was the main reason for introducing
another attribute for DMA-mapping subsystem: DMA_ATTR_SKIP_CPU_SYNC,
which lets dma-mapping core to skip CPU cache synchronization in certain
cases.

The proposed patches have been generated on top of the ARM DMA-mapping
redesign patch series on Linux v3.4-rc7. They are also available on the
following GIT branch:

git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git 3.4-rc7-arm-dma-v10-ext

with all require patches on top of vanilla v3.4-rc7 kernel. I will
resend them rebased onto v3.5-rc1 soon.

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (2):
  common: DMA-mapping: add DMA_ATTR_SKIP_CPU_SYNC attribute
  ARM: dma-mapping: add support for DMA_ATTR_SKIP_CPU_SYNC attribute

 Documentation/DMA-attributes.txt |   24 ++++++++++++++++++++++++
 arch/arm/mm/dma-mapping.c        |   20 +++++++++++---------
 include/linux/dma-attrs.h        |    1 +
 3 files changed, 36 insertions(+), 9 deletions(-)

-- 
1.7.1.569.g6f426
