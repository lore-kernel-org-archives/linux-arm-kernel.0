From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Aug 2011 12:35:52 +0200
Subject: [RFC PATCH 2/2] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <CAGsJ_4ysVs+77Yjgykh_FFKCDpq4OTTbfZYGTHfXQ8W5x2HZXw@mail.gmail.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<201108171348.20378.arnd@arndb.de>
	<CAGsJ_4ysVs+77Yjgykh_FFKCDpq4OTTbfZYGTHfXQ8W5x2HZXw@mail.gmail.com>
Message-ID: <201108181235.53030.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 August 2011, Barry Song wrote:
> >> >
> >> > These functions therefore belong into the rtc_iobrg driver.
> >>
> >> rtc_iobrg might only handle the read/write interfaces and let other
> >> modules call these interfaces to read/write what they want.
> >
> > Every other module calling these interfaces will have the same
> > problem with locking. In cases like this, it's typically better
> > to export a high-level interface from the driver that accesses
> > the registers rather than exporting functions that directly
> > manipulate the registers.
> 
> sorry, i don't understand what you said well. it looks like the
> rtc_iobrg module is providing interfaces to "access" registers not
> "manipulate" registers.

I think the misunderstanding was on my side.

> all registers of devices behind the rtc_iobrg are accessed by:
> sirfsoc_rtc_iobrg_readl()
> sirfsoc_rtc_iobrg_writel()
> they are used to access registers behind rtc_iobrg not in rtc_iobrg.
> rtc, pm module use these functions to read/write their own registers.
> 
> if  RTC/PM modules want a serial of read/write to be atomic, it might
> want to use lock by itself:
> lock()
> ...
> sirfsoc_rtc_iobrg_readl(reg1)
> sirfsoc_rtc_iobrg_readl(reg2)
> 
> sirfsoc_rtc_iobrg_writel(val1, reg1)
> sirfsoc_rtc_iobrg_writel(val2, reg2)
> ...
> unlock()

Right.

> rtc_iobrg only provide interface to read/write devices behind the
> bridge, it doesn't care about how and what other modules want to
> read/write.
> 
> anyway, i don't understand your meaning well, would you like to
> present some pseudo codes?

Looking at it again, it seems fine. There are a few details that
I would change though:

* Use EXPORT_SYMBOL_GPL, not EXPORT_SYMBOL

* As pointed out in my first comment on this patch, I still think
  it should be a platform_driver. However, I would not mark the
  rtc_iobrg as "simple_bus" in the device tree, to avoid automatically
  creating the platform devices for the nodes below it. The from the
  ->probe callback of the rtc_iobrg, you create the child devices
  from the device tree using of_platform_bus_probe().

	Arnd
