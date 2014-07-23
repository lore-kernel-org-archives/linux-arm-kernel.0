From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 23 Jul 2014 14:15:02 +0200
Subject: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <53CF9933.8030908@gmail.com>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
 <1406103883-3572-2-git-send-email-yao.yuan@freescale.com>
 <20140723114834.411f6bb4@ipc1.ka-ro>
 <b1778af62e7b42b39381fb2699b34eb1@BL2PR03MB338.namprd03.prod.outlook.com>
 <53CF9933.8030908@gmail.com>
Message-ID: <20140723141502.2d726afe@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Varka Bhadram wrote:
> On 07/23/2014 04:41 PM, Yao Yuan wrote:
> > Hi,
> >
> > Thanks for your review.
> >
> > Lothar Wa?mann wrote:
> >> Yuan Yao wrote:
> >>> Add dma support for i2c. This function depend on DMA driver.
> >>> You can turn on it by write both the dmas and dma-name properties in dts node.
> >>>
> >>> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> >>> ---
> >>>   drivers/i2c/busses/i2c-imx.c | 377
> > [...]
> >>> +
> >>> +fail_rx:
> >>> +	dma_release_channel(dma->chan_rx);
> >>> +fail_tx:
> >>> +	dma_release_channel(dma->chan_tx);
> >>> +fail_al:
> >>> +	devm_kfree(dev, dma);
> >>>
> >> No need for this one (that's the whole point of using devm_kzalloc())!
> >>
> > When DMA request failed, I2C will switch to PIO mode. So if the failed reason is just like DMA channel request failed. At this time the DMA should free by devm_kfree(). Is it?
> 
> If probe failed the memory will be freed automatically because
> we are using devm_kzalloc()...
> 
> If we use devm_kzalloc() ,no need to free manually on fail...
> 
Yes, but as Yuan Yao stated, the driver will still work
without DMA but carry around the unecessary allocated imx_i2c_dma
struct.
The devm_kfree() is not in the failure path of the driver's probe()
function, but in the function that tries to initialize the optional DMA
support.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
