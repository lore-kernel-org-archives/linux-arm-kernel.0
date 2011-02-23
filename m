From: ben-i2c@fluff.org (Ben Dooks)
Date: Wed, 23 Feb 2011 01:14:12 +0000
Subject: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <20110207175604.GA24850@www.tglx.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
	<20110105202136.GI817@trinity.fluff.org>
	<20110114143107.GA15462@www.tglx.de>
	<20110207175604.GA24850@www.tglx.de>
Message-ID: <20110223011412.GD15795@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 06:56:04PM +0100, Sebastian Andrzej Siewior wrote:
> * Sebastian Andrzej Siewior | 2011-01-14 15:31:07 [+0100]:
> 
> >* Ben Dooks | 2011-01-05 20:21:36 [+0000]:
> 
> Hi Ben,
> 
> >[cut]
> >
> >I fixed up all your comments (unless I forgot something by accident). Is
> >it possible for this to go in this merge window or do I have to wait for
> >the next one?
> 
> I've rebased the whole series on top of v2.6.38-rc3. I fixed the
> conflict and considered three new boards (colibri-evalboard, saarb and
> pxa95).

can you repost it then for review please.
 
> The series is available at
>   git://git.linutronix.de/users/bigeasy/soda.git i2c_v3
> 
> Sebastian Andrzej Siewior (6):
>       i2c-pxa2xx: use dynamic register layout
>       ARM: pxa2xx: reorganize I2C files
>       i2c-pxa2xx: Add PCI support for PXA I2C controller
>       i2c-pxa2xx: add support for shared IRQ handler
>       i2c-pxa2xx: check timeout correctly
>       i2c-pxa2xx: pass of_node from platform driver to adapter and publish
> 
>  arch/arm/mach-mmp/include/mach/mmp2.h              |    2 +-
>  arch/arm/mach-mmp/include/mach/pxa168.h            |    2 +-
>  arch/arm/mach-mmp/include/mach/pxa910.h            |    2 +-
>  arch/arm/mach-pxa/balloon3.c                       |    3 +-
>  arch/arm/mach-pxa/cm-x300.c                        |    2 +-
>  arch/arm/mach-pxa/colibri-evalboard.c              |    3 +-
>  arch/arm/mach-pxa/colibri-pxa270-income.c          |    3 +-
>  arch/arm/mach-pxa/corgi.c                          |    2 +-
>  arch/arm/mach-pxa/csb726.c                         |    2 +-
>  arch/arm/mach-pxa/devices.c                        |    2 +-
>  arch/arm/mach-pxa/em-x270.c                        |    2 +-
>  arch/arm/mach-pxa/ezx.c                            |    2 +-
>  arch/arm/mach-pxa/hx4700.c                         |    2 +-
>  arch/arm/mach-pxa/littleton.c                      |    2 +-
>  arch/arm/mach-pxa/magician.c                       |    2 +-
>  arch/arm/mach-pxa/mainstone.c                      |    2 +-
>  arch/arm/mach-pxa/mioa701.c                        |    2 +-
>  arch/arm/mach-pxa/mxm8x10.c                        |    2 +-
>  arch/arm/mach-pxa/palm27x.c                        |    3 +-
>  arch/arm/mach-pxa/pcm990-baseboard.c               |    2 +-
>  arch/arm/mach-pxa/poodle.c                         |    2 +-
>  arch/arm/mach-pxa/pxa27x.c                         |    3 +-
>  arch/arm/mach-pxa/pxa3xx.c                         |    2 +-
>  arch/arm/mach-pxa/pxa95x.c                         |    2 +-
>  arch/arm/mach-pxa/raumfeld.c                       |    2 +-
>  arch/arm/mach-pxa/saar.c                           |    2 +-
>  arch/arm/mach-pxa/saarb.c                          |    3 +-
>  arch/arm/mach-pxa/spitz.c                          |    3 +-
>  arch/arm/mach-pxa/stargate2.c                      |    2 +-
>  arch/arm/mach-pxa/tavorevb3.c                      |    3 +-
>  arch/arm/mach-pxa/tosa.c                           |    2 +-
>  arch/arm/mach-pxa/trizeps4.c                       |    2 +-
>  arch/arm/mach-pxa/viper.c                          |    2 +-
>  arch/arm/mach-pxa/vpac270.c                        |    3 +-
>  arch/arm/mach-pxa/xcep.c                           |    3 +-
>  arch/arm/mach-pxa/z2.c                             |    3 +-
>  arch/arm/mach-pxa/zeus.c                           |    3 +-
>  arch/arm/mach-pxa/zylonite_pxa300.c                |    2 +-
>  drivers/i2c/busses/Kconfig                         |    7 +-
>  drivers/i2c/busses/Makefile                        |    1 +
>  drivers/i2c/busses/i2c-pxa-pci.c                   |  176 ++++++++++++++++++++
>  drivers/i2c/busses/i2c-pxa.c                       |  116 ++++++++++---
>  .../plat/i2c.h => include/linux/i2c/pxa-i2c.h      |    0
>  43 files changed, 310 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-pxa-pci.c
>  rename arch/arm/plat-pxa/include/plat/i2c.h => include/linux/i2c/pxa-i2c.h (100%)
> 
> Sebastian
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
