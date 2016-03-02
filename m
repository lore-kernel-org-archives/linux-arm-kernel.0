From: linux@baker-net.org.uk (Adam Baker)
Date: Wed, 2 Mar 2016 23:43:32 +0000
Subject: [PATCH v3 2/3] hwmon: Create an NSA320 hardware monitoring driver
In-Reply-To: <56D3948D.6000805@roeck-us.net>
References: <1456698614-15176-1-git-send-email-linux@baker-net.org.uk>
 <1456698614-15176-3-git-send-email-linux@baker-net.org.uk>
 <56D3948D.6000805@roeck-us.net>
Message-ID: <56D77AA4.2080908@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/02/16 00:45, Guenter Roeck wrote:

>> +
>> +/*
>> + * Although this protocol looks similar to SPI the long delay
>> + * between the active (aka chip select) signal and the shorter
>> + * delay between clock pulses are needed for reliable operation.
>> + * The delays provided are taken from the manufacturer kernel,
>> + * testing suggest they probably incorporate a reasonable safety
>> + * margin. (The single device tested became unreliable if the
>> + * delay was reduced to 1/10th of this value.)
>> + */
>> +static unsigned long nsa320_hwmon_update(struct device *dev)
>
> Please make this either int or s32.
>
>> +{
>> +    u32 mcu_data;
>
> You can (and should) still use u32 here.
>


I'm a bit puzzled by your reasoning for preferring a signed value for 
the return value. The only reason I can think of is that the error 
return value is negative, however the macro to test if it is an error 
value is not looking at whether the value is negative

#define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)

Functionally using any of s32, int or unsigned long will make no 
difference, the mask operations ensure that the top bit can't possibly 
be set so using a signed type doesn't, in this circumstance, risk an 
undefined result from the shift operation. The choice of type is 
therefore a matter of readability rather than function so if you still 
prefer s32 I'll respin it to use that.

The length does need to be at least 32 bits (to represent the returned 
data range) and no longer than unsigned long (to avoid breaking 
IS_ERR_VALUE). Whilst int is 32 bits on the only processor that is 
expected to use this device that doesn't feel like a good thing to 
depend upon so s32 seems preferable to int.

Regards

Adam
