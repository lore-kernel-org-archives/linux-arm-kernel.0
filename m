From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Wed, 21 Oct 2015 01:08:17 +0200
Subject: [PATCH v2 5/8] spi: imx: Add support for loopback for ECSPI
 controllers
In-Reply-To: <20151008092827.GB6101@shlinux2>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <ca96561d8010acf587a93d0f357774bf77efbe16.1442923630.git.anton_bondarenko@mentor.com>
 <20150930084219.GE2709@shlinux2>
 <04376A3D786BD947B28569C998A374A62E280E0F@NA-MBX-02.mgc.mentorg.com>
 <20151008092827.GB6101@shlinux2>
Message-ID: <5626C961.7070009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08.10.2015 11:28, Robin Gong wrote:
> On Thu, Oct 01, 2015 at 12:16:49AM +0000, Bondarenko, Anton wrote:
>> On 30.09.2015 10:42, Robin Gong wrote:
>>> On Fri, Sep 25, 2015 at 07:57:12PM +0200, Anton Bondarenko wrote:
>>>> @@ -370,8 +374,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>>>>   	if (config->mode & SPI_CS_HIGH)
>>>>   		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
>>>>
>>>> +	if (config->mode & SPI_LOOP)
>>>> +		lpb |= MX51_ECSPI_LOOP;
>>>> +
>>>>   	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>>>>   	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
>>>> +	writel(lpb, spi_imx->base + MX51_ECSPI_TEST);
>>> It's better write this MX51_ECSPI_TEST only in LOOP mode.
>> LOOP mode can be set dynamically. This mean we should be able to set and clear the flag.
>> Currently only LOOP flag is used. I did not find any problems with writing 0 in the rest
>> fields of TEST register.
> Yes, I know writing 0 is harmless, but we never need to touch this register if
> SPI_LOOP flags not set, I'd like below:
> 	if (config->mode & SPI_LOOP) {
> 		lpb |= MX51_ECSPI_LOOP;
> 		writel(lgb, spi_imx->base + MX51_ECSPI_TEST);
> 	}
>
Proposed code not able to clear LOOP mode in TEST register. What about 
something like this:
if (config->mode & SPI_LOOP)
	lpb |= MX51_ECSPI_LOOP;

if ((readl(spi_imx->base + MX51_ECSPI_TEST) & MX51_ECSPI_LOOP) != lpb)
	writel(lpb, spi_imx->base + MX51_ECSPI_TEST);

In this case driver will write TEST register only if needed.
>>>>
>>>>   	/*
>>>>   	 * Wait until the changes in the configuration register CONFIGREG

Regards,
Anton
