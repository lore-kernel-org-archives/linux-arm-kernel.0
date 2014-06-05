From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 05 Jun 2014 16:55:47 +0200
Subject: [PATCH] ASoC: sigmadsp: remove I2C support
In-Reply-To: <6181626.txoA4bpImf@wuerfel>
References: <6181626.txoA4bpImf@wuerfel>
Message-ID: <539084F3.3050700@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 04:47 PM, Arnd Bergmann wrote:
> The newly added ADAU1781 codec comes with separate drivers for
> I2C and SPI modes, which gives us a new variation of the dependency
> problems: If SPI is enabled and the I2C core is a loadable module,
> selecting SND_SOC_ADAU1781_SPI as built-in leads to a link error because
> the common base code from sigmadsp.c now also gets built-in:
>
> sound/built-in.o: In function `sigma_action_write_i2c':
> :(.text+0x5d8d4): undefined reference to `i2c_master_send'
>
> Rather than adding yet more complex Kconfig logic, this converts the last
> user of process_sigma_firmware() to process_sigma_firmware_regmap(),
> which seems trivial after the driver itself now uses regmap as well.
> With that done, there is no more linker dependency from
> SND_SOC_ADAU1781_SPI to i2c_master_send.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

No this patch won't work. Regmap support for the adau1701 is rather limited 
which is why we need native i2c support in the lib.

But yea, I just noticed the same problem an hour ago and was thinking 
hopefully I'll get to fixing this before it shows up in Arnd's randconfig 
builds ;)

- Lars
