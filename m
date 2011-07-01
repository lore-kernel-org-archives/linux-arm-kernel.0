From: joravec@drewtech.com (Joey Oravec)
Date: Fri, 01 Jul 2011 15:14:48 -0400
Subject: plat-orion multi purpose pins problem for mv78200
Message-ID: <4E0E1CA8.7090200@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicola, Lennert -

There's a problem in 3.0-rc5 when calling mv78xx0_mpp_conf() on the 
MV78200 processor. This processor has 49 multi purpose pins but only 31 
GPIOs. MPP[31:0] map directly to GPIO[31:0] but the next 17 are a little 
more complex:

MPP[39:32] = GPIO[7:0]
MPP[46:40] = GPIO[23:17]
MPP[47] = GPIO[16]
MPP[48] = GPIO[8]
MPP[49] = GPIO[9]

See arch/arm/plat-orion/mpp.c. Inside orion_mpp_conf() the array gets 
processed by calling MPP_NUM() then calling orion_gpio_set_valid(). As 
demonstrated above, the MPP number and GPIO number are not 
interchangeable and on the MV78200 that's a problem when trying to setup 
any MPP > 31.

So we need to map each MPP to a given GPIO -- I don't know how the 
mapping will differ across processors. We also need to keep-clear which 
functions are called with an MPP number and which functions are called 
with a GPIO number.

Followup question -- Marvell has several SoC families, but Linux uess 
plat-orion for everything. For example MV78200 isn't an Orion it's a 
Discovery Innovation series. Would it make more sense to have separate 
plat-* code for the separate families?

-joey
