From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Jan 2015 20:42:28 +0100
Subject: [PATCH 4/6] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
In-Reply-To: <CAL85gmCOXKiHEO=URrAGBNZpJpen5P5PH1xDoF1-jasj0iDg4Q@mail.gmail.com>
References: <1412726809-7525-1-git-send-email-fkan@apm.com>
 <1894616.4yY7dajl4R@wuerfel>
 <CAL85gmCOXKiHEO=URrAGBNZpJpen5P5PH1xDoF1-jasj0iDg4Q@mail.gmail.com>
Message-ID: <15808906.L2zUs54agU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 January 2015 10:56:51 Feng Kan wrote:
> On Tue, Nov 11, 2014 at 1:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 07 October 2014 17:06:47 Feng Kan wrote:
> >> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> >> index 2e45ae3..a03042c 100644
> >> --- a/drivers/i2c/busses/Kconfig
> >> +++ b/drivers/i2c/busses/Kconfig
> >> @@ -1009,6 +1009,15 @@ config I2C_CROS_EC_TUNNEL
> >>         connected there. This will work whatever the interface used to
> >>         talk to the EC (SPI, I2C or LPC).
> >>
> >> +config I2C_XGENE_SLIMPRO
> >> +     tristate "APM X-Gene SoC I2C SLIMpro devices support"
> >> +     depends on ARCH_XGENE && XGENE_SLIMPRO_MBOX
> >
> > Why this dependency on XGENE_SLIMPRO_MBOX?
> >
> > Better replace it with a dependency on MAILBOX.
> Arnd, just a question. Is this because this possibly help with future
> compatibility by choosing a more broad dependency?

The dependency should ideally describe build-time dependencies,
to make it possible to build on other architectures for static
code analysis purposes. If the driver makes no sense on other
platforms you can also use

	depends on ARCH_XGENE || COMPILE_TEST
	depends on MAILBOX

to cover both the build-time and run-time dependencies. But the
dependency on XGENE_SLIMPRO_MBOX just shouldn't be there, the driver
will work with any mailbox implementation if someone puts the same
hardware into a different SoC.

	Arnd
