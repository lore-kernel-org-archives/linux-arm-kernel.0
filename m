From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Aug 2011 08:47:43 +0200
Subject: [PATCH 3/3] dmaengine i.MX SDMA: use request_firmware_nowait
In-Reply-To: <1314295317.1606.90.camel@vkoul-udesk3>
References: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
	<1314263017-18099-4-git-send-email-s.hauer@pengutronix.de>
	<1314295317.1606.90.camel@vkoul-udesk3>
Message-ID: <20110826064743.GA31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 11:31:57PM +0530, Koul, Vinod wrote:
> On Thu, 2011-08-25 at 11:03 +0200, Sascha Hauer wrote:
> > The firmware blob may not be available when the driver
> > probes. Instead of blocking the whole kernel use
> > request_firmware_nowait() and continue without firmware.
> > The ROM scripts can already be used then if available.
> > For the devicetree case the ROM scripts are not available,
> > still the probe function should not block. The driver
> > will be unusable in this case, but we have no way of
> > detecting this properly. The configuration of the dma
> > channels will fail, so nothing bad should happen.
> Shouldn't you track if firmware is loaded properly and in the case it is
> not return error in your prepare functions?

Parts of the firmware is in ROM, enough to handle many transfer
types. The RAM firmware only offers additional transfer types.
Which transfer types are available is tracked in sdma->script_addrs.
The firmware loader just adds values here. The DMA_SLAVE_CONFIG
call will fail if a needed piece of firmware is missing.

Sascha

> --
> ~Vinod
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/dma/imx-sdma.c |   23 ++++++++++++++++-------
> >  1 files changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 8abf8c1..b5cc27d 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -1143,18 +1143,17 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
> >  			saddr_arr[i] = addr_arr[i];
> >  }
> >  
> > -static int __init sdma_get_firmware(struct sdma_engine *sdma,
> > -		const char *fw_name)
> > +static void sdma_load_firmware(const struct firmware *fw, void *context)
> >  {
> > -	const struct firmware *fw;
> > +	struct sdma_engine *sdma = context;
> >  	const struct sdma_firmware_header *header;
> > -	int ret;
> >  	const struct sdma_script_start_addrs *addr;
> >  	unsigned short *ram_code;
> >  
> > -	ret = request_firmware(&fw, fw_name, sdma->dev);
> > -	if (ret)
> > -		return ret;
> > +	if (!fw) {
> > +		dev_err(sdma->dev, "firmware not found\n");
> > +		return;
> > +	}
> >  
> >  	if (fw->size < sizeof(*header))
> >  		goto err_firmware;
> > @@ -1184,6 +1183,16 @@ static int __init sdma_get_firmware(struct sdma_engine *sdma,
> >  
> >  err_firmware:
> >  	release_firmware(fw);
> > +}
> > +
> > +static int __init sdma_get_firmware(struct sdma_engine *sdma,
> > +		const char *fw_name)
> > +{
> > +	int ret;
> > +
> > +	ret = request_firmware_nowait(THIS_MODULE,
> > +			FW_ACTION_HOTPLUG, fw_name, sdma->dev,
> > +			GFP_KERNEL, sdma, sdma_load_firmware);
> >  
> >  	return ret;
> >  }
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
