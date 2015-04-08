From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 08 Apr 2015 18:14:18 +0800
Subject: [PATCH] ASoC: max98090: add shutdown callback for max98090
In-Reply-To: <15530630.jvXTF4Jl8n@diego>
References: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
 <1428483128-23498-2-git-send-email-wxt@rock-chips.com>
 <15530630.jvXTF4Jl8n@diego>
Message-ID: <5524FF7A.1090802@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

? 2015?04?08? 17:25, Heiko St?bner ??:
> Hi Caesar,
>
> Am Mittwoch, 8. April 2015, 16:52:08 schrieb Caesar Wang:
>> To fix pop noise when shutdown,the pop noise during shutdown
>> is the pmic cutoff power of codec without any notice.
>>
>> Signed-off-by: jay.xu <xjq@rock-chips.com>
>> Signed-off-by: zhengxing <zhengxing@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>
>> Serien-cc: linux-kernel at vger.kernel.org
>> Serien-cc: devicetree at vger.kernel.org
>> Serien-cc: dianders at chromium.org
>>
>> ---
>>
>>   sound/soc/codecs/max98090.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
>> index b112b1c..066954a0 100644
>> --- a/sound/soc/codecs/max98090.c
>> +++ b/sound/soc/codecs/max98090.c
>> @@ -2611,6 +2611,22 @@ static int max98090_i2c_remove(struct i2c_client
>> *client) return 0;
>>   }
>>
>> +static void max98090_i2c_shutdown(struct i2c_client *i2c)
>> +{
>> +	struct max98090_priv *max98090 = dev_get_drvdata(&i2c->dev);
>> +
>> +	dev_info(&i2c->dev, "shut down device\n");
> is this dev_info really necessary? dev_dbg might be better, or leave it out
> completely, as it doesn't really provide any additional benefit.
>

As Mark suggestion, I will remove it.
>> +
>> +	/* Enable volume smoothing, disable zero cross.  This will cause
>> +	 * a quick 40ms ramp to mute on shutdown.
>> +	 */
> Comment style is off ... should be
>
> /*
>   * Enable volume smoothing, disable zero cross.  This will cause
>   * a quick 40ms ramp to mute on shutdown.
>   */
>

Done
>> +	regmap_write(max98090->regmap,
>> +		M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
>> +	regmap_write(max98090->regmap,
>> +		M98090_REG_DEVICE_SHUTDOWN, 0x00);
>> +	msleep(40);
>> +}
>> +
>>   #ifdef CONFIG_PM
>>   static int max98090_runtime_resume(struct device *dev)
>>   {
>> @@ -2697,6 +2713,7 @@ static struct i2c_driver max98090_i2c_driver = {
>>   	},
>>   	.probe  = max98090_i2c_probe,
>>   	.remove = max98090_i2c_remove,
>> +	.shutdown = max98090_i2c_shutdown,
>>   	.id_table = max98090_i2c_id,
>>   };
>
>
>

-- 
**************************************************************************************
???    Caesar Wang
??????   Product R&D Dept.III
??????????? Fuzhou Rockchip Electronics Co.Ltd
????????????????89????A?18?? ??????
         ???????????????21? ???????
Addr?  NO.18 Building, A District, Fuzhou Software Park,Gulou District,Fuzhou, Fujian,China(Fuzhou Headquarters)
          21F,Malata Building,Kejizhongyi Avenue,Nanshan District,Shenzhen  (Shenzhen Office)
Tel?+86-591-83991906/07 - 8221
Mobile:+86 15059456742
E-mail : wxt at rock-chips.com
***************************************************************************************
***************************************************************************************
???????????????????????????????????????????????? ??????????????
??????????????????????????????????????????????????????????????
??????????????????????????
  
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may
contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA.
If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the
information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material
in its entirety in any format. Thank you.
***************************************************************************************
