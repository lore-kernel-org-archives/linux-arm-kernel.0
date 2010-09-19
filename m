From: jason77.wang@gmail.com (Jason Wang)
Date: Sun, 19 Sep 2010 16:47:49 +0800
Subject: [PATCH 04/16] spi/imx: save the spi chip select in config	struct,
	not the gpio to use
In-Reply-To: <20100917112026.GE27467@n2100.arm.linux.org.uk>
References: <20100917095247.GB30441@pengutronix.de>
	<1284717274-12850-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<19603.19666.323684.891456@ipc1.ka-ro>
	<20100917112026.GE27467@n2100.arm.linux.org.uk>
Message-ID: <4C95CE35.7030303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Fri, Sep 17, 2010 at 01:11:14PM +0200, Lothar Wa?mann wrote:
>   
>> Hi,
>>
>>     
>>> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
>>> index 60a52d1..23db984 100644
>>> --- a/drivers/spi/spi_imx.c
>>> +++ b/drivers/spi/spi_imx.c
>>> @@ -56,7 +56,7 @@ struct spi_imx_config {
>>>  	unsigned int speed_hz;
>>>  	unsigned int bpw;
>>>  	unsigned int mode;
>>> -	int cs;
>>> +	u8 cs;
>>>       
>>         ^^^^^^
>>     
>
> u8 cs in spi_imx_config.
>
>   
>>>  };
>>>  
>>>  enum spi_imx_devtype {
>>> @@ -218,6 +218,7 @@ static int __maybe_unused spi_imx0_4_config(struct spi_imx_data *spi_imx,
>>>  		struct spi_imx_config *config)
>>>  {
>>>  	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
>>> +	int cs = spi_imx->chipselect[config->cs];
>>>       
>
> which is used as an index to this array (which presumably is an array of
> ints.)  Let's hope that it is 256 entries long (maybe it should be
> checked before use?)
>
>   
>>>  
>>>  	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, config->speed_hz) <<
>>>  		MX31_CSPICTRL_DR_SHIFT;
>>> @@ -230,9 +231,8 @@ static int __maybe_unused spi_imx0_4_config(struct spi_imx_data *spi_imx,
>>>  		reg |= MX31_CSPICTRL_POL;
>>>  	if (config->mode & SPI_CS_HIGH)
>>>  		reg |= MX31_CSPICTRL_SSPOL;
>>> -	if (config->cs < 0) {
>>> -		reg |= (config->cs + 32) << MX31_CSPICTRL_CS_SHIFT;
>>> -	}
>>> +	if (cs < 0)
>>>
>>>       
>> This can never be true, since an 'int' promoted from 'u8' will always
>> be positive!
>>     
>
> This is the value of chipselect[config->cs] not of the u8 config->cs.
>
>   
Yes, here (cs < 0) means a SPI dedicate internal CS pin, while (cs >= 0)
means a GPIO act as a SPI CS pin.

Thanks,
Jason.
