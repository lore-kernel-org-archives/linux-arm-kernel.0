From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:11:05 +0100
Subject: [PATCH 00/54] ARM irq_data conversion.
Message-ID: <20101130131105.GA15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set converts arch/arm/ irq_chips and flow handlers over
to the new struct irq_data based irq_chip functions.

struct irq_data is described here:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ff7dcd44dd446db2c3e13bdedf2d52b8e0127f16

The new irq_chip functions are described here:

	http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8822657e799b02c55556c99a601261e207a299d

An example irq_data function conversion looks like this:

	-static void foobar_irq_mask(unsigned int irq)
	+static void foobar_irq_mask(struct irq_data *d)
	 {
	-	foobar_irq_mask &= ~(1 << irq);
	+	foobar_irq_mask &= ~(1 << d->irq);
		intctl_write(foobar_irq_mask);
	 }

	[...]
	 
	 struct irq_chip ext_chip = {
	-	.mask		= foobar_irq_mask,
	+	.irq_mask	= foobar_irq_mask,
	 };


These patches (along with a bunch of other irq_data conversions) are
also available at:

	http://git.kernel.org/?p=linux/kernel/git/buytenh/arm_irq_data.git;a=summary

There is a merge dependency on this patch:

	http://marc.info/?l=linux-kernel&m=129112019408380&w=2

Once the latter goes in, I'll split this queue into individual
per-subsystem queues for upstream merging purposes.


I have built this patch queue against all 153 (!) ARM defconfigs
currently in the tree, and these patches didn't introduce any build
errors that weren't already there.  Also, this queue seems to boot
and run fine on the ARM hardware I have access to.


There is a slight net LOC increase from this patch series due to cases
where the irq_chip functions alter their irq number argument, in which
cases we end up adding a local variable per such function.


