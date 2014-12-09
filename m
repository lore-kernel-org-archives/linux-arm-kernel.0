From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Dec 2014 12:20:04 +0100
Subject: [PATCH v3 1/8] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT6397 SoC
In-Reply-To: <CABuKBe+whgVryssULCu2MAXRu3u+pYwM2nN3ToTEGpEvniQ6Jw@mail.gmail.com>
References: <1417752479-4749-1-git-send-email-flora.fu@mediatek.com>
 <20141209101341.GV30369@pengutronix.de>
 <CABuKBe+whgVryssULCu2MAXRu3u+pYwM2nN3ToTEGpEvniQ6Jw@mail.gmail.com>
Message-ID: <3015972.tvmzP0zTdv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 December 2014 11:30:15 Matthias Brugger wrote:
> 2014-12-09 11:13 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> > On Tue, Dec 09, 2014 at 09:23:18AM +0100, Arnd Bergmann wrote:
> >>
> >> I think we have had a similar case recently where a controller wasn't
> >> actually using I2C, but the sofware protocol was close enough so we decided
> >> to make it appear as i2c in Linux.
> >>
> >> Would that work for you, i.e. register the pmic wrapper as a fake spi
> >> master driver in drivers/spi/ and register the rtc/regulator/codec
> >> as SPI clients from DT?
> >
> > I don't think that's appropriate. I mean technically that could even
> > work, but in software you really don't see anything from the underlying
> > SPI bus. The SoC and the PMIC are really tightly coupled via the PMIC
> > wrapper. This goes to the point where pins of the SoCs internal I2C and
> > keypad controllers are routed over the SPI bus out of the PMIC. In
> > software you do this by setting a bit in the I2C controller. If it's
> > set, the signals are routed out of the PMIC instead of the main die.
> > As said, technically we probably could create a fake SPI master, but
> > that wouldn't really fit to this situation.

Ok, I see.

> I agree with Sascha. Although from the hardware point of view, the
> communication between the PMIC and the SOC is done through SPI from
> the point of view of the software everything looks like I2C commands
> which will be "transalted" into SPI messages by the PMIC wrapper.

If it looks like i2c messages, would it be more appropriate to make
it appear as an i2c controller then?

	Arnd
