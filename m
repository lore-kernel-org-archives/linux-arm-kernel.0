From: padma.kvr@gmail.com (padma venkat)
Date: Fri, 1 Jul 2011 09:05:41 +0530
Subject: [PATCH 0/7] ARM: SAMSUNG: Cleanup SPI platform specific code
In-Reply-To: <005701cc3707$aa914e50$ffb3eaf0$%szyprowski@samsung.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
	<005701cc3707$aa914e50$ffb3eaf0$%szyprowski@samsung.com>
Message-ID: <BANLkTi=awBjrOugA6tp+Z47Y8A=eMhOrjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Jun 30, 2011 at 2:55 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Thursday, June 30, 2011 2:25 PM Padmavathi Venna wrote:
>
>> This patchset does the following:
>>
>> 1. Move duplicated code to common place
>> [PATCH 1/7] ARM: SAMSUNG: Move SPI device definitions to plat-samsung
>> SPI platform devices are defined in respective machine folder of
>> Samsung S3C64XX and S5P series SoCs.This is duplicated for every SoC.
>> So all SPI platform devices are moved to a common place.
>>
>> [PATCH 2/7] ARM: SAMSUNG: Define common macro for SPI physical address
>>
>> [PATCH 3/7] ARM: SAMSUNG: Add SPI clock definitions for SAMSUNG SoCs
>> Each SoC has it's own set of clock sources for SPI.So they are defined in
>> respective machine folder.
>>
>> [PATCH 4/7] ARM: SAMSUNG: Create SPI device setup files in
>> respective machine folder
>>
>> [PATCH 5/7] ARM: SAMSUNG: Add SPI platform specific code
>> As SPI platform devices are moved to common place some platform specific
>> code need to be initialized in the respective machine file.
>>
>> [PATCH 6/7] SPI: S5PC100: Enable the SPI driver for S5PC100
>>
>> [PATCH 7/7] SPI: S5PV210: Enable the SPI driver for S5PV210
>
> These patch set improves a bit platform part of SPI driver, but I really
> wonder if we really need to pass so many SoC version specific data
> with platform data. Are all these data (clock list, fifo parameters)
> specific to SoC version or particular board configuration/implementation?
>
> Maybe it will be much easier to convert the SPI driver to use driver id
> feature and use different platform id's for each SoC version? (please
> refer to drivers/video/s3c-fb.c and plat-samsung/include/plat/fb-core.h
> for more information). This will remove the need for SoC specific
> parameters in platform data and will group all version dependent
> information in the driver.

Thanks for your suggestion. I will consider your comments for the
next patch set based on clkdev code.

Thanks&Regards
Padma
>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.4.1309855788.20020.linux-arm-kernel@lists.infradead.org>

- Rebased on v3.0-rc5
- Rename gic_ppi_to_vppi() to gic_ppi_map()
- Rename CONFIG_ARM_GIC_VPPI to CONFIG_ARM_GIC_PPI_MAP
- Add gic_ppi_map_on_cpu()


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.5.1309855789.20020.linux-arm-kernel@lists.infradead.org>

- Fix compilation when !CONFIG_PM.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.6.1309855789.20020.linux-arm-kernel@lists.infradead.org>

- Update Exynos4 MCT to use the local timer infrastructure, now that
  it doesn't depend on PPIs anymore. Untested, as the board I have
  doesn't implement MCT (EVT0 syndrome).


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.7.1309855789.20020.linux-arm-kernel@lists.infradead.org>

- Fix arch/arm/common/Kconfig indentation
- Fix MSM warning when building UP.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.8.1309855789.20020.linux-arm-kernel@lists.infradead.org>

- Fix yet another CPU_HOTPLUG problem: instead of calling free_irq()
  on timer halt, just disable the interrupt. On timer restart, detect
  that the interrupt has been requested already and just enable the
  interrupt back. This avoid doing a request_irq() with preemption
  disabled, which triggers an ugly warning. Reported by Stephen Boyd.


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.9.1309855789.20020.linux-arm-kernel@lists.infradead.org>

- More MSM fixes
- Dropped MSM interrupt handler removal, as this requires more discussion,
  and will be addressed in a separate series.
- Moved introduction of percpu_timer_handler to a separate patch


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.10.1309855789.20020.linux-arm-kernel@lists.infradead.org>

