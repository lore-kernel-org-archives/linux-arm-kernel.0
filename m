From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 22 May 2015 13:43:43 +0100
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <CALszF6CQ1_HQXJ8=vgytvVo2t4_ue5_nsE06HPyHMzSLrntqKg@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<2282066.NWoIT9ZyLc@wuerfel>	<CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>	<13641152.Yt4ZI3oT6L@wuerfel>	<CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>	<1432285588.3929.28.camel@pengutronix.de>	<20150522091822.GF8557@lukather>	<1432289231.3929.60.camel@pengutronix.de>
 <CALszF6CQ1_HQXJ8=vgytvVo2t4_ue5_nsE06HPyHMzSLrntqKg@mail.gmail.com>
Message-ID: <555F247F.9060100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/05/15 13:32, Maxime Coquelin wrote:
> 2015-05-22 12:07 GMT+02:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> And that's how I'd expect it to be described by the device tree:
>>
>>      rcc: rcc at 40023800 {
>>          compatible = "st,stm32-rcc";
>>          reg = <0x40023800 0xc0>;
>>      };
>>
>
> Doing that, since this register bank contains both reset and clock
> registers, the reset device cannot get the IO resource at probe time
> because the clock driver has already reserved it.
> Daniel, who has started to work on the clock driver is facing this issue.
> This is why I proposed this binding for "reg" property.

Temporarily I've kept things working for me by avoiding 
of_io_request_and_map() in the clock driver (I am using raw of_iomap() 
instead).

I view this as a hack rather than a solution!

Note that, with or without the hack, I do hope to be able to post the 
clock driver this weekend. I am acutely aware that at the moment we are 
discussing code I haven't posted yet.


> We could think of creating a MFD driver, but the problem is that clock
> need to be intialized before a MFD device can be probed.
>
> Maybe there is a way to have you binding working properly, but I
> haven't found one for now.

I guess a driver doesn't *have* to reserve all the register space 
described in DT. The driver could replace of_io_request_and_map() with 
lower level calls.

Thus if we wanted to keep this detail out of DT then I guess the two 
drivers could simply make an agreement not to request registers they do 
not use.
