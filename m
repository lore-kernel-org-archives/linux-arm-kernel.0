From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Fri, 17 Mar 2017 14:52:44 +0100
Subject: [PATCH 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <6ae90186-0e8d-654b-c9e3-2d1b4daf6198@baylibre.com>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com>
 <6ae90186-0e8d-654b-c9e3-2d1b4daf6198@baylibre.com>
Message-ID: <CAOAejn0Hs7QOgcrHM2t3NsFQeD9dyvThDK-8iM1Lvb7Qv4fGGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


>> +static int stm32f7_i2c_hw_config(struct stm32f7_i2c_dev *i2c_dev)
>> +{
>> +     struct device_node *of_node = i2c_dev->dev->of_node;
>> +     u32 timing;
>> +     int ret;
>> +
>> +     ret = of_property_read_u32(of_node, "st,i2c-timing", &timing);
>> +     if (ret) {
>> +             dev_err(i2c_dev->dev, "Error: missing i2c timing property\n");
>> +             return ret;
>> +     }
>> +
>> +     /* Timing settings */
>> +     writel_relaxed(timing, i2c_dev->base + STM32F7_I2C_TIMINGR);
>
> Hi,
>
> Using a register value in DT is quite ugly since the requirement to calculate the timings
> is quite easy, and well documented.
>
> I wrote it for Zephyr, you can find it here :
> https://github.com/zephyrproject-rtos/zephyr/blob/master/drivers/i2c/i2c_stm32lx.c#L31

Thanks for this code. It is very interesting.
With our formula, I just notice that we don't use any i2c rise time or
fall time but they have some impacts in i2c timing computation.
So, the user could not be able to select these values for him use case. Right ?


>
> Another point, maybe you should find a better name for the driver, since this I2C IP is share
> with the STM32Lx also and is not tied to STM32F7.

As far as I know, we don't have any STM32Lx SoC integrated in the
linux kernel mainline.
I choose i2c-stm32f7 name as it is the first Soc integrated in the
linux kernel mainline where this IP could be used.

BR,
Cedric
