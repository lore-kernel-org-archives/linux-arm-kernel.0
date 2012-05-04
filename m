From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 04 May 2012 22:24:10 +0100
Subject: [PATCH 06/15] mfd/ab8500: Remove confusing ab8500-i2c file and
 merge into ab8500-core
In-Reply-To: <201205042025.15421.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-7-git-send-email-lee.jones@linaro.org>
 <201205042025.15421.arnd@arndb.de>
Message-ID: <4FA448FA.8000404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/12 21:25, Arnd Bergmann wrote:
> On Friday 04 May 2012, Lee Jones wrote:
>>
>> ab8500-i2c is used as core code to register the ab8500 device.
>> After allocating ab8500 memory, it immediately calls into
>> ab8500-core where the real initialisation takes place. This
>> patch moves all core registration and memory allocation into
>> the true ab8500-core file and removes ab8500-i2c completely.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> These changes all look good, but I think I would go further here.
> I believe we discussed this and I agreed that we could leave that
> for later, but upon reading this code, I think now that it's getting
> rather silly.
>
>> @@ -125,6 +126,41 @@ static const char ab8500_version_str[][7] = {
>>          [AB8500_VERSION_AB8540] = "AB8540",
>>   };
>>
>> +static int ab8500_i2c_write(struct ab8500 *ab8500, u16 addr, u8 data)
>> +{
>> +       int ret;
>> +
>> +       ret = prcmu_abb_write((u8)(addr>>  8), (u8)(addr&  0xFF),&data, 1);
>> +       if (ret<  0)
>> +               dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
>> +       return ret;
>> +}
>> +
>> +static int ab8500_i2c_write_masked(struct ab8500 *ab8500, u16 addr, u8 mask,
>> +       u8 data)
>> +{
>> +       int ret;
>> +
>> +       ret = prcmu_abb_write_masked((u8)(addr>>  8), (u8)(addr&  0xFF),&data,
>> +&mask, 1);
>> +       if (ret<  0)
>> +               dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
>> +       return ret;
>> +}
>> +
>> +static int ab8500_i2c_read(struct ab8500 *ab8500, u16 addr)
>> +{
>> +       int ret;
>> +       u8 data;
>> +
>> +       ret = prcmu_abb_read((u8)(addr>>  8), (u8)(addr&  0xFF),&data, 1);
>> +       if (ret<  0) {
>> +               dev_err(ab8500->dev, "prcmu i2c error %d\n", ret);
>> +               return ret;
>> +       }
>> +       return (int)data;
>> +}
>> +
>>   static int ab8500_get_chip_id(struct device *dev)
>>   {
>>          struct ab8500 *ab8500;
>
> Each of these functions is called only from a single location, and through an indirect
> function pointer.
>
>> +       ab8500->read = ab8500_i2c_read;
>> +       ab8500->write = ab8500_i2c_write;
>> +       ab8500->write_masked = ab8500_i2c_write_masked;
>
> Which you unconditionally assign here.
>
> If you apply this patch below, then there is no reason to add any of those.
> There is room for additional simplification even, but this is the most
> important one. Note that the ab8500 mutex was only needed to support the
> case where write_masked is not present, and that the debug output
> on error is pointless because the prcmu driver already writes the same
> output. The next step would be to remove all the {get,set}_register functions
> from ab8500 and just call the prcmu directly.

It's something I'm happy to do, but wasn't the point of the patch. I 
don't know much about this code, as I didn't write it.

> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> ---
>
>   drivers/mfd/ab8500-core.c         |   72 +++---------------------------------------------------------------------
>   include/linux/mfd/abx500/ab8500.h |    1 -
>   2 files changed, 3 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index 1f08704..b10bd2f 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -138,24 +138,8 @@ static int ab8500_get_chip_id(struct device *dev)
>   static int set_register_interruptible(struct ab8500 *ab8500, u8 bank,
>   	u8 reg, u8 data)
>   {
> -	int ret;
> -	/*
> -	 * Put the u8 bank and u8 register together into a an u16.
> -	 * The bank on higher 8 bits and register in lower 8 bits.
> -	 * */
> -	u16 addr = ((u16)bank)<<  8 | reg;
> -
>   	dev_vdbg(ab8500->dev, "wr: addr %#x<= %#x\n", addr, data);
> -
> -	mutex_lock(&ab8500->lock);
> -
> -	ret = ab8500->write(ab8500, addr, data);
> -	if (ret<  0)
> -		dev_err(ab8500->dev, "failed to write reg %#x: %d\n",
> -			addr, ret);
> -	mutex_unlock(&ab8500->lock);
> -
> -	return ret;
> +	return prcmu_abb_write(bank, reg,&data, 1);
>   }
>
>   static int ab8500_set_register(struct device *dev, u8 bank,
> @@ -169,21 +153,7 @@ static int ab8500_set_register(struct device *dev, u8 bank,
>   static int get_register_interruptible(struct ab8500 *ab8500, u8 bank,
>   	u8 reg, u8 *value)
>   {
> -	int ret;
> -	/* put the u8 bank and u8 reg together into a an u16.
> -	 * bank on higher 8 bits and reg in lower */
> -	u16 addr = ((u16)bank)<<  8 | reg;
> -
> -	mutex_lock(&ab8500->lock);
> -
> -	ret = ab8500->read(ab8500, addr);
> -	if (ret<  0)
> -		dev_err(ab8500->dev, "failed to read reg %#x: %d\n",
> -			addr, ret);
> -	else
> -		*value = ret;
> -
> -	mutex_unlock(&ab8500->lock);
> +	ret = prcmu_abb_read(bank, addr, value, 1);
>   	dev_vdbg(ab8500->dev, "rd: addr %#x =>  data %#x\n", addr, ret);
>
>   	return ret;
> @@ -200,42 +170,7 @@ static int ab8500_get_register(struct device *dev, u8 bank,
>   static int mask_and_set_register_interruptible(struct ab8500 *ab8500, u8 bank,
>   	u8 reg, u8 bitmask, u8 bitvalues)
>   {
> -	int ret;
> -	/* put the u8 bank and u8 reg together into a an u16.
> -	 * bank on higher 8 bits and reg in lower */
> -	u16 addr = ((u16)bank)<<  8 | reg;
> -
> -	mutex_lock(&ab8500->lock);
> -
> -	if (ab8500->write_masked == NULL) {
> -		u8 data;
> -
> -		ret = ab8500->read(ab8500, addr);
> -		if (ret<  0) {
> -			dev_err(ab8500->dev, "failed to read reg %#x: %d\n",
> -				addr, ret);
> -			goto out;
> -		}
> -
> -		data = (u8)ret;
> -		data = (~bitmask&  data) | (bitmask&  bitvalues);
> -
> -		ret = ab8500->write(ab8500, addr, data);
> -		if (ret<  0)
> -			dev_err(ab8500->dev, "failed to write reg %#x: %d\n",
> -				addr, ret);
> -
> -		dev_vdbg(ab8500->dev, "mask: addr %#x =>  data %#x\n", addr,
> -			data);
> -		goto out;
> -	}
> -	ret = ab8500->write_masked(ab8500, addr, bitmask, bitvalues);
> -	if (ret<  0)
> -		dev_err(ab8500->dev, "failed to modify reg %#x: %d\n", addr,
> -			ret);
> -out:
> -	mutex_unlock(&ab8500->lock);
> -	return ret;
> +	return prcmu_abb_write_masked(bank, reg,&bitmask,&bitvalues, 1);
>   }
>
>   static int ab8500_mask_and_set_register(struct device *dev,
> @@ -1013,7 +948,6 @@ int __devinit ab8500_init(struct ab8500 *ab8500, enum ab8500_version version)
>   	if (plat)
>   		ab8500->irq_base = plat->irq_base;
>
> -	mutex_init(&ab8500->lock);
>   	mutex_init(&ab8500->irq_lock);
>
>   	if (version != AB8500_VERSION_UNDEFINED)
> diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
> index fccc300..5f70328 100644
> --- a/include/linux/mfd/abx500/ab8500.h
> +++ b/include/linux/mfd/abx500/ab8500.h
> @@ -232,7 +232,6 @@ enum ab8500_version {
>    */
>   struct ab8500 {
>   	struct device	*dev;
> -	struct mutex	lock;
>   	struct mutex	irq_lock;
>
>   	int		irq_base;


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
