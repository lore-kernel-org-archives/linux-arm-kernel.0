From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 12 Jun 2013 13:13:59 +0530
Subject: [PATCH 03/11] gpio: davinci: Modify to platform driver
In-Reply-To: <518397C60809E147AF5323E0420B992E3EAD9D75@DBDE04.ent.ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-4-git-send-email-avinashphilip@ti.com>
 <51B71056.9010103@ti.com>
 <518397C60809E147AF5323E0420B992E3EAD9D75@DBDE04.ent.ti.com>
Message-ID: <51B826BF.7050009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/11/2013 6:25 PM, Philip, Avinash wrote:

> On Tue, Jun 11, 2013 at 17:26:06, Nori, Sekhar wrote:

>> On 5/22/2013 12:40 PM, Philip Avinash wrote:

>>> @@ -179,13 +204,10 @@ static int __init davinci_gpio_setup(void)
>>>  		gpiochip_add(&ctlrs[i].chip);
>>>  	}
>>>  
>>> -	soc_info->gpio_ctlrs = ctlrs;
>>
>>> -	soc_info->gpio_ctlrs_num = DIV_ROUND_UP(ngpio, 32);
>>
>> You drop setting gpio_ctlrs_num here and don't introduce it anywhere
>> else in the patchset so in effect you render the inline gpio get/set API
>> useless. Looks like this initialization should be moved to platform code?
> 
> With [PATCH 08/11] ARM: davinci: start using gpiolib support gpio get/set API
> Has no more dependency on soc_info->gpio_ctlrs_num.

With this series, you have removed support for inline gpio get/set API.
I see that the inline functions are still available for use on
tnetv107x. I wonder why it is important to keep these for tnetv107x when
not necessary for other DaVinci devices?

When you are removing this feature, please note it prominently in your
cover letter and patch description. Also, please provide some data on
how the latency now compares to that of inline access earlier. This is
important especially for the read. For the writes, gpio clock will
mostly determine how soon the value changes on the pin.

I am okay with removing the inline access feature. It helps simplify
code and most arm machines don't use them. I would just like to see some
data for justification as this can be seen as feature regression. Also,
if we are removing it, its better to also remove it completely and get
the LOC savings instead of just stopping its usage.

Thanks,
Sekhar
