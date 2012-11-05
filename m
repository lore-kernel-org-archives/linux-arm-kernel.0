From: b32955@freescale.com (Huang Shijie)
Date: Mon, 5 Nov 2012 11:16:53 +0800
Subject: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
In-Reply-To: <1351163280.7077.11.camel@vkoul-udesk3>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com>	
 <1351074456-25863-3-git-send-email-b32955@freescale.com>	
 <1351138689.5263.68.camel@vkoul-udesk3> <5088D336.7040206@freescale.com>	
 <1351145272.7077.8.camel@vkoul-udesk3> <5089033F.9040100@freescale.com>
 <1351163280.7077.11.camel@vkoul-udesk3>
Message-ID: <50972FA5.4020605@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?10?25? 19:08, Vinod Koul ??:
> On Thu, 2012-10-25 at 17:15 +0800, Huang Shijie wrote:
>> yes. I have to setup the register. Could you told me which API is the
>> right API?
> dmaengine_slave_config() should be used to send the slave specfic
> parameters
It seems hard to set the registers by the

dmaengine_slave_config().

[1] firstly, there are several drivers use the mxs-dma, the gpmi-nand, mxs-mmc,spi-mxs, i2c-mxs.
        If we set the registers by the dmaengine_slave_config(), we must have the register base address for gpmi, mxs, spi, i2c.
      It's not a good idea to access these registers in the mxs-dma driver.

[2] secondly, take gpmi_read_page() for example, it uses the DMA_TRANS_NONE several times :
     If we set the registers by the dmaengine_slave_config(), the gpmi_read_page() will become like:
     .....................................
     dmaengine_slave_config()
     dmaengine_prep_slave_sg().
     ...................................

     dmaengine_slave_config()
     dmaengine_prep_slave_sg().
     ...................................

      dmaengine_slave_config()
      dmaengine_prep_slave_sg().
     ...................................

     Is it a nice look?

  [3] dma_slave_config{} does not have the fields to contain the registers value.


So I think the  current code it's ok, we'd better do not change it.

thanks
Huang Shijie
