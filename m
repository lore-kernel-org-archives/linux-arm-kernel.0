From: joravec@drewtech.com (Joey Oravec)
Date: Fri, 01 Jul 2011 17:56:57 -0400
Subject: plat-orion multi purpose pins problem for mv78200
In-Reply-To: <4E0E1CA8.7090200@drewtech.com>
References: <4E0E1CA8.7090200@drewtech.com>
Message-ID: <4E0E42A9.8010306@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It looks like there's a second problem here. Imagine you're calling 
mv78xx0_mpp_conf() and the array has these entries:

MPP16_GPIO
MPP47_UNUSED

These are separate MPP pins that can each bring out the same GPIO 
resource. Notice that as the code stands today, the second call is going 
to clobber the values valid_input and valid_output for GPIO[16]. The 
logic for orion_gpio_is_valid() needs to check if a given GPIO is 
brought-out on any MPP pin.

In the short term, it might be worth disabling the check in 
orion_gpio_is_valid() to avoid the bug.

-joey

On 7/1/2011 3:14 PM, Joey Oravec wrote:
> Nicola, Lennert -
>
> There's a problem in 3.0-rc5 when calling mv78xx0_mpp_conf() on the 
> MV78200 processor. This processor has 49 multi purpose pins but only 
> 31 GPIOs. MPP[31:0] map directly to GPIO[31:0] but the next 17 are a 
> little more complex:
>
> MPP[39:32] = GPIO[7:0]
> MPP[46:40] = GPIO[23:17]
> MPP[47] = GPIO[16]
> MPP[48] = GPIO[8]
> MPP[49] = GPIO[9]
>
> See arch/arm/plat-orion/mpp.c. Inside orion_mpp_conf() the array gets 
> processed by calling MPP_NUM() then calling orion_gpio_set_valid(). As 
> demonstrated above, the MPP number and GPIO number are not 
> interchangeable and on the MV78200 that's a problem when trying to 
> setup any MPP > 31.
>
> So we need to map each MPP to a given GPIO -- I don't know how the 
> mapping will differ across processors. We also need to keep-clear 
> which functions are called with an MPP number and which functions are 
> called with a GPIO number.
>
> Followup question -- Marvell has several SoC families, but Linux uess 
> plat-orion for everything. For example MV78200 isn't an Orion it's a 
> Discovery Innovation series. Would it make more sense to have separate 
> plat-* code for the separate families?
>
> -joey
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
