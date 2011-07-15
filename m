From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Jul 2011 09:32:50 +0200
Subject: [PATCH 2/2] dmaengine: imx-sdma: add device tree probe support
In-Reply-To: <20110715025413.GJ2927@ponder.secretlab.ca>
References: <1310660057-17953-1-git-send-email-shawn.guo@linaro.org>
	<1310660057-17953-3-git-send-email-shawn.guo@linaro.org>
	<20110715025413.GJ2927@ponder.secretlab.ca>
Message-ID: <20110715073250.GH6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 08:54:13PM -0600, Grant Likely wrote:
> On Fri, Jul 15, 2011 at 12:14:17AM +0800, Shawn Guo wrote:
> > It adds device tree probe support for imx-sdma driver.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   55 ++++++++++++++++++++
> >  drivers/dma/imx-sdma.c                             |   29 +++++++++-
> >  2 files changed, 81 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> > new file mode 100644
> > index 0000000..71f4525
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> > @@ -0,0 +1,55 @@
> > +* Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,<chip>-sdma"
> > +- reg : Should contain SDMA registers location and length
> > +- interrupts : Should contain SDMA interrupt
> > +- fsl,sdma-script-name : Should contain the full path of SDMA RAM scripts
> > +  firmware
> > +- fsl,sdma-script-address : Should be an array giving entry address for each
> > +  script.  The address should be 0 in case that the specified script is not
> > +  included in the firmware.  See example below for the array details.
> > +
> > +Examples:
> > +
> > +sdma at 83fb0000 {
> > +	compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
> > +	reg = <0x83fb0000 0x4000>;
> > +	interrupts = <6>;
> > +	fsl,sdma-script-name = "sdma-imx51.bin";
> > +	fsl,sdma-script-address = <642>,	/* ap_2_ap */
> > +				  <0>,		/* ap_2_bp */
> > +				  <0>,		/* ap_2_ap_fixed */
> > +				  <0>,		/* bp_2_ap */
> > +				  <0>,		/* loopback_on_dsp_side */
> > +				  <0>,		/* mcu_interrupt_only */
> > +				  <0>,		/* firi_2_per */
> > +				  <0>,		/* firi_2_mcu */
> > +				  <0>,		/* per_2_firi */
> > +				  <0>,		/* mcu_2_firi */
> > +				  <0>,		/* uart_2_per */
> > +				  <817>,	/* uart_2_mcu */
> > +				  <0>,		/* per_2_app */
> > +				  <747>,	/* mcu_2_app */
> > +				  <0>,		/* per_2_per */
> > +				  <0>,		/* uartsh_2_per */
> > +				  <0>,		/* uartsh_2_mcu */
> > +				  <0>,		/* per_2_shp */
> > +				  <961>,	/* mcu_2_shp */
> > +				  <1473>,	/* ata_2_mcu */
> > +				  <1392>,	/* mcu_2_ata */
> > +				  <1033>,	/* app_2_per */
> > +				  <683>,	/* app_2_mcu */
> > +				  <1251>,	/* shp_2_per */
> > +				  <892>,	/* shp_2_mcu */
> > +				  <0>,		/* mshc_2_mcu */
> > +				  <0>,		/* mcu_2_mshc */
> > +				  <0>,		/* spdif_2_mcu */
> > +				  <0>,		/* mcu_2_spdif */
> > +				  <0>,		/* asrc_2_mcu */
> > +				  <0>,		/* ext_mem_2_ipu */
> > +				  <0>,		/* descrambler */
> > +				  <0>,		/* dptc_dvfs */
> > +				  <0>,		/* utra_addr */
> > +				  <0>;		/* ram_code_start */
> 
> This looks icky.  Where do these numbers come from?  How are the
> offsets loaded into ram?  Are they properties of the firmware blob?
> If so, then maybe they should be embedded in the firmware blob instead
> of encoded in a DT that may become out of sync.

They are embedded in the firmware blob already and the current dma
driver uses these values to initialize the script addresses.

The SDMA firmware is split into two parts, one in an internal ROM
and one in RAM. So it's possible to run the SDMA engine (with limited
functionality) without an external firmware blob. The ROM addresses are currently contained
in platform_data. Don't know if it makes sense to move them to the
device tree though.

(That said, the current implementation of the SDMA driver does not
work without external firmware, but this is a software issue only)

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
