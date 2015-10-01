From: Anton_Bondarenko@mentor.com (Bondarenko, Anton)
Date: Thu, 1 Oct 2015 00:16:49 +0000
Subject: [PATCH v2 5/8] spi: imx: Add support for loopback for ECSPI
 controllers
In-Reply-To: <20150930084219.GE2709@shlinux2>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <ca96561d8010acf587a93d0f357774bf77efbe16.1442923630.git.anton_bondarenko@mentor.com>
 <20150930084219.GE2709@shlinux2>
Message-ID: <04376A3D786BD947B28569C998A374A62E280E0F@NA-MBX-02.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.09.2015 10:42, Robin Gong wrote:
> On Fri, Sep 25, 2015 at 07:57:12PM +0200, Anton Bondarenko wrote:
>> @@ -370,8 +374,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
>>  	if (config->mode & SPI_CS_HIGH)
>>  		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
>>  
>> +	if (config->mode & SPI_LOOP)
>> +		lpb |= MX51_ECSPI_LOOP;
>> +
>>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>>  	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
>> +	writel(lpb, spi_imx->base + MX51_ECSPI_TEST);
> It's better write this MX51_ECSPI_TEST only in LOOP mode.
LOOP mode can be set dynamically. This mean we should be able to set and clear the flag.
Currently only LOOP flag is used. I did not find any problems with writing 0 in the rest
fields of TEST register.
>>  
>>  	/*
>>  	 * Wait until the changes in the configuration register CONFIGREG
>> @@ -1276,12 +1287,13 @@ static int spi_imx_probe(struct platform_device *pdev)
>>  	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
>>  	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
>>  	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
>> -	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>> +	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA |
>> +				SPI_CS_HIGH;
> Any change?
Will be fixed in V3
>>  
>> -	init_completion(&spi_imx->xfer_done);
>> +	if (is_imx5x_ecspi(spi_imx))
>> +		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
>>  
>> -	spi_imx->devtype_data = of_id ? of_id->data :
>> -		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
>> +	init_completion(&spi_imx->xfer_done);
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>  	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
>> -- 
>> 2.5.2
>>
