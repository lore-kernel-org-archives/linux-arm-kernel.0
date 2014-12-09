From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 9 Dec 2014 11:30:15 +0100
Subject: [PATCH v3 1/8] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT6397 SoC
In-Reply-To: <20141209101341.GV30369@pengutronix.de>
References: <1417752479-4749-1-git-send-email-flora.fu@mediatek.com>
 <2751641.o51TuZRl88@wuerfel> <1418091337.5663.9.camel@mtksdaap41>
 <2248330.M654Toyebg@wuerfel>
 <20141209101341.GV30369@pengutronix.de>
Message-ID: <CABuKBe+whgVryssULCu2MAXRu3u+pYwM2nN3ToTEGpEvniQ6Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-09 11:13 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> On Tue, Dec 09, 2014 at 09:23:18AM +0100, Arnd Bergmann wrote:
>> On Tuesday 09 December 2014 10:15:37 Flora Fu wrote:
>> > Hi, Arnd,
>> >
>> > On Fri, 2014-12-05 at 11:13 +0100, Arnd Bergmann wrote:
>> > > On Friday 05 December 2014 12:07:52 Flora Fu wrote:
>> > > > Add PMIC wrapper of MT8135 to access MT6397 MFD.
>> > > >
>> > > > Signed-off-by: Flora Fu <flora.fu@mediatek.com>
>> > > >
>> > >
>> > > Please explain what a PMIC wrapper is and why you need one for MT8135.
>> > > I don't understand the purpose of this code at all. Is this just another
>> > > way of accessing the MT6397 when not using i2c or spi like other
>> > > PMIC drivers do?
>> > >
>> >
>> > Yes, MT8135 uses a proprietary hardware to communicate with MT6397.
>> > The hardware is called PMIC Wrapper or PWRAP.
>> > Since it is not standard i2c or spi protocols, a soc related software
>> > driver is implemented to handle access protocols in AP side.
>> >
>> > +-----------------+           +---------------+
>> > |                 |           |               |
>> > | Mediatek AP SoC |           |               |
>> > | (ex. MT8135)    |           |    MT6397     |
>> > |                 |           |               |
>> > |      +--------+ | (SPI bus) | +--------+    |
>> > |      |        | |-----------| |        |    |
>> > |      |  PMIC  | |-----------| |  PMIC  |    |
>> > |      | Wrapper| |-----------| | Wrapper|    |
>> > |      |        | |-----------| |        |    |
>> > |      +--------+ |           | +--------+    |
>> > |                 |           |               |
>> > +-----------------+           +---------------+
>> >
>>
>> I think we have had a similar case recently where a controller wasn't
>> actually using I2C, but the sofware protocol was close enough so we decided
>> to make it appear as i2c in Linux.
>>
>> Would that work for you, i.e. register the pmic wrapper as a fake spi
>> master driver in drivers/spi/ and register the rtc/regulator/codec
>> as SPI clients from DT?
>
> I don't think that's appropriate. I mean technically that could even
> work, but in software you really don't see anything from the underlying
> SPI bus. The SoC and the PMIC are really tightly coupled via the PMIC
> wrapper. This goes to the point where pins of the SoCs internal I2C and
> keypad controllers are routed over the SPI bus out of the PMIC. In
> software you do this by setting a bit in the I2C controller. If it's
> set, the signals are routed out of the PMIC instead of the main die.
> As said, technically we probably could create a fake SPI master, but
> that wouldn't really fit to this situation.

I agree with Sascha. Although from the hardware point of view, the
communication between the PMIC and the SOC is done through SPI from
the point of view of the software everything looks like I2C commands
which will be "transalted" into SPI messages by the PMIC wrapper.

Cheers,
Matthias

>
> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
motzblog.wordpress.com
