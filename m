From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Oct 2012 06:29:57 +0000
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121009225837.GA7758@glitch>
References: <20121007015300.828366635@gmail.com>
 <201210090918.56725.arnd@arndb.de> <20121009225837.GA7758@glitch>
Message-ID: <201210100629.58272.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 October 2012, Domenico Andreoli wrote:
> bcm4760 is the superset (bcm4761 hasn't the gpu) but there are also other
> differences (that I know, USB phy and clocks).
> 
> I can identify the SoC at runtime, does this change anything to your
> recommendation?

Not much. The rule not to have wildcards in the device tree strings
is rather universal. For device drivers, the rule should be that the
driver should only look at its own device and the information it can
get about that from the bus (or from the device tree), but should
generally not use interfaces to ask what soc the device is part of.

Otherwise you end up having to modify all device drivers every time
you want to support a new SoC, which is something we want to avoid.
If a new SoC contains some device that is identical to one on an
older SoC, you should just be able to mark it as compatible with the
original string in the device tree.

For the USB PHY and the clock setup, it should be very easy to use
different compatible strings, although for the clock controller it
may also be reasonable to call the initialization function from
platform code and pass the type of controller into it. It may also
be possible that all the differences between the clock implementations
go away once you describe all clocks in the DT itself.

	Arnd
