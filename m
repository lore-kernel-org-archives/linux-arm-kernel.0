From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 19:47:13 +0200
Subject: [Patch v3 0/5] Introduce keystone reset driver
In-Reply-To: <537A1E2C.8040102@ti.com>
References: <1400495155-11136-1-git-send-email-ivan.khoronzhuk@ti.com>
 <537A1E2C.8040102@ti.com>
Message-ID: <5095812.b6DgWAxYzH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 May 2014 11:07:24 Santosh Shilimkar wrote:
> On Monday 19 May 2014 06:25 AM, Ivan Khoronzhuk wrote:
> > These patches introduce keystone reset driver.
> > 
> > The keystone SoC can be rebooted in several ways. By external reset
> > pin, by soft and by watchdogs. This driver allows software reset and reset
> > by one of the watchdogs. Also added opportunity to set soft/hard reset type.
> > 
> > Based on v3.15-rc5
> > 
> Arnd,
> Can I have have your ack/reviewed-by please since you did gave few comments
> on previous version.

Sorry for not getting back to you earlier on this topic.

> On 04/14/2014 09:44 PM, Arnd Bergmann wrote:
> > On Monday 14 April 2014 20:41:20 Ivan Khoronzhuk wrote:
> >> +Optional properties:
> >> +
> >> +- ti,soft-reset:       Boolean option indicating soft reset.
> >> +                       By default hard reset is used.
> >> +
> >> +- ti,wdt_list:         WDT list that can cause SoC reset.
> >> +                       The list in format: <0>, <2>;
> >> +                       Begins from 0 to 3, as keystone can contain up
> >> +                       to 4 SoC reset watchdogs.
> > 
> > This looks like your binding just describes a subset of the
> > watchdog timer registers. If so, don't do a standalone reset
> 
> The registers are not a subset of watchdog hardware it's SoC specific future
> controlled by SoC specific registers (bootregs and PLL regs).
> 
> For watchog IP setup, the Keystone uses the watchdog driver common with
> other
> SoCs -- davinci_watchdog that is not depend on other SoC settings like
> this driver does.
> 
> The Keystone SoCs have separate registers to tune Keystone2 reset
> functionality
> by configuring Reset multiplexer &  PLL. And it tunes not only watchdog
> usage.
> The keystone SoC can be rebooted in several ways. By external reset pin,
> by soft and
> by watchdogs. This driver allows software reset or reset by one of the
> watchdogs
> (and other settings) independently on watchdog driver settings. This is
> job of reset driver.

It sounds like you use a syscon area in the reset driver. This is not
uncommon, but it means you should probably have a generic node for
the SoC specific registers that contains all of them at once and
exports them as a regmap using the drivers/mfd/syscon.c driver.

	Arnd
