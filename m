From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 17:25:45 +0000
Subject: [PATCH v2 12/19] ARM: at91/rtc-at91sam9: each SoC can select the
 RTT device to use
In-Reply-To: <20120222170724.GF9407@game.jcrosoft.org>
References: <1329903585-30738-1-git-send-email-nicolas.ferre@atmel.com>
 <201202221647.23430.arnd@arndb.de> <20120222170724.GF9407@game.jcrosoft.org>
Message-ID: <201202221725.46150.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > But if you change the rtc driver to always bind to the existing
> > "at91_rtt" platform_device and fail the probe() function for the
> > case that you are on at91sam9263 probing the non-RTC device,
> > you should get the exact same result without any extra code
> > in the per-soc files.
>
> agreed but as on at91sam9263 you have 2 RTTs so you can have 2 drivers at the
> same time that use the RTT. So we can not do this except if we set the second
> RTT to an other device name.

Let me rephrase what I meant then:

The first driver should in its probe function do:

	if (pdev->id != CONFIG_RTC_DRV_AT91SAM9_RTT)
		return -ENODEV;

while the other driver does

	if (pdev->id == CONFIG_RTC_DRV_AT91SAM9_RTT)
		return -ENODEV;

This way, each driver binds to one device but not the other.
It should even work with an unmodified second driver, as long
as you guarantee that it's loaded after the first one.

Any reason why this won't work?

	Arnd
