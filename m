From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 26 Nov 2016 20:10:44 +0100 (CET)
Subject: mmc: core: complete/wait_for_completion performance
In-Reply-To: <1479669034.1975.1.camel@embedded.rocks>
References: <1479644869.2653.3.camel@embedded.rocks>
 <585759233.283839.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <1479652929.2841.1.camel@embedded.rocks>
 <187975187.249177.bccdc17e-e9c6-48c2-aeaf-3b81f1b61ec7.open-xchange@email.1und1.de>
 <1479669034.1975.1.camel@embedded.rocks>
Message-ID: <1198138554.59982.63209ba1-8fb4-4a13-9ee0-f746a192f4c7.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J?rg,

> J?rg Krause <joerg.krause@embedded.rocks> hat am 20. November 2016 um 20:10
> geschrieben:
> 
> 
> On Sun, 2016-11-20 at 16:44 +0100, Stefan Wahren wrote:
> > > J?rg Krause <joerg.krause@embedded.rocks> hat am 20. November 2016
> > > um 15:42
> > > geschrieben:
> > > 
> > > 
> > > Hi Stefan,
> > > 
> > > On Sun, 2016-11-20 at 14:28 +0100, Stefan Wahren wrote:
> > > > Hi J?rg,
> > > > 
> > > > > J?rg Krause <joerg.krause@embedded.rocks> hat am 20. November
> > > > > 2016
> > > > > um 13:27
> > > > > geschrieben:
> > > > > 
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > I started the discussion on this mailing list in another thread
> > > > > [1],
> > > > > but I'd like to move it to a new thread, because it might be
> > > > > mmc
> > > > > specific.
> > > > > 
> > > > > The issue is that I am noticed low wifi network throughput on
> > > > > an
> > > > > i.MX28
> > > > > board with the mainline kernel (v4.7.10, about 6 Mbps) compared
> > > > > to
> > > > > the
> > > > > vendor kernel (Freescale v2.6.35.3, about 20 Mbps). The wifi
> > > > > chip
> > > > > is
> > > > > attached using the SDIO interface.
> > > > > 
> > > > > I started investigation where the bottleneck in the mainline
> > > > > kernel?might come from. Therefore I checked that the configs
> > > > > and
> > > > > settings for the interfaces and drivers are the same. They are.
> > > > 
> > > > so you're not using the mxs_defconfig settings anymore?
> > > 
> > > No, I changed the settings.
> > > 
> > 
> > What happens to performance to if you change the following settings
> > to the same
> > like in mxs_defconfig?
> > 
> > CONFIG_PREEMPT_VOLUNTARY=y
> > CONFIG_DEFAULT_IOSCHED="noop"
> 
> No much change at all. The time difference between complete() and
> wait_for_complete() decreases in best case to 110 us, but also varies
> to above 130 us.

just a weird idea. Did you tried to add MMC_CAP_CMD23 into the caps [1]?

[1] - http://lxr.free-electrons.com/source/drivers/mmc/host/mxs-mmc.c?v=4.8#L642
