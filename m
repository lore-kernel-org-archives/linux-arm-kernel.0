From: olivier.moysan@st.com (Olivier MOYSAN)
Date: Mon, 22 May 2017 15:11:45 +0000
Subject: [PATCH v4 2/3] ASoC: stm32: Add I2S driver
In-Reply-To: <20170519173359.277lyg6fzwksqnin@sirena.org.uk>
References: <1495120793-11687-1-git-send-email-olivier.moysan@st.com>
 <1495120793-11687-3-git-send-email-olivier.moysan@st.com>
 <20170519173359.277lyg6fzwksqnin@sirena.org.uk>
Message-ID: <3b507e82-d8d1-c2c4-8a50-ca130382171a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Thanks, for applying the patches.

On 05/19/2017 07:33 PM, Mark Brown wrote:
> On Thu, May 18, 2017 at 05:19:52PM +0200, olivier moysan wrote:
> 
> This looks good so I'm going to apply it, a few things below though -
> can you please send a followup patch for the issue with the Kconfig
> symbol?
> 
>> --- a/sound/soc/stm/Kconfig
>> +++ b/sound/soc/stm/Kconfig
>> @@ -5,4 +5,4 @@ menuconfig SND_SOC_STM32
>>   	select SND_SOC_GENERIC_DMAENGINE_PCM
>>   	select REGMAP_MMIO
>>   	help
>> -	  Say Y if you want to enable ASoC-support for STM32
>> +	  Say Y if you want to enable ASoC support for STM32
> 
> This appears to be an unrelated typo fix.
> 

ok

>> diff --git a/sound/soc/stm/Makefile b/sound/soc/stm/Makefile
>> index e466a47..8251931 100644
>> --- a/sound/soc/stm/Makefile
>> +++ b/sound/soc/stm/Makefile
>> @@ -4,3 +4,7 @@ obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai-sub.o
>>   
>>   snd-soc-stm32-sai-objs := stm32_sai.o
>>   obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai.o
>> +
>> +# I2S
>> +snd-soc-stm32-i2s-objs := stm32_i2s.o
>> +obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-i2s.o
> 
> Perhaps make this a separate option?  It probably makes sense to rename
> the option for the SAI at the same time.
> 

ok, I will fix it in a new patch.

>> +
>> +	ret = clk_prepare_enable(i2s->pclk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Enable pclk failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = clk_prepare_enable(i2s->i2sclk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Enable i2sclk failed: %d\n", ret);
>> +		goto err_pclk_disable;
>> +	}
> 
> It'd be nice to have runtime PM to disable these when the device is idle
> but that's not essential.
> 

Yes, I agree.

BRs
olivier
