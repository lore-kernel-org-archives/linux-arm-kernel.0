From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jul 2014 13:34:38 +0200
Subject: [PATCH v3 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140717111912.GA16025@shlinux1.ap.freescale.net>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <5456516.0fVZeXjF8k@wuerfel>
 <20140717111912.GA16025@shlinux1.ap.freescale.net>
Message-ID: <14435027.UvktXyQjy4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 19:19:15 Peter Chen wrote:
> 
> Currently, we are designing a generic driver, we don't know what's the
> hardware architecture, we are trying to find a solution how to set
> dma mask for all possible devices which will use this driver, Antoine's
> this patch is trying to cover this feature.
> 
> For example, 
> 
> Marvell Berlin doesn't need to set dma mask specific.
> http://marc.info/?l=linux-arm-kernel&m=140205228507045&w=2
> http://www.spinics.net/lists/linux-usb/msg110598.html
> 
> Xilinx zynq needs to set dma mask as 0xFFFFFFF0
> http://marc.info/?l=linux-usb&m=140384129921706&w=2
> 
> FSL i.mx needs to set dma mask as DMA_BIT_MASK(32)
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/tree/drivers/usb/chipidea/ci_hdrc_imx.c?h=usb-next

Ok, I see now. I think we can safely drop it completely then:

- Berlin was only recently added and doesn't need to set the
  mask because the common code handles it just fine now.

- i.mx was added earlier, at a time where it was still necessary

- zynq just made a mistake, 0xFFFFFFF0 was never a valid mask
  and just happened to work by accident.

In summary, the 32-bit default mask will work on all of them,
and we need no special code or DT properties for it.

	Arnd
