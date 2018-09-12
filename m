From: phil@raspberrypi.org (Phil Elwell)
Date: Wed, 12 Sep 2018 17:42:32 +0100
Subject: [PATCH 0/2] Improve VCHIQ cache line size handling
Message-ID: <1536770554-107314-1-git-send-email-phil@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both sides of the VCHIQ communications mechanism need to agree on the cache
line size. Using an incorrect value can lead to data corruption, but having the
two sides using different values is usually worse.

In the absence of an obvious convenient run-time method to determine the
correct value in the ARCH=arm world, the downstream Raspberry Pi trees used a
Device Tree property, written by the firmware, to configure the kernel driver.
This method was vetoed during the upstreaming process, so a fixed value of 32
was used instead, and some corruptions ensued. This is take 2 at arriving at
the correct value.

Part one of the fix is deriving the correct value from the ARM's cpuid register.
Part two is a (seemingly cosmetic) correction of the Device Tree reg declaration
used by the driver, but it doubles as an indication to the Raspberry Pi firmware
that the kernel driver is running a recent kernel driver that chooses the
correct value. As such I would like very much for the DT patch not to be merged
before the driver patch - just tell me what hoops I need to jump through.

Phil Elwell (2):
  staging/vc04_services: Derive g_cache_line_size
  ARM: dts: bcm283x: Correct mailbox register sizes

 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  2 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           | 24 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.7.4
