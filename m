From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Thu, 10 May 2012 13:00:19 +0530
Subject: [PATCH 1/2] mfd: Add support for MAX77686.
In-Reply-To: <20120509182757.GB32037@sirena.org.uk>
References: <1336580695-1184-1-git-send-email-yadi.brar@samsung.com>
 <1336580695-1184-2-git-send-email-yadi.brar@samsung.com>
 <20120509182757.GB32037@sirena.org.uk>
Message-ID: <CAKew6eU2DW-GrVyfhi73SfQrYKAdLRi_bUgMWfhr6V_Tbo5dkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, May 9, 2012 at 11:57 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 09, 2012 at 09:54:54PM +0530, Yadwinder Singh wrote:
>
>> +int max77686_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest)
>> +{
>> + ? ? int ret;
>> +
>> + ? ? ret = i2c_smbus_read_byte_data(i2c, reg);
>> + ? ? if (ret < 0)
>
> It would really be better if this used the regmap API - the regulator
> API is starting to build out functionality on top of regmap which this
> won't be able to take advantage of if it doesn't use regmap.
>

I agree, I will implement it.

>> + ? ? if (of_get_property(dev->of_node, "max77686,wakeup", NULL))
>> + ? ? ? ? ? ? pd->wakeup = true;
>
> You haven't included any binding documentatiojn for the device tree
> bindings - you should do this.
>

Ok. I will add documentation in next version of patch.

>> + ? ? max77686 = kzalloc(sizeof(struct max77686_dev), GFP_KERNEL);
>> + ? ? if (max77686 == NULL) {
>> + ? ? ? ? ? ? dev_err(max77686->dev, "could not allocate memory\n");
>> + ? ? ? ? ? ? return -ENOMEM;
>> + ? ? }
>
> devm_kzalloc().
>

yes, its better option.

>> + ? ? device_init_wakeup(max77686->dev, max77686->wakeup);
>
> Why is this not just done unconditionally? ?There's sysfs files to allow
> userspace control.
>

yes, i agree with you. i will do it.

>> + ? ? if (max77686_read_reg(i2c, MAX77686_REG_DEVICE_ID, &data) < 0) {
>> + ? ? ? ? ? ? ret = -EIO;
>> + ? ? ? ? ? ? dbg_info("%s : device not found on this channel\n", __func__);
>> + ? ? ? ? ? ? goto err_mfd;
>> + ? ? } else
>> + ? ? ? ? ? ? dev_info(max77686->dev, "device found\n");
>
> You should verify that the device ID you read back is the expected one.
>

Ok, I will do that also.

>> + ? ? dev_err(max77686->dev, "device probe failed : %d\n", ret);
>
> Driver core should do this for you.
>

Yes, I will remove this message.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Thanks,
Yadwinder.
