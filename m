From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 17 Jul 2014 19:19:15 +0800
Subject: [PATCH v3 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <5456516.0fVZeXjF8k@wuerfel>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <22032517.gk8PRUMaIU@wuerfel>
 <93903d5fdf85427bb8a418894540c122@BN1PR0301MB0772.namprd03.prod.outlook.com>
 <5456516.0fVZeXjF8k@wuerfel>
Message-ID: <20140717111912.GA16025@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:21:56PM +0200, Arnd Bergmann wrote:
> On Thursday 17 July 2014 01:20:54 Peter Chen wrote:
> > Thanks, arnd.
> > 
> > For chipidea generic glue layer case, if there are three devices who use this
> > driver, and all devices have 32-bit bus, some devices have less 32 address lines.
> > For example:
> > 
> > - the device_a doesn't need to use dma_mask
> > - the device_b needs dma_mask as 0xfffffffff
> > - the device_c needs dma_mask as 0xfffffff0, assume it has only 28 address lines
> 
> This makes no sense. You always need a dma mask, so the first case doesn't exist,
> and the second one is the default.
> 
> In the third case, I assume you mean 0x0fffffff, which is a 28-bit mask.
> 
> > My questions are:
> > - Can we not set dma_mask at driver, and only set dma-ranges at dts for device_b
> > and device_c as a solution to cover this different dma mask use case?
> 
> try to understand my earlier reply. What is the problem with device_b?
> Is that a limitation of the bus it is connected to, or the version of the
> chipidea hardware?
> 
> > - If we can't use this solution, would you suggest one?
> 
> It depends on what the requirement of the hardware is, as I explained
> now for three times.
> 

Thanks, Arnd.

Currently, we are designing a generic driver, we don't know what's the
hardware architecture, we are trying to find a solution how to set
dma mask for all possible devices which will use this driver, Antoine's
this patch is trying to cover this feature.

For example, 

Marvell Berlin doesn't need to set dma mask specific.
http://marc.info/?l=linux-arm-kernel&m=140205228507045&w=2
http://www.spinics.net/lists/linux-usb/msg110598.html

Xilinx zynq needs to set dma mask as 0xFFFFFFF0
http://marc.info/?l=linux-usb&m=140384129921706&w=2

FSL i.mx needs to set dma mask as DMA_BIT_MASK(32)
https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/tree/drivers/usb/chipidea/ci_hdrc_imx.c?h=usb-next

-- 

Best Regards,
Peter Chen
