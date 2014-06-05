From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 17:29:01 +0200
Subject: [PATCH] ASoC: sigmadsp: remove I2C support
In-Reply-To: <53908B5B.10807@metafoo.de>
References: <6181626.txoA4bpImf@wuerfel> <4610731.9TBGyCy3TV@wuerfel>
 <53908B5B.10807@metafoo.de>
Message-ID: <6805774.tHfga8A7Qh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014 17:23:07 Lars-Peter Clausen wrote:
> On 06/05/2014 05:10 PM, Arnd Bergmann wrote:
> > On Thursday 05 June 2014 16:55:47 Lars-Peter Clausen wrote:
> >> On 06/05/2014 04:47 PM, Arnd Bergmann wrote:
> >>> The newly added ADAU1781 codec comes with separate drivers for
> >>> I2C and SPI modes, which gives us a new variation of the dependency
> >>> problems: If SPI is enabled and the I2C core is a loadable module,
> >>> selecting SND_SOC_ADAU1781_SPI as built-in leads to a link error because
> >>> the common base code from sigmadsp.c now also gets built-in:
> >>>
> >>> sound/built-in.o: In function `sigma_action_write_i2c':
> >>> :(.text+0x5d8d4): undefined reference to `i2c_master_send'
> >>>
> >>> Rather than adding yet more complex Kconfig logic, this converts the last
> >>> user of process_sigma_firmware() to process_sigma_firmware_regmap(),
> >>> which seems trivial after the driver itself now uses regmap as well.
> >>> With that done, there is no more linker dependency from
> >>> SND_SOC_ADAU1781_SPI to i2c_master_send.
> >>>
> >>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >>
> >> No this patch won't work. Regmap support for the adau1701 is rather limited
> >> which is why we need native i2c support in the lib.
> >
> > Ah, I see.
> >
> >> But yea, I just noticed the same problem an hour ago and was thinking
> >> hopefully I'll get to fixing this before it shows up in Arnd's randconfig
> >> builds
> >
> > It's actually my second attempt after I finished writing the first patch
> > for it. Is that better?
> 
> That will fix the symptoms of the issue for SND_SOC_ALL_CODECS, but the 
> problem is still there. I'll send a patch which factors the regmap and I2C 
> sigmadsp code out into their own modules.
> 

Ok, that sounds best, thanks!

	Arnd
