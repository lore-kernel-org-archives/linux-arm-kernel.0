From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 28 Aug 2014 20:32:25 +0300
Subject: [PATCH v2 0/3] gpio: syscon: reuse for keystone 2 socs
In-Reply-To: <1408639874.873856101@f420.i.mail.ru>
References: <53ECE9B1.4060303@ti.com>
 <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
 <1408639874.873856101@f420.i.mail.ru>
Message-ID: <53FF67A9.4080504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander, All,

On 08/21/2014 07:51 PM, Alexander Shiyan wrote:
> Thu, 21 Aug 2014 19:23:20 +0300 ?? Grygorii Strashko <grygorii.strashko@ti.com>:
>> Hi All,
>>
>> Alexander,
>>
>> I've updated gpio-syscon as requested in [3].
>> I still don't like it, but any way I did it :(
>>
>> Linus,
>>
>> I'd very appreciated if you can comment on these series.
>> Personally, I like v1 [3], because this v2 is not elegant and will
>> require constant code patching in case of adding new SoCs or new SoC's versions.
>>
>> This series intended to integrate Keystone 2 DSP GPIO controller functionality
>> into gpio-syscon driver (drivers/gpio/gpio-syscon.c) as requested
>> by Linus Walleij in [1].
>>
>> On Keystone SOCs, ARM host can send interrupts to DSP cores using the
>> DSP GPIO controller IP. Each DSP GPIO controller provides 28 IRQ signals for
>> each DSP core. This is one of the component used by the IPC mechanism used
>> on Keystone SOCs.
>>
>> Keystone 2 DSP GPIO controller has specific features:
>> - each GPIO can be configured only as output pin;
>> - setting GPIO value to 1 causes IRQ generation on target DSP core;
>> - reading pin value returns 0 - if IRQ was handled or 1 - IRQ is still
>>    pending.
>>
>> The gpio-syscon driver was need to be updated to satisfy Keystone 2 SoC
>> requirements:
>> - special sequence of operations need to be used to assign output GPIO value.
>>     As result, first patch introduces SoC specific callback .set() to configure
>>     output GPIO value.
>>
>> Also, patch 3 was added to illustrate DSP GPIO configuration in DT used by Keystone 2.
>>
>> Related sicussions:
>>   [1] https://lkml.org/lkml/2014/7/16/170
>>   [2] https://lkml.org/lkml/2014/7/23/352
>>   [3] https://www.mail-archive.com/devicetree at vger.kernel.org/msg37863.html
>>
>> Grygorii Strashko (3):
>>    gpio: syscon: add soc specific callback to assign output value
>>    gpio: syscon: reuse for keystone 2 socs
>>    ARM: dts: keystone-k2hk: add dsp gpio controllers nodes
>>
>>   .../bindings/gpio/gpio-mctrl-keystone.txt          |   42 ++++++
>>   arch/arm/boot/dts/k2hk.dtsi                        |   48 +++++++
>>   drivers/gpio/gpio-syscon.c                         |  140 ++++++++++++++++++++
>>   3 files changed, 230 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt
> 
> 1. mctrl -> dsp in filenames
> 2. mctrl -> dsp in documentation.
> 3. Here is a more elegant solution for first part.
> 
> --- gpio-syscon.c.old	2014-08-19 09:46:09.000000000 +0400
> +++ gpio-syscon.c	2014-08-21 20:45:49.357529323 +0400
> @@ -111,7 +111,7 @@
>   				   BIT(offs % SYSCON_REG_BITS));
>   	}
>   
> -	syscon_gpio_set(chip, offset, val);
> +	priv->data->set(chip, offset, val);
>   
>   	return 0;
>   }
> @@ -159,7 +159,7 @@
>   	if (priv->data->flags & GPIO_SYSCON_FEAT_IN)
>   		priv->chip.direction_input = syscon_gpio_dir_in;
>   	if (priv->data->flags & GPIO_SYSCON_FEAT_OUT) {
> -		priv->chip.set = syscon_gpio_set;
> +		priv->chip.set = priv->data->set ? : syscon_gpio_set;
>   		priv->chip.direction_output = syscon_gpio_dir_out;
>   	}

yep. It's better.

Thanks for your comments.
I'll wait few days with hope to get some comments from comunity
(as I'm still thinking v1 is better :) then will update it and re-send.

Regards,
-grygorii
