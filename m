From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Dec 2014 13:50:52 +0000
Subject: [PATCH 5/8] mfd: Add ST's Low Power Controller driver
In-Reply-To: <2928949.OKYp272uiY@wuerfel>
References: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
 <1418642738-17407-6-git-send-email-lee.jones@linaro.org>
 <2928949.OKYp272uiY@wuerfel>
Message-ID: <20141215135052.GC13885@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Dec 2014, Arnd Bergmann wrote:

> On Monday 15 December 2014 11:25:35 Lee Jones wrote:
> > +       ret = of_property_read_u32(np, "st,lpc-mode", &mode);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "An LPC mode must be selected\n");
> > +               return ret;
> > +       }
> > +
> > +       switch (mode) {
> > +       case ST_LPC_MODE_RTC:
> > +               cell->name = "st-lpc-rtc";
> > +               break;
> > +       case ST_LPC_MODE_WDT:
> > +               cell->name = "st-lpc-wdt";
> > +               break;
> > +       default:
> > +               dev_err(&pdev->dev, "Unsupported mode: %d\n", mode);
> > +               return ret;
> > +       }
> > +
> > +       /* Pass resources though to selected child device. */
> > +       cell->resources = pdev->resource;
> > +       cell->num_resources = pdev->num_resources;
> > +
> > +       ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
> > +                             cell, 1, NULL, 0, NULL);
> > 
> 
> I don't think it's necessary to have the MFD node if only one of the
> two modes can be used based on a DT property. It should be enough
> to have both the rtc and the wdt driver list the same compatible
> string and check the property in the probe function to decide if
> they want to drive the device or not:

I tried that and it didn't work.  Only one driver probed.

> 	ret = of_property_read_u32(np, "st,lpc-mode", &mode);
> 	if (!ret && mode != ST_LPC_MODE_RTC)
> 		return -ENXIO
> 
> 
> 	Arnd

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
