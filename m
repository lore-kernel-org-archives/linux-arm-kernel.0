From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Mar 2017 15:53:18 +0100
Subject: [PATCH 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <CAOAejn0Hs7QOgcrHM2t3NsFQeD9dyvThDK-8iM1Lvb7Qv4fGGQ@mail.gmail.com>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com>
 <6ae90186-0e8d-654b-c9e3-2d1b4daf6198@baylibre.com>
 <CAOAejn0Hs7QOgcrHM2t3NsFQeD9dyvThDK-8iM1Lvb7Qv4fGGQ@mail.gmail.com>
Message-ID: <971895d3-2fe6-ecb6-9dc3-ee71193b34ee@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2017 02:52 PM, M'boumba Cedric Madianga wrote:
> Hi,
> 
> 
>>> +static int stm32f7_i2c_hw_config(struct stm32f7_i2c_dev *i2c_dev)
>>> +{
>>> +     struct device_node *of_node = i2c_dev->dev->of_node;
>>> +     u32 timing;
>>> +     int ret;
>>> +
>>> +     ret = of_property_read_u32(of_node, "st,i2c-timing", &timing);
>>> +     if (ret) {
>>> +             dev_err(i2c_dev->dev, "Error: missing i2c timing property\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     /* Timing settings */
>>> +     writel_relaxed(timing, i2c_dev->base + STM32F7_I2C_TIMINGR);
>>
>> Hi,
>>
>> Using a register value in DT is quite ugly since the requirement to calculate the timings
>> is quite easy, and well documented.
>>
>> I wrote it for Zephyr, you can find it here :
>> https://github.com/zephyrproject-rtos/zephyr/blob/master/drivers/i2c/i2c_stm32lx.c#L31
> 
> Thanks for this code. It is very interesting.
> With our formula, I just notice that we don't use any i2c rise time or
> fall time but they have some impacts in i2c timing computation.
> So, the user could not be able to select these values for him use case. Right ?

Sorry I don't understand.
The value you use from the DT and the one calculated from the setup/hold/high/low value
with the algorithm I developed will set the same values.

The main difference is that you won't need the ST tool to calculate these, and even better
you can provide generic binding for whatever APB frequency the I2C peripheral is running
on.

> 
> 
>>
>> Another point, maybe you should find a better name for the driver, since this I2C IP is share
>> with the STM32Lx also and is not tied to STM32F7.
> 
> As far as I know, we don't have any STM32Lx SoC integrated in the
> linux kernel mainline.
> I choose i2c-stm32f7 name as it is the first Soc integrated in the
> linux kernel mainline where this IP could be used.

Having the STM32L4 running mainline won't be hard, maybe useless, but not hard.
My point is that you can somehow consider the STM32F0/F1/F4 I2C IP to be "v1" or "gen1",
and the L0/L4/F6 (and H7 ?) to be "v2" or "gen2" then prepend a generic compatible to
have something like :
compatible = "st,stm32-i2c-v2", "st,stm32f7-i2c"

> BR,
> Cedric
> 

Thanks,
Neil
