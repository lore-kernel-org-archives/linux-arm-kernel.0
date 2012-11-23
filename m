From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 16:38:52 -0800
Subject: [PATCH resend 0/10] Get rid of FIQ_START/enable/disable_fiq() + some
 FIQ cleanups
Message-ID: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew, Russell,

These are small cleanups that I keep resending since Aug. Andrew, can you
please take them for the time being?

The rationale is the same:

During KDB FIQ patches review Russell mentioned that I should not
introduce another FIQ_START. It seems that in v3.6-rc the FIQ_START issue
was somewhat band-aided, i.e. machines don't necessary need to define this
stuff any longer, but I also read the background of the issue, and Russell
once said that he don't want the FIQ subsystem to mess with genirq.

So, the patch set is pretty straightforward:

- Get rid of FIQ_START. Nobody but platform-specific code (and
  platform-specific drivers) should know the details about which interrupt
  can be routed to FIQ and which cannot;

- Remove disable/enable_fiq() calls from the FIQ subsys.

Thanks!

--
 arch/arm/include/asm/fiq.h                    |  2 -
 arch/arm/include/asm/mach/irq.h               |  7 +++-
 arch/arm/kernel/fiq.c                         | 37 +++++--------------
 arch/arm/kernel/irq.c                         |  2 -
 arch/arm/mach-omap1/include/mach/irqs.h       |  4 --
 arch/arm/mach-rpc/dma.c                       |  4 +-
 arch/arm/mach-rpc/include/mach/irqs.h         |  8 ++--
 arch/arm/mach-rpc/irq.c                       | 21 ++---------
 arch/arm/mach-s3c24xx/include/mach/irqs.h     |  3 --
 arch/arm/plat-mxc/avic.c                      |  5 ---
 arch/arm/plat-mxc/include/mach/irqs.h         |  2 -
 arch/arm/plat-mxc/tzic.c                      |  5 ---
 arch/arm/plat-s3c24xx/irq.c                   |  6 +--
 .../media/platform/soc_camera/mx1_camera.c    |  6 +--
 sound/soc/fsl/imx-pcm-fiq.c                   |  4 +-
 15 files changed, 31 insertions(+), 85 deletions(-)
