From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Thu, 30 Aug 2018 14:20:27 -0300
Subject: [RFC 0/3] Introduce usb_{alloc,free}_noncoherent API
Message-ID: <20180830172030.23344-1-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the discussion on PWC [1] and UVC [2] drivers, where
use non-consistent mappings for the URB transfer buffers was
shown to improve transfer speed significantly, here's a proposal
for a non-coherent USB helpers.

With this pachset, it's possible to get 360x288 raw analog video
using stk1160 and a AM335x Beaglebone Black board. This isn't
possible in mainline, for the same reasons Matwey has explained [1].

First patch is a hack, obviously incomplete, to add support for
non-consistent mappings on ARM.

The second patch introduces the usb_{alloc,free}_noncoherent API,
while the third patch is an example on stk1160.

I'm sending this patchset as RFC, just to get the ball rolling.

[1] https://lkml.org/lkml/2018/8/21/663
[2] https://lkml.org/lkml/2018/6/27/188

Ezequiel Garcia (3):
  HACK: ARM: dma-mapping: Get writeback memory for non-consistent
    mappings
  USB: core: Add non-coherent buffer allocation helpers
  stk1160: Use non-coherent buffers for USB transfers

 arch/arm/include/asm/pgtable.h            |  3 ++
 arch/arm/mm/dma-mapping.c                 |  9 ++--
 drivers/media/usb/stk1160/stk1160-video.c | 22 +++------
 drivers/usb/core/buffer.c                 | 29 +++++++-----
 drivers/usb/core/hcd.c                    |  5 +-
 drivers/usb/core/usb.c                    | 56 ++++++++++++++++++++++-
 include/linux/usb.h                       |  5 ++
 include/linux/usb/hcd.h                   |  4 +-
 8 files changed, 97 insertions(+), 36 deletions(-)

-- 
2.18.0
