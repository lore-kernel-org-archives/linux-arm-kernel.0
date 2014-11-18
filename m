From: yao.yuan@freescale.com (Yao Yuan)
Date: Tue, 18 Nov 2014 06:56:27 +0000
Subject: [PATCH v10 3/3] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <20141117182413.GC12644@katana>
References: <1416220836-7666-1-git-send-email-yao.yuan@freescale.com>
 <1416220836-7666-4-git-send-email-yao.yuan@freescale.com>
 <20141117182413.GC12644@katana>
Message-ID: <BL2PR03MB33898E57AC61B7D45685DCB83880@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for having found the bug, I indeed missed initializing it('orig_jiffies'). 
I will do more detailed review and send the v11 soon.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa at the-dreams.de]
> Sent: Tuesday, November 18, 2014 2:24 AM
> To: Yuan Yao-B46683
> Cc: marex at denx.de; LW at KARO-electronics.de; mark.rutland at arm.com; Duan
> Fugang-B38611; shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; linux-i2c at vger.kernel.org
> Subject: Re: [PATCH v10 3/3] i2c: imx: add DMA support for freescale i2c
> driver
> 
> On Mon, Nov 17, 2014 at 06:40:36PM +0800, Yuan Yao wrote:
> > Add dma support for i2c. This function depend on DMA driver.
> > You can turn on it by write both the dmas and dma-name properties in
> dts node.
> > DMA is optional, even DMA request unsuccessfully, i2c can also work
> well.
> >
> > Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> 
> gcc found a bug:
> 
> drivers/i2c/busses/i2c-imx.c:703:7: warning: 'orig_jiffies' may be used
> uninitialized in this function [-Wuninitialized]
> drivers/i2c/busses/i2c-imx.c:672:16: note: 'orig_jiffies' was declared
> here
> 
> > +	result = wait_for_completion_interruptible_timeout(
> > +				&i2c_imx->dma->cmd_complete,
> > +				msecs_to_jiffies(DMA_TIMEOUT));
> 
> And are you sure you want to use
> wait_for_completion_interruptible_timeout() instead of
> wait_for_completion_timeout() here? Unless you confirm you tested it a
> lot with signals, I really cannot recommend the *_interruptible_* version.
> 
> Other than that, good. I liked the logfile of what you tested very much!
> 
> Thanks,
> 
>    Wolfram
