From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Thu, 16 Dec 2010 14:57:46 +0530
Subject: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
In-Reply-To: <87d3p3kobt.fsf@deeprootsystems.com>
References: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
	<87d3p3kobt.fsf@deeprootsystems.com>
Message-ID: <AANLkTikgzMjU9wfzzMjEXzFCUvRz6hKtv=N8dKXf10YM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,


On Wed, Dec 15, 2010 at 9:42 PM, Kevin Hilman
<khilman@deeprootsystems.com>wrote:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
> > Changes invloves:
> > ----------------
> > 1) Addition of hwmod data for omap2/3/4.
> > 1) McSPI driver hwmod adaptation with cleanup of base address
> >    macros and using omap-device API's.
> > 2) Runtime Conversion of McSPI driver
> >
> > Changes from v1:
> > ---------------
> > 1) Fixing patch 5/5 comments for hwmod+runtime
> >    Split the patch 5/5 to hwmod adaptation
> >    and then runtime conversion
> >    http://www.mail-archive.com/linux-omap at vger.kernel.org/msg33387.html
> >
> > Testing Updates:
> > ----------------
> > Was tested using data transfer test module available at:
> >
> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/test_code/
> > utils/mcspi_modules/omap_mcspi_datatest.c;
> > h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
> > hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3
>
> Can you summarize what this test does?
>
> On what platforms was this tested?
>
> How was it tested for OMAP1 and OMAP2?
>


Using the above mentioned test module we had done some
data transfer tests.
Platforms used used where :
1) OMAP2430 SDP.
2) OMAP3 (ZOOM boards zoom2/3).
3) OMAP4430 SDP [ Here even basic Ethernet functionality was checked which
is over SPI interface]
We boot tested on 2420/n800.

Coming to omap1,

This driver[omap2_mcspi.c] is applicable only from omap2_plus
for omap1 omap_uwire.c is the spi driver file.

Looking into the driver/spi/Kconfig and Makefile:

<KCONFIG SNIP>

config SPI_OMAP_UWIRE
        tristate "OMAP1 MicroWire"
        depends on ARCH_OMAP1

config SPI_OMAP24XX
        tristate "McSPI driver for OMAP"
        depends on ARCH_OMAP2PLUS

<MAKEFILE SNIP>

obj-$(CONFIG_SPI_OMAP_UWIRE)            += omap_uwire.o
obj-$(CONFIG_SPI_OMAP24XX)              += omap2_mcspi.o


---
Thanks,
Govindraj.R



>
> Kevin
>
> > System wide suspend and ret/off counts observation,
> > ensured that no behavioral difference with and without
> > this patch series.
> >
> > Benoit Cousson (1):
> >   OMAP4: hwmod data: Add McSPI
> >
> > Charulatha V (5):
> >   OMAP2420: hwmod data: Add McSPI
> >   OMAP2430: hwmod data: Add McSPI
> >   OMAP3: hwmod data: Add McSPI
> >   OMAP3: clocks: Update clock domain name for mcspi fck
> >   OMAP: devices: Modify McSPI device to adapt to hwmod framework
> >
> > Govindraj.R (1):
> >   OMAP: runtime: McSPI driver runtime conversion
> >
> >  arch/arm/mach-omap2/clock3xxx_data.c       |    4 +
> >  arch/arm/mach-omap2/devices.c              |  189 ++++---------------
> >  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  156 ++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_2430_data.c |  219 ++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  280
> ++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  267
> ++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/mcspi.h    |   11 +
> >  drivers/spi/omap2_mcspi.c                  |  225 +++++++---------------
> >  8 files changed, 1051 insertions(+), 300 deletions(-)
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101216/769ab2b9/attachment-0001.html>