Comments and testing appreciated!


 arch/arm/common/gic.c                    |   62 ++++++------
 arch/arm/common/it8152.c                 |   14 ++-
 arch/arm/common/locomo.c                 |   24 ++--
 arch/arm/common/sa1111.c                 |   94 ++++++++--------
 arch/arm/common/vic.c                    |   32 +++---
 arch/arm/kernel/ecard.c                  |   28 +++---
 arch/arm/kernel/irq.c                    |   17 ++--
 arch/arm/kernel/smp_twd.c                |    2 +-
 arch/arm/mach-aaec2000/core.c            |   18 ++--
 arch/arm/mach-at91/gpio.c                |   34 +++---
 arch/arm/mach-at91/irq.c                 |   36 +++---
 arch/arm/mach-bcmring/irq.c              |   42 ++++----
 arch/arm/mach-clps711x/irq.c             |   40 ++++----
 arch/arm/mach-davinci/cp_intc.c          |   30 +++---
 arch/arm/mach-davinci/gpio.c             |   46 ++++----
 arch/arm/mach-davinci/irq.c              |   26 +++---
 arch/arm/mach-dove/irq.c                 |   18 ++--
 arch/arm/mach-ebsa110/core.c             |   14 ++--
 arch/arm/mach-ep93xx/gpio.c              |   36 +++---
 arch/arm/mach-footbridge/common.c        |   14 ++--
 arch/arm/mach-footbridge/isa-irq.c       |   36 +++---
 arch/arm/mach-gemini/gpio.c              |   26 +++---
 arch/arm/mach-gemini/irq.c               |   20 ++--
 arch/arm/mach-h720x/common.c             |   38 ++++----
 arch/arm/mach-h720x/cpu-h7202.c          |   14 ++--
 arch/arm/mach-integrator/integrator_ap.c |   16 ++--
 arch/arm/mach-integrator/integrator_cp.c |   48 ++++----
 arch/arm/mach-iop13xx/irq.c              |   64 ++++++------
 arch/arm/mach-iop13xx/msi.c              |    4 +-
 arch/arm/mach-iop32x/irq.c               |   16 ++--
 arch/arm/mach-iop33x/irq.c               |   32 +++---
 arch/arm/mach-ixp2000/core.c             |   70 +++++++------
 arch/arm/mach-ixp2000/ixdp2x00.c         |   18 ++--
 arch/arm/mach-ixp2000/ixdp2x01.c         |   18 ++--
 arch/arm/mach-ixp23xx/core.c             |   55 ++++++----
 arch/arm/mach-ixp23xx/ixdp2351.c         |   36 +++---
 arch/arm/mach-ixp4xx/common.c            |   42 ++++----
 arch/arm/mach-ks8695/irq.c               |   43 ++++----
 arch/arm/mach-lh7a40x/arch-kev7a400.c    |   20 ++--
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c    |   25 +++--
 arch/arm/mach-lh7a40x/irq-lh7a400.c      |   30 +++---
 arch/arm/mach-lh7a40x/irq-lh7a404.c      |   60 +++++-----
 arch/arm/mach-lh7a40x/irq-lpd7a40x.c     |   22 ++--
 arch/arm/mach-lpc32xx/irq.c              |   56 +++++-----
 arch/arm/mach-mmp/irq-mmp2.c             |   46 ++++----
 arch/arm/mach-mmp/irq-pxa168.c           |   18 ++--
 arch/arm/mach-msm/board-trout-gpio.c     |   42 ++++----
 arch/arm/mach-msm/gpio.c                 |   48 ++++----
 arch/arm/mach-msm/irq-vic.c              |   65 ++++++------
 arch/arm/mach-msm/irq.c                  |   45 ++++----
 arch/arm/mach-msm/sirc.c                 |   39 ++++----
 arch/arm/mach-mx3/mach-mx31ads.c         |   18 ++--
 arch/arm/mach-netx/generic.c             |   30 +++---
 arch/arm/mach-ns9xxx/board-a9m9750dev.c  |   28 +++---
 arch/arm/mach-ns9xxx/irq.c               |   28 +++---
 arch/arm/mach-nuc93x/irq.c               |   16 ++--
 arch/arm/mach-omap1/ams-delta-fiq.c      |    8 +-
 arch/arm/mach-omap1/fpga.c               |   28 +++---
 arch/arm/mach-omap1/irq.c                |   44 ++++----
 arch/arm/mach-omap2/irq.c                |   22 ++--
 arch/arm/mach-pnx4008/irq.c              |   62 ++++++-----
 arch/arm/mach-pxa/balloon3.c             |   23 +++--
 arch/arm/mach-pxa/cm-x2xx-pci.c          |    2 +-
 arch/arm/mach-pxa/generic.h              |    4 +-
 arch/arm/mach-pxa/irq.c                  |   42 ++++----
 arch/arm/mach-pxa/lpd270.c               |   17 ++--
 arch/arm/mach-pxa/lubbock.c              |   17 ++--
 arch/arm/mach-pxa/mainstone.c            |   17 ++--
 arch/arm/mach-pxa/pcm990-baseboard.c     |   15 ++--
 arch/arm/mach-pxa/pxa25x.c               |    7 +-
 arch/arm/mach-pxa/pxa27x.c               |    9 +-
 arch/arm/mach-pxa/pxa3xx.c               |   36 +++---
 arch/arm/mach-pxa/viper.c                |   22 ++--
 arch/arm/mach-pxa/zeus.c                 |   22 ++--
 arch/arm/mach-rpc/irq.c                  |   60 +++++-----
 arch/arm/mach-s3c2410/bast-irq.c         |   22 ++--
 arch/arm/mach-s3c2412/irq.c              |   50 +++++-----
 arch/arm/mach-s3c2416/irq.c              |   72 +++++++-------
 arch/arm/mach-s3c2440/irq.c              |   18 ++--
 arch/arm/mach-s3c2440/s3c244x-irq.c      |   18 ++--
 arch/arm/mach-s3c2443/irq.c              |   90 ++++++++--------
 arch/arm/mach-s3c64xx/irq-eint.c         |   34 +++---
 arch/arm/mach-s5pv310/irq-combiner.c     |   26 +++--
 arch/arm/mach-s5pv310/irq-eint.c         |   55 +++++-----
 arch/arm/mach-sa1100/irq.c               |   84 ++++++++--------
 arch/arm/mach-sa1100/neponset.c          |    8 +-
 arch/arm/mach-shark/irq.c                |   26 +++---
 arch/arm/mach-stmp378x/stmp378x.c        |   16 ++--
 arch/arm/mach-stmp37xx/stmp37xx.c        |   24 ++--
 arch/arm/mach-tcc8k/irq.c                |   56 +++++-----
 arch/arm/mach-tegra/gpio.c               |   38 ++++----
 arch/arm/mach-tegra/irq.c                |   36 +++---
 arch/arm/mach-versatile/core.c           |   16 ++--
 arch/arm/mach-w90x900/irq.c              |   20 ++--
 arch/arm/plat-mxc/3ds_debugboard.c       |   28 +++---
 arch/arm/plat-mxc/gpio.c                 |   30 +++---
 arch/arm/plat-mxc/irq.c                  |   14 ++--
 arch/arm/plat-mxc/tzic.c                 |   38 ++++----
 arch/arm/plat-nomadik/gpio.c             |   56 +++++-----
 arch/arm/plat-omap/gpio.c                |   93 ++++++++--------
 arch/arm/plat-orion/gpio.c               |   37 +++----
 arch/arm/plat-orion/irq.c                |   18 ++--
 arch/arm/plat-pxa/gpio.c                 |   28 +++---
 arch/arm/plat-pxa/include/plat/gpio.h    |    4 +-
 arch/arm/plat-s3c24xx/include/plat/irq.h |    4 +-
 arch/arm/plat-s3c24xx/irq-pm.c           |    9 +-
 arch/arm/plat-s3c24xx/irq.c              |  170 +++++++++++++++---------------
 arch/arm/plat-s5p/irq-eint.c             |   84 ++++++++--------
 arch/arm/plat-s5p/irq-gpioint.c          |   50 +++++-----
 arch/arm/plat-s5p/irq-pm.c               |    6 +-
 arch/arm/plat-samsung/include/plat/pm.h  |    4 +-
 arch/arm/plat-samsung/irq-uart.c         |   44 ++++----
 arch/arm/plat-samsung/irq-vic-timer.c    |   22 ++--
 arch/arm/plat-samsung/pm.c               |    7 +-
 arch/arm/plat-spear/shirq.c              |   22 ++--
 arch/arm/plat-stmp3xxx/irq.c             |    2 +-
 arch/arm/plat-stmp3xxx/pinmux.c          |   32 +++---
 117 files changed, 1938 insertions(+), 1889 deletions(-)
