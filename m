From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 17:10:18 +0200
Subject: [PATCH] ASoC: sigmadsp: remove I2C support
In-Reply-To: <539084F3.3050700@metafoo.de>
References: <6181626.txoA4bpImf@wuerfel> <539084F3.3050700@metafoo.de>
Message-ID: <4610731.9TBGyCy3TV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014 16:55:47 Lars-Peter Clausen wrote:
> On 06/05/2014 04:47 PM, Arnd Bergmann wrote:
> > The newly added ADAU1781 codec comes with separate drivers for
> > I2C and SPI modes, which gives us a new variation of the dependency
> > problems: If SPI is enabled and the I2C core is a loadable module,
> > selecting SND_SOC_ADAU1781_SPI as built-in leads to a link error because
> > the common base code from sigmadsp.c now also gets built-in:
> >
> > sound/built-in.o: In function `sigma_action_write_i2c':
> > :(.text+0x5d8d4): undefined reference to `i2c_master_send'
> >
> > Rather than adding yet more complex Kconfig logic, this converts the last
> > user of process_sigma_firmware() to process_sigma_firmware_regmap(),
> > which seems trivial after the driver itself now uses regmap as well.
> > With that done, there is no more linker dependency from
> > SND_SOC_ADAU1781_SPI to i2c_master_send.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> 
> No this patch won't work. Regmap support for the adau1701 is rather limited 
> which is why we need native i2c support in the lib.

Ah, I see.

> But yea, I just noticed the same problem an hour ago and was thinking 
> hopefully I'll get to fixing this before it shows up in Arnd's randconfig 
> builds 

It's actually my second attempt after I finished writing the first patch
for it. Is that better?

8<---------
commit 75b46664e7c26cf044da3322c31ce8e7c4a16715
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Jun 5 15:47:35 2014 +0200

ASoC: fix ADAU 17x1 I2C dependencies
    
The newly added ADAU1761 and ADAU1781 codecs come with separate drivers
for I2C and SPI modes, which gives us a new variation of the dependency
problems: If SPI is enabled and the I2C core is a loadable module,
selecting SND_SOC_ADAU1781_SPI as built-in leads to a link error because
the common base code from sigmadsp.c now also gets built-in:
    
sound/built-in.o: In function `sigma_action_write_i2c':
:(.text+0x5d8d4): undefined reference to `i2c_master_send'
    
To avoid that, this adds another Kconfig hack similar to the existing
SND_SOC_I2C_AND_SPI symbol: the new SND_SOC_SPI_AND_MAYBE_I2C helps
us enable the adau17x1-spi drivers as loadable modules in this
case, but built-in when I2C is either disabled or built-in as well.
    
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cbfa1e1..41bca14 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -8,6 +8,11 @@ config SND_SOC_I2C_AND_SPI
 	default y if I2C=y
 	default y if SPI_MASTER=y
 
+config SND_SOC_SPI_AND_MAYBE_I2C
+	tristate
+	default m if SPI_MASTER=y && I2C=m
+	default y if SPI_MASTER=y
+
 menu "CODEC drivers"
 
 config SND_SOC_ALL_CODECS
@@ -24,9 +29,9 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD73311
 	select SND_SOC_ADAU1373 if I2C
 	select SND_SOC_ADAU1761_I2C if I2C
-	select SND_SOC_ADAU1761_SPI if SPI
+	select SND_SOC_ADAU1761_SPI if SND_SOC_SPI_AND_MAYBE_I2C
 	select SND_SOC_ADAU1781_I2C if I2C
-	select SND_SOC_ADAU1781_SPI if SPI
+	select SND_SOC_ADAU1781_SPI if SND_SOC_SPI_AND_MAYBE_I2C
 	select SND_SOC_ADAV801 if SPI_MASTER
 	select SND_SOC_ADAV803 if I2C
 	select SND_SOC_ADAU1977_SPI if SPI_MASTER
