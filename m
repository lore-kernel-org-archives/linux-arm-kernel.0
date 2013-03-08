From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Mar 2013 12:52:28 +0000
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <3271021.WsP8f9ZEBl@flatron>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <20130307072203.GC3451@avionic-0098.mockup.avionic-design.de>
 <3271021.WsP8f9ZEBl@flatron>
Message-ID: <201303081252.28321.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 March 2013, Tomasz Figa wrote:
> I have a question regarding making this an MFD driver.
> 
> As you know, the main clocksource driver must be initialized early, from 
> init_time callback of machine_desc. How does using the MFD subsystem fit 
> into this scheme?
> 
> P.S. I'm still not convinced about any benefits of options 2 and 3 over 
> option 1, which has the obvious advantage of requiring least amount of 
> changes to existing code and not binding the PWM and clocksource drivers 
> together (on Exynos SoCs only the PWM driver is used, clocksource is 
> handled by different hardware block - MCT).

I think the main motivation for the MFD here is that you have a shared
register set, which would be described as a single device node in DT
as its natural representation, but it's not easy to have two drivers
be responsible for the same platform device. Similarly, the Linux
resource handling tries hard to ensure that multiple device drivers
do not share a single register set.

If you have an MFD driver, that could bind do the platform_device created
from the DT device node, and provide a simple interface for both the
timer and the pwm driver to talk to, without exposing those registers
directly. Or you could use the syscon regmap approach to expose
those registers in a more controlled way. With syscon, you don't actually
have to write an MFD driver but could just use the one that is already
there.

Since you want the timer driver to be available really early, you could
also make that timer driver the master and expose an interface for
the PWM driver to use.

	Arnd
