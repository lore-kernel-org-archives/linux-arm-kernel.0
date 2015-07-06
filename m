From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 06 Jul 2015 17:32:37 +0530
Subject: [RFC PATCH] pinctrl-single: Use of pinctrl-single for external
 device over I2C
In-Reply-To: <20150706063532.GB10705@atomide.com>
References: <1435855992-10312-1-git-send-email-vaibhav.hiremath@linaro.org>
 <20150706063532.GB10705@atomide.com>
Message-ID: <559A6E5D.9040202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 06 July 2015 12:05 PM, Tony Lindgren wrote:
> * Vaibhav Hiremath <vaibhav.hiremath@linaro.org> [150702 09:58]:
>> --- a/drivers/pinctrl/pinctrl-single.c
>> +++ b/drivers/pinctrl/pinctrl-single.c
>>
>> -static unsigned __maybe_unused pcs_readb(void __iomem *reg)
>> +static unsigned pcs_read(struct regmap *map, unsigned int reg)
>>   {
>> -	return readb(reg);
>> -}
>> +	unsigned int val;
>>
>> -static unsigned __maybe_unused pcs_readw(void __iomem *reg)
>> -{
>> -	return readw(reg);
>> -}
>> -
>> -static unsigned __maybe_unused pcs_readl(void __iomem *reg)
>> -{
>> -	return readl(reg);
>> -}
>> -
>> -static void __maybe_unused pcs_writeb(unsigned val, void __iomem *reg)
>> -{
>> -	writeb(val, reg);
>> -}
>> +	regmap_read(map, reg, &val);
>
> Sorry this won't work. Most platforms don't need regmap here, and I
> certainly don't want to use regmap for toggling pins for runtime
> PM because of the extra overhead.
>

That's exactly my question was in my first email. It's ok.

What is your openion on overall code changes for regmap support ?
Any other feedback or suggestions?

> It seems you need to stash the regmap pointer to struct pcs_device
> and just the function pointers. As this driver is ioremapping the
> region, we certainly want to keep things using void __iomem * too.
> You can cast that to whatever regmap needs in the wrapper functions
> for regmap. Note that the extra overhead there won't matter as we
> are using regmap mostly for devices over I2C and so on.
>

The issue I have here with the signature of read/write fn

static unsigned __maybe_unused pcs_read(void __iomem *reg)
static void __maybe_unused pcs_writeX(unsigned val, void __iomem *reg)


For regmap, I need 2 arguments,

1. Pointer to regmap
2. Offset to register


So I will have to change the signature to

static unsigned __maybe_unused pcs_read(void __iomem *reg, unsigned int 
offset)
static void __maybe_unused pcs_write(void __iomem *reg, unsigned val, 
unsigned int offset)


And,
On the same direction, will having separate functions for regmap.

static unsigned pcs_read_regmap(void __iomem *reg, unsigned int offset)
{
	unsigned int val;

	regmap_read((struct regmap *)reg, offset, &val);
}

static void pcs_write_regmap(void __iomem *reg, unsigned val, unsigned 
int offset)
{
        regmap_write((struct regmap *)reg, offset, val);
  }


This functions will be initialized to pcs_device->read/write.

I will have to do some more changes, specially around pcs_interrupt
usage.
