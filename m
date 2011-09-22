From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 22 Sep 2011 22:31:17 +0400
Subject: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
In-Reply-To: <CAJNCFVLm=bUMvXq7acke7Bd_tiV+b1=HjVp37KwtYyGsZHa+OQ@mail.gmail.com>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	<1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
	<20110920203037.GE31404@pengutronix.de>
	<CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com>
	<CAJNCFVLm=bUMvXq7acke7Bd_tiV+b1=HjVp37KwtYyGsZHa+OQ@mail.gmail.com>
Message-ID: <20110922183117.GA17600@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Wed, Sep 21, 2011 at 03:05:44PM +0800, Richard Zhu wrote:
> Hi Sascha:
> One proposal about how to convert the ahci driver to devicetree in future.
> ahci driver system can make a reference to the evolution of the sdhc driver.

You don't need to "convert" ahci driver to devicetree. IIRC,
the current ahci_platform driver should work almost* out of
the box with OF-enabled architectures, as OF subsystem
automatically populates memory and interrupt resources for
platform devices.

Someday you might need to implement OF-specific bindings
(e.g. get some property from the device tree and translate
it into port flags). When/if you'll need it, you can just
add it into the driver.

* Almost: you have to add of_match_table into 'struct
  platform_driver ahci_driver'.

> * separate the ahci to ahci common codes, ahci-pci driver and
> ahci-platform driver.

Done. Long time ago, actually.

> * create kinds of ahci vendor's own ahci platform driver refer to the
> sdhci-xxx driver solutions.

I think that this is viable, but personally I would like to
see platforms to just pass port flags and all needed hooks
via platform_data. That is, I'd leave the hooks in the arch/
code. Usually these hooks are very arch-specific (i.e. enable
these and these clocks, etc), so arch/ seems like a perfect
place for such things.

Not a strong opinion though, and if you like to go your route,
I'm also fine with this. It has its own pros (and cons).

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
