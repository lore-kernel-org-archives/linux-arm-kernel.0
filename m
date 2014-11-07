From: padma.kvr@gmail.com (Padma Venkat)
Date: Fri, 7 Nov 2014 14:01:57 +0530
Subject: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
In-Reply-To: <20141106102636.GT8509@sirena.org.uk>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
 <20141106102636.GT8509@sirena.org.uk>
Message-ID: <CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i6edOm6U3bc26_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

CCing Kukjin Kim.

On 11/6/14, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Nov 06, 2014 at 03:21:49PM +0530, Padmavathi Venna wrote:
>> Exynos7 SPI controller supports only the auto Selection of
>> CS toggle mode and Exynos7 SoC includes six SPI controllers.
>> Add support for these changes in Exynos7 SPI controller driver.
>
> Could you give a bit more detail on what the "auto selection of CS
> toggle mode" is - in the diff it looks like it's not an existing mode.
> I'm a bit worried that it's not going to function well with devices that
> send more than one transfer per message.

There is a bit AUTO_N_MANUAL(as per manual) in the spi CS_CFG
register(as per manual, in the driver it is S3C64XX_SPI_SLAVE_SEL) to
control the CS toggle mode either manually or automatically. If CS has
to be controlled manually the AUTO_N_MANUAL should be set to 0 which
the driver is doing in the s3c64xx_spi_transfer_one function by
writing 0 in the S3C64XX_SPI_SLAVE_SEL. When it is handled manually
NSSOUT as per the manual(in the driver it is
S3C64XX_SPI_SLAVE_SIG_INACT) controls the level of CS which when set
deactivates the signal and reset activates.

CS can also be controlled automatically by setting AUTO_N_MANUAL to 1
in CS_CFG. When it is auto CS automatically toggles between packet to
packet. NCS_TIME_COUNT in CS_CFG controls the inactive period. The
driver by default uses manual mode. But on exynos7 the manual mode is
removed.

I tested the driver with wm5110 codec.

>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>
> It's better if your signoff is using the same e-maill address as

ok.  I will take care of this.

>

Thanks
Padma
