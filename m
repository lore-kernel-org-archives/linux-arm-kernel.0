From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 17 Jan 2015 10:43:58 +0100
Subject: [PATCH] USB: gadget: atmel_usba_udc: Enable/disable USB PLL on
 Vbus change
In-Reply-To: <20150117014231.GW3843@piout.net>
References: <1421446870-26653-1-git-send-email-sylvain.rochet@finsecur.com>
 <20150117014231.GW3843@piout.net>
Message-ID: <20150117104358.0282b27f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 17 Jan 2015 02:42:31 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Hi,
> 
> On 16/01/2015 at 23:21:10 +0100, Sylvain Rochet wrote :
> > Prepare_enable on rising edge, disable_unprepare on falling edge. Reduce
> > power consumption if USB PLL is not already necessary for OHCI or EHCI.
> > If USB host is not connected we can sleep with USB PLL stopped.
> > 
> > This driver does not support suspend/resume yet, not suspending if we
> > are still attached to an USB host is fine for what I need, this patch
> > allow suspending with USB PLL stopped when USB device is not currently
> > used.
> > 
> 
> Same as your previous patch, the maintainers are:
> Felipe Balbi <balbi@ti.com> (maintainer:USB GADGET/PERIPH...)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> 
> 
> > diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> > index ce88237..8ea0a63 100644
> > --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> > +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> > +			ret = clk_prepare_enable(udc->pclk);
> > +			if (ret)
> > +				goto out;
> > +			ret = clk_prepare_enable(udc->hclk);
> > +			if (ret) {
> > +				clk_disable_unprepare(udc->pclk);
> > +				goto out;
> 
> 
> You probably got a warning at some point in time, you can't use
> clk_prepare or clk_unprepare in an irq handler as they may sleep (that
> is exactly the point of having clk_prepare ans clk_enable)
> 
> So, use clk_enable and clk_disable here.

You're right, except that calling enable/disable on the PLL clk in irq
context is pretty much useless since the activation/deactivation code
of the PLL is in prepare/unprepare, so you won't save much power by
doing that (gating the peripheral clk should save a bit though). 

To solve that issue I thought we could move to a threaded_irq (where we
can safely sleep), but you'll also have to take of not calling
prepare/unprepare in sections where at least one spinlock is taken (for
the same reason => you cannot sleep with while you hold spinlocks).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
