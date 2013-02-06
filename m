From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 6 Feb 2013 08:33:13 +0000
Subject: [v4 PATCH 00/12] atmel spi controller with dmaengine and device
 tree support
In-Reply-To: <20130205141410.712493E1265@localhost>
References: <1358148877-18679-1-git-send-email-wenyou.yang@atmel.com>
 <20130205141410.712493E1265@localhost>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A086E2E@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Grant

Thanks a lot for your feedback.

> -----Original Message-----
> From: Grant Likely [mailto:glikely at secretlab.ca] On Behalf Of Grant Likely
> Sent: 2013?2?5? 22:14
> To: Yang, Wenyou; linux-arm-kernel at lists.infradead.org
> Cc: richard.genoud at gmail.com; Lin, JM; Ferre, Nicolas;
> linux-kernel at vger.kernel.org; Yang, Wenyou; plagnioj at jcrosoft.com
> Subject: Re: [v4 PATCH 00/12] atmel spi controller with dmaengine and device
> tree support
> 
> On Mon, 14 Jan 2013 15:34:25 +0800, Wenyou Yang
> <wenyou.yang@atmel.com> wrote:
> > Hi All,
> >
> > This set of patches is to add dmaengine and device tree support for atmel spi.
> > The work is based on Nicolas and Richard's work.
> > It is tested on at91sam9x5ek, at91sam9m10g45ek, at91sam9263ek and
> at91sam9g20ek.
> >
> > It is based on v3.8-rc3.
> 
> Hi Wenyou,
> 
> The patches look fine on a quick look, but I cannot apply them without a
> Signed-off-by line from you since you are the person posting the
> patches. Please read section 12 of Documentation/SubmittingPatches
> (about line #288) and then reply confirming what your signed-off-by line
> should be.

Yes, I should add the below lines:
[wenyou.yang at atmel.com: Submit the patch]
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

> 
> >
> > Changelog:
> > v4:
> > 	1./ Take Joe Perches's advance, rewrite atmel_spi_is_v2(struct atmel_spi
> *as)
> > 	     and atmel_spi_use_dma(struct atmel_spi *as),
> > 	     and remove atmel_spi_use_pdc(struct atmel_spi *as).
> >
> > 	2./ Rebase on v3.8-rc3.
> >
> > V3:
> > 	1./ Rebase on v3.8-rc2.
> >
> > 	2./ Remove some Jean-Christophe's patches which has been
> > 	    applied on v3.8-rc2.
> >
> > 	3./ Remove spi property "cs-gpios" from the SoC dtsi files
> > 	    to the board dts files to avoid some useless pin conflicts.
> >
> > v2:
> >    	1./ Remove the patch :PATCH]mtd: m25p80: change the
> m25p80_read to reading page to page
> > 	    which purpose to fix the BUG: when run "flashcp /bin/busybox
> /dev/mtdX" in
> > 	    the at91sam9g25ek with DMA mode, it arises a OOPS.
> > 	    Now fix it in this patch:
> > 	    [PATHC] spi/atmel_spi: add dmaengine support changing to fix the
> [BUG].
> >
> > 	2./ Remove two patches:
> >    	    which purpose to read dts property to select SPI IP version and
> DMA mode
> > 	    Now they will be gat from device tree different compatile.
> >
> > 	3./ Fix DMA: when enable both spi0 AND spi1, the spi0 doesn't work BUG.
> >
> > 	4./ Rebase v3.7-rc8.
> >
> > Best Regards,
> > Wenyou Yang.
> >
> > Nicolas Ferre (5):
> >   spi/atmel_spi: add physical base address
> >   spi/atmel_spi: call unmapping on transfers buffers
> >   spi/atmel_spi: status information passed through controller data
> >   spi/atmel_spi: add flag to controller data for lock operations
> >   spi/atmel_spi: add dmaengine support
> >
> > Richard Genoud (6):
> >   spi/atmel_spi: fix spi-atmel driver to adapt to slave_config changes
> >   spi/atmel_spi: correct 16 bits transfers using PIO
> >   spi/atmel_spi: correct 16 bits transfer with DMA
> >   ARM: at91: add clocks for spi dt entries
> >   ARM: dts: add spi nodes for atmel SoC
> >   ARM: dts: add spi nodes for the atmel boards
> >
> > Wenyou Yang (1):
> >   spi/atmel_spi: update the dt support
> >
> >  arch/arm/boot/dts/at91sam9260.dtsi          |   18 +
> >  arch/arm/boot/dts/at91sam9263.dtsi          |   18 +
> >  arch/arm/boot/dts/at91sam9263ek.dts         |   14 +
> >  arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   14 +
> >  arch/arm/boot/dts/at91sam9g45.dtsi          |   18 +
> >  arch/arm/boot/dts/at91sam9m10g45ek.dts      |   14 +
> >  arch/arm/boot/dts/at91sam9n12.dtsi          |   18 +
> >  arch/arm/boot/dts/at91sam9n12ek.dts         |   14 +
> >  arch/arm/boot/dts/at91sam9x5.dtsi           |   18 +
> >  arch/arm/boot/dts/at91sam9x5ek.dtsi         |   14 +
> >  arch/arm/mach-at91/at91sam9260.c            |    2 +
> >  arch/arm/mach-at91/at91sam9g45.c            |    2 +
> >  arch/arm/mach-at91/at91sam9n12.c            |    2 +
> >  arch/arm/mach-at91/at91sam9x5.c             |    2 +
> >  drivers/spi/spi-atmel.c                     |  809
> ++++++++++++++++++++++++---
> >  15 files changed, 908 insertions(+), 69 deletions(-)
> >
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> --
> Grant Likely, B.Sc, P.Eng.
> Secret Lab Technologies, Ltd.

Best Regards,
Wenyou Yang
