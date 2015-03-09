From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 21:05:02 +0100
Subject: [PATCH] iio: ak8975: fix AK09911 dependencies
In-Reply-To: <54FD7AF2.8020605@kernel.org>
References: <7968545.0Cq9DcaG85@wuerfel>
 <CAMuHMdU9x_OUReNMdZx+urZE3FDx2qz1m6gDRVp8qJ0r_QF5tA@mail.gmail.com>
 <54FD7AF2.8020605@kernel.org>
Message-ID: <3043946.mVD7WvMa1C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015 10:50:26 Jonathan Cameron wrote:
> >> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> >> index 4c7a4c52dd06..a5d6de72c523 100644
> >> --- a/drivers/iio/magnetometer/Kconfig
> >> +++ b/drivers/iio/magnetometer/Kconfig
> >> @@ -18,6 +18,8 @@ config AK8975
> >>
> >>  config AK09911
> >>         tristate "Asahi Kasei AK09911 3-axis Compass"
> >> +       depends on I2C
> >> +       depends on GPIOLIB
> >>         select AK8975
> >>         help
> >>           Deprecated: AK09911 is now supported by AK8975 driver.
> > 
> > I just saw the AK8975/AK09911 config options disappear for a v4.0-rc3 m68k
> > allmodconfig kernel. Apparently it built fine with !GPIOLIB before, as many
> > gpiolib (consumer) functions have dummies for the !GPIOLIB case.
> > 
> > So I think the GPIOLIB dependency can be relaxed to "GPIOLIB || COMPILE_TEST".
> > The same may be true for many other GPIOLIB consumer drivers.
> > Will look into it and send patches...

The reason for this dependency is the 'select AK8975', which causes a Kconfig
warning if GPIOLIB is disabled. I do not see an actual dependency on gpiolib
in the ak8975 driver, but relaxing this means we have to remove the dependency
for both of them together, not just for AK09911.

	Arnd
