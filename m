From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 16 Dec 2009 00:37:59 -0500
Subject: [PATCH v2 02/09] mfd: support 88pm8606 in 860x driver
In-Reply-To: <771cded00912152129u33ed2131x148e8fbecb898165@mail.gmail.com>
References: <771cded00912090511s3f28dd7tf0dcbc54c0c50970@mail.gmail.com>
	<20091210103557.GA6873@sortiz.org>
	<771cded00912152129u33ed2131x148e8fbecb898165@mail.gmail.com>
Message-ID: <771cded00912152137m3c222104s84639494e392acca@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2009 at 12:29 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Thu, Dec 10, 2009 at 5:35 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
>> Hi Haojian,
>>
>> On Wed, Dec 09, 2009 at 08:11:22AM -0500, Haojian Zhuang wrote:
>>>
>>> Now share one driver to these two devices. Only one I2C client is identified
>>> in platform init data. If another chip is also used, user should mark it in
>>> companion_addr field of platform init data. Then driver could create another
>>> I2C client for the companion chip.
>>>
>>> All I2C operations are accessed by 860x-i2c driver. In order to support both
>>> I2C client address, the read/write API is changed in below.
>> The code looks better now. I still have a few comments though:
>>
>>> -static inline int pm8607_read_device(struct pm8607_chip *chip,
>>> +static struct mutex io_lock;
>> Why do we need a static lock here ?
>
> OK, removed it now.
>>
>>> - ? ? mutex_lock(&chip->io_lock);
>>> + ? ? mutex_lock(&io_lock);
>> Why not keep mutex_unlock(&chip->io_lock); where chip is
>> i2c_get_clientdata(i2c) ?
>
> Done.
>>
>>> ?static int __devinit pm860x_probe(struct i2c_client *client,
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const struct i2c_device_id *id)
>>> ?{
>>> - ? ? struct pm8607_platform_data *pdata = client->dev.platform_data;
>>> - ? ? struct pm8607_chip *chip;
>>> + ? ? struct pm860x_platform_data *pdata = client->dev.platform_data;
>>> + ? ? struct pm860x_chip *chip;
>>> + ? ? struct i2c_board_info i2c_info = {
>>> + ? ? ? ? ? ? .type ? ? ? ? ? = "88PM860x",
>>> + ? ? ? ? ? ? .platform_data ?= client->dev.platform_data,
>> I dont think you want to use the same platform_data. At least you want to
>> reset the companion_addr field.
>
> Actually I used the same platform data for both of these two devices.
> Since I only assign companion_addr once in platform_data. If
> client->addr equals to companion_addr, there's two 860x chips and
> current client isn't companion one. If companion_addr is zero, there's
> only one 860x chip. If client->addr equals to companion_addr, current
> client is companion one.
>
> So I needn't to reset the companion_addr field.
>>
>>
>>> +
>>> + ? ? if (found_companion || (addr_c == 0)) {
>> You probably dont need that check here.
>
> Since I'm share the same platform data to two devices, I have to check
> the companion_addr.
>>
>>
>>> + ? ? ? ? ? ? chip = kzalloc(sizeof(struct pm860x_chip), GFP_KERNEL);
>>> + ? ? ? ? ? ? if (chip == NULL)
>>> + ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
>>> +
>>> + ? ? ? ? ? ? chip->id = verify_addr(client);
>>> + ? ? ? ? ? ? chip->client = client;
>>> + ? ? ? ? ? ? i2c_set_clientdata(client, chip);
>>> + ? ? ? ? ? ? chip->dev = &client->dev;
>>> + ? ? ? ? ? ? mutex_init(&io_lock);
>>> + ? ? ? ? ? ? dev_set_drvdata(chip->dev, chip);
>>> +
>>> + ? ? ? ? ? ? if (found_companion) {
>>> + ? ? ? ? ? ? ? ? ? ? chip->companion = i2c_new_device(client->adapter,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&i2c_info);
>>> + ? ? ? ? ? ? ? ? ? ? i2c_set_clientdata(chip->companion, chip);
>>> + ? ? ? ? ? ? }
>> I guess you've tested that code. I have a question: After returning from
>> i2c_new_device(), I'd expect pm860x_probe() to be called as the companion chip
>> is bound. Isnt that that the case ?
>
> Yes, it past the test. The sequence is in below
> 1) Driver is built in. First chip is probed, and launch
> i2c_new_device(). Second chip is probed while the first one isn't
> finished yet. The probing process is recursive.
> 2) Driver is built as module. First chip is probed, and launch
> i2c_new_device(). Then the first chip probing is finished. At last the
> second chip is probed. The probing process is sequential.
>
>>
>> Cheers,
>> Samuel.
>> --
>
> Hi Samuel,
>
> I fixed the patches and pasted all into this mail. Since I fixed some
> issues in below.
> 1. remove static io_lock. Use chip->io_lock instead.
> 2. fix the load/unload module issue in 88pm860x driver.
> 3. fix the chip->chip_irq assignment in 88pm860x driver.
> 4. fix led driver since mutex shouldn't be used in timer handler function.
>
> Please review all of them.
>
> Best Regards
> Haojian
>

Since attachement file beyond size, I compress it and attach again.

Best Regards
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: mfd-860x.tgz
Type: application/x-gzip
Size: 21923 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091216/5573234a/attachment-0001.tgz>
