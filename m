From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 13 May 2015 12:44:54 -0700
Subject: [PATCH v2 1/3] input: keyboad: imx: add snvs power key driver
In-Reply-To: <CAHrpEqQ2a8uHZm9+eVjB=fFHrNwo6rf5G4WKA4fX_UiA=QteCw@mail.gmail.com>
References: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
 <20150513164020.GA11891@dtor-ws>
 <CAHrpEqRKX_oqT9JKc7=m1Okbq1_30GQOwR_nGPn6aALq2D_-Sw@mail.gmail.com>
 <2698983.zamV244jo6@jclayton-pc>
 <CAHrpEqQ2a8uHZm9+eVjB=fFHrNwo6rf5G4WKA4fX_UiA=QteCw@mail.gmail.com>
Message-ID: <20150513194454.GD11891@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 02:27:46PM -0500, Zhi Li wrote:
> On Wed, May 13, 2015 at 2:10 PM, Joshua Clayton
> <stillcompiling@gmail.com> wrote:
> >
> > Hi Frank.
> >
> > On Wednesday, May 13, 2015 01:27:39 PM Zhi Li wrote:
> >> On Wed, May 13, 2015 at 11:40 AM, Dmitry Torokhov
> >>
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > Hi Frank,
> >> >
> >
> >> >
> >> >> +     pdata->ioaddr = of_iomap(np, 0);
> >> >> +     if (IS_ERR(pdata->ioaddr))
> >> >> +             return PTR_ERR(pdata->ioaddr);
> >> >
> >> > Umm, you are still leaking it on error path. Can you try doing:
> >> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> >         pdata->ioaddr = devm_ioremap_resource(&pdev->dev, res);
> >> >         if (IS_ERR(pdata->ioaddr))
> >> >
> >> >                 return PTR_ERR(pdata->ioaddr);
> >>
> >> Thank you for comments.
> >> but I don't use of_iomap here because the resource is shared with the
> >> other device.
> >>
> >> SNVS included a rtc, a power off, ON/OFF key.
> >> If I use platform_get_resource and devm_ioremap_resource, rtc driver
> >> fail to probe.
> >>
> >> best regards
> >> Frank Li
> >>
> >
> > The fact that you cannot use of_iomap() seems a clear warning of unsafe
> > access.
> > Since it is a shared resource, which you are writing to as well as reading,
> > perhaps you should set it up for safe access using the  regmap API like the
> > GPR registers.
> > /include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> 
> I read driver again clearfully. It is safed shared with rtc driver directly.
> Because pwr key driver just read a irq status register and other one
> register, which used only in this driver.
> 
> Just w1c (write 1 clear) register. it is atomic access by hardware.

It does not really matter, driver has to claim resources it is using to
make sure other parties are not accessing its registers. If registers
are shared you need to have a 3rd party mediator.

> 
> PowerKey use difference irq number with RTC part.

Yes and so they can run simultaneously and step on each other's feet,
right?

Thanks.

-- 
Dmitry
