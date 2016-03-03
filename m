From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 2 Mar 2016 20:38:54 -0800
Subject: [PATCH v3 2/3] hwmon: Create an NSA320 hardware monitoring driver
In-Reply-To: <56D77AA4.2080908@baker-net.org.uk>
References: <1456698614-15176-1-git-send-email-linux@baker-net.org.uk>
 <1456698614-15176-3-git-send-email-linux@baker-net.org.uk>
 <56D3948D.6000805@roeck-us.net> <56D77AA4.2080908@baker-net.org.uk>
Message-ID: <56D7BFDE.8090804@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2016 03:43 PM, Adam Baker wrote:
> On 29/02/16 00:45, Guenter Roeck wrote:
>
>>> +
>>> +/*
>>> + * Although this protocol looks similar to SPI the long delay
>>> + * between the active (aka chip select) signal and the shorter
>>> + * delay between clock pulses are needed for reliable operation.
>>> + * The delays provided are taken from the manufacturer kernel,
>>> + * testing suggest they probably incorporate a reasonable safety
>>> + * margin. (The single device tested became unreliable if the
>>> + * delay was reduced to 1/10th of this value.)
>>> + */
>>> +static unsigned long nsa320_hwmon_update(struct device *dev)
>>
>> Please make this either int or s32.
>>
>>> +{
>>> +    u32 mcu_data;
>>
>> You can (and should) still use u32 here.
>>
>
>
> I'm a bit puzzled by your reasoning for preferring a signed value for the return value. The only reason I can think of is that the error return value is negative, however the macro to test if it is an error value is not looking at whether the value is negative
>
> #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
>
> Functionally using any of s32, int or unsigned long will make no difference, the mask operations ensure that the top bit can't possibly be set so using a signed type doesn't, in this circumstance, risk an undefined result from the shift operation. The choice of type is therefore a matter of readability rather than function so if you still prefer s32 I'll respin it to use that.
>

IS_ERR_VALUE _only_ works with unsigned long if sizeof(long) = sizeof(int).
Someone may at some point in the future not realize this and change the function
return value to unsigned int or u32, thinking that an unsigned long is unnecessary,
and introduce a bug. Many users of IS_ERR_VALUE in the kernel actually
suffer from this problem. I prefer code which is less prone to such
unintentionally introduced problems.

I also dislike using unsigned variables to return negative error codes unless
there is a really good reason for doing it. Such a reason does not exist here.

Guenter
