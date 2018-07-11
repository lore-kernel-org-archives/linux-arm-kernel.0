From: vkoul@kernel.org (Vinod)
Date: Wed, 11 Jul 2018 14:28:06 +0530
Subject: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
In-Reply-To: <DB6PR04MB3223D27E2BCA6A235733CEA5895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
 <20180710153326.GG3219@vkoul-mobl>
 <DB6PR04MB3223F93E1566A97857FD2FF4895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <20180711065338.3ka4yibxkawgo4fd@pengutronix.de>
 <20180711071905.GN3219@vkoul-mobl>
 <DB6PR04MB3223D27E2BCA6A235733CEA5895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <20180711085806.GP3219@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-07-18, 08:16, Robin Gong wrote:

> > > The problem seems to be that we do not know whether we are doing
> > > memcpy or not. Normally we get the information how a channel is to be
> > > configured in dma_device->device_config, but this function is not
> > > called in the memcpy case.
> > 
> > Not really true, device_config only provides parameters to be configured for
> > next slave transaction
> > 
> > > An alternative might also be to do the setup in
> > dma_device->device_prep_dma_memcpy.
> > 
> > Precisely, see how other drivers do this
> > 
> > Let's roll back a bit and foresee why is this required.
> > 
> > In case of memcpy, you need to tell DMA to do transfer from src to dstn and
> > size. Additional parameters like buswidth etc should be derived for maximum
> > throughput (after all we are dma, people want it to be done
> > fastest)
> > 
> > Now for slave, you are interfacing with a peripheral and don't know how that is
> > setup. So you need to match the parameters, otherwise you get overflow or
> > underflow and hence need for device_config
> > 
> > Please do not derive additional notions from these, please do not assume
> > anything else, unless provided in documentation :)
> I will move such prepare jobs from slave_config to device_prep_dma_memcpy
> Instead of device_alloc_chan_resources as I did in v1, thus we have no 'chan->private'
> issue, just like drivers/dma/stm32-mdma.c. The only limitation is those prepare jobs
> (some register setting) will be done every time memcpy instead of only one time in slave_config
> or v1 case. Is that ok?

sounds fine to me

-- 
~Vinod
