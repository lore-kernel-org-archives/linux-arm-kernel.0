From: eajames@linux.vnet.ibm.com (Eddie James)
Date: Wed, 29 Aug 2018 16:09:29 -0500
Subject: [PATCH 0/4] media: platform: Add Aspeed Video Engine driver
Message-ID: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
can capture and compress video data from digital or analog sources. With
the Aspeed chip acting as a service processor, the Video Engine can
capture the host processor graphics output.

This series adds a V4L2 driver for the VE, providing a read() interface
only. The driver triggers the hardware to capture the host graphics output
and compress it to JPEG format.

Testing on an AST2500 determined that the videobuf/streaming/mmap interface
was significantly slower than the simple read() interface, so I have not
included the streaming part.

It's also possible to use an automatic mode for the VE such that
re-triggering the HW every frame isn't necessary. However this wasn't
reliable on the AST2400, and probably used more CPU anyway due to excessive
interrupts. It was approximately 15% faster.

The series also adds the necessary parent clock definitions to the Aspeed
clock driver, with both a mux and clock divider.

Eddie James (4):
  clock: aspeed: Add VIDEO reset index definition
  clock: aspeed: Setup video engine clocking
  dt-bindings: media: Add Aspeed Video Engine binding documentation
  media: platform: Add Aspeed Video Engine driver

 .../devicetree/bindings/media/aspeed-video.txt     |   23 +
 drivers/clk/clk-aspeed.c                           |   41 +-
 drivers/media/platform/Kconfig                     |    8 +
 drivers/media/platform/Makefile                    |    1 +
 drivers/media/platform/aspeed-video.c              | 1307 ++++++++++++++++++++
 include/dt-bindings/clock/aspeed-clock.h           |    1 +
 6 files changed, 1379 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
 create mode 100644 drivers/media/platform/aspeed-video.c

-- 
1.8.3.1