- Fix crash while hotpluging a CPU
- Use handle_percpu_irq() instead of handle_fasteoi_irq()
- MSM fixes courtesy of Stephen Boyd
- MSM switched to percpu_timer_handler()
- Remove local timer interrupt accounting
- Restructure patches #1 and #2

Marc Zyngier (14):
  ARM: gic: add per-cpu interrupt mapping
  ARM: smp: add interrupt handler for local timers
  ARM: smp_twd: add support for remapped PPI interrupts
  ARM: omap4: use remapped PPI interrupts for local timer
  ARM: versatile: use remapped PPI interrupts for local timer
  ARM: shmobile: use remapped PPI interrupts for local timer
  ARM: ux500: use remapped PPI interrupts for local timer
  ARM: tegra: use remapped PPI interrupts for local timer
  ARM: msm: use remapped PPI interrupts for local timer
  ARM: exynos4: use remapped PPI interrupts for local timer
  ARM: gic: remove previous local timer interrupt handling
  ARM: gic: add compute_irqnr macro for exynos4
  ARM: SMP: automatically select ARM_GIC_PPI_MAP
  ARM: gic: add gic_ppi_map_on_cpu()

 arch/arm/Kconfig                                  |    1 +
 arch/arm/common/Kconfig                           |    5 +
 arch/arm/common/gic.c                             |  152 +++++++++++++++++=
++--
 arch/arm/include/asm/entry-macro-multi.S          |    7 -
 arch/arm/include/asm/hardirq.h                    |    3 -
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   31 ++---
 arch/arm/include/asm/hardware/gic.h               |   11 ++-
 arch/arm/include/asm/localtimer.h                 |    7 +-
 arch/arm/include/asm/smp.h                        |    5 -
 arch/arm/kernel/irq.c                             |   11 +-
 arch/arm/kernel/smp.c                             |   27 +---
 arch/arm/kernel/smp_twd.c                         |   25 +++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |   70 +---------
 arch/arm/mach-exynos4/localtimer.c                |    3 +-
 arch/arm/mach-msm/board-msm8x60.c                 |   11 --
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +----------
 arch/arm/mach-msm/timer.c                         |   58 ++++----
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
 arch/arm/mach-omap2/timer-mpu.c                   |    3 +-
 arch/arm/mach-shmobile/entry-intc.S               |    3 -
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
 arch/arm/mach-shmobile/localtimer.c               |    3 +-
 arch/arm/mach-tegra/localtimer.c                  |    3 +-
 arch/arm/mach-ux500/localtimer.c                  |    3 +-
 arch/arm/plat-versatile/localtimer.c              |    3 +-
 25 files changed, 253 insertions(+), 282 deletions(-)




>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.12.1309969792.20020.linux-arm-kernel@lists.infradead.org>

this in Mainline versions. I think we have to do something.

Maybe we can handle this in a way that when no bad block table is
present we create one with the correct values? This way we could
eliminate the problem at least on boards with virgin flashes.

This whole topic totally sucks. Whatever we do now we end up with
corrupted flashes in one way or the other.

BTW the Bootrom code expects non swapped flash layout, so applying
a swap patch makes it impossible to update the bootloader in NAND.
Maybe that's the reason the FSL code has this disable_bi_swap sysfs
attribute in it.

Not calling this a bug makes me think you work for the Freescale
marketing department ;)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


>From bogus@does.not.exist.com  Mon Jun 27 16:47:34 2011
From: bogus@does.not.exist.com ()
Date: Mon, 27 Jun 2011 20:47:34 -0000
Subject: No subject
Message-ID: <mailman.16.1310115268.20020.linux-arm-kernel@lists.infradead.org>

- Interrupt controller sort function
- Bug fixes
- Added documentation

Marc Zyngier (4):
  dt: expose device resource allocator
  Core device subsystem implementation
  Core devices: add OF interrupt controller sorting method
  Core devices: documentation

 Documentation/core_devices.txt    |  247 +++++++++++++++++++++++++++++++++=
++++
 arch/arm/kernel/vmlinux.lds.S     |    1 +
 drivers/base/Makefile             |    3 +-
 drivers/base/core_device.c        |  217 ++++++++++++++++++++++++++++++++
 drivers/of/platform.c             |   60 ++++++---
 include/asm-generic/vmlinux.lds.h |    6 +
 include/linux/core_device.h       |   71 +++++++++++
 include/linux/of_platform.h       |    2 +
 8 files changed, 587 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/core_devices.txt
 create mode 100644 drivers/base/core_device.c
 create mode 100644 include/linux/core_device.h
