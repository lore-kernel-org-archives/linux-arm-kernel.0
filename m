From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 21 Sep 2012 09:36:51 +0200
Subject: [PATCH] spi/imx: set the inactive state of the clock according
 to the clock polarity
In-Reply-To: <20120831023518.GE7726@r65073-Latitude-D630>
References: <1346403311-25080-1-git-send-email-dirk.behme@de.bosch.com>
 <20120831023518.GE7726@r65073-Latitude-D630>
Message-ID: <505C1913.1090004@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.08.2012 04:35, Shawn Guo wrote:
> Copy Uwe ...

Ping ;)

Any opinions on this?

Thanks

Dirk

> On Fri, Aug 31, 2012 at 10:55:11AM +0200, Dirk Behme wrote:
>> From: Knut Wohlrab <knut.wohlrab@de.bosch.com>
>>
>> There are SPI devices which need a SPI clock with active low polarity and
>> high inactive state.
>>
>> Add the setting of the inactive state ECSPIx_CONFIGREG:SCLK CTL
>> according to the clock polarity ECSPIx_CONFIGREG:SCLK POL:
>>
>> DT without "spi-cpol" = 0 = clock active high polarity = inactive state low
>> DT with    "spi-cpol" = 1 = clock active low  polarity = inactive state high
>>
>> Signed-off-by: Knut Wohlrab <knut.wohlrab@de.bosch.com>
>> ---
>>
>> Question: Are there real world examples for a need of an individual setting of
>> clock polarity/inactive state?
> 
> I'm less concerned about that.  We can always patch the driver when
> the real world example occurs?
> 
> Regards,
> Shawn
> 
>>  drivers/spi/spi-imx.c |    6 ++++--
>>  1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index e834ff8..d64655b 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -197,6 +197,7 @@ static unsigned int spi_imx_clkdiv_2(unsigned int fin,
>>  #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs) +  4))
>>  #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs) +  8))
>>  #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs) + 12))
>> +#define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs) + 20))
>>  
>>  #define MX51_ECSPI_INT		0x10
>>  #define MX51_ECSPI_INT_TEEN		(1 <<  0)
>> @@ -287,9 +288,10 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>>  	if (config->mode & SPI_CPHA)
>>  		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
>>  
>> -	if (config->mode & SPI_CPOL)
>> +	if (config->mode & SPI_CPOL) {
>>  		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
>> -
>> +		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
>> +	}
>>  	if (config->mode & SPI_CS_HIGH)
>>  		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
>>  
>> -- 
>> 1.7.0.4
