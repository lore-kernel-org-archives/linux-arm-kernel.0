From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 23 Feb 2012 20:25:42 +1100
Subject: [PATCH v3 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <20120223081459.GD8621@avionic-0098.mockup.avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-7-git-send-email-thierry.reding@avionic-design.de>
 <4F459A94.4030104@gmail.com>
 <20120223081459.GD8621@avionic-0098.mockup.avionic-design.de>
Message-ID: <4F460616.3080400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/12 19:14, Thierry Reding wrote:

> * Ryan Mallon wrote:
>> On 23/02/12 02:17, Thierry Reding wrote:
>>
>>> This commit adds a generic PWM framework driver for the PWFM controller
>>> found on NVIDIA Tegra SoCs. The driver is based on code from the
>>> Chromium kernel tree and was originally written by Gary King (NVIDIA)
>>> and later modified by Simon Que (Chromium).
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>>> ---
>>
>> <snip>
>>
>>> +
>>> +	pwm->chip.dev = &pdev->dev;
>>> +	pwm->chip.ops = &tegra_pwm_ops;
>>> +	pwm->chip.base = -1;
>>> +	pwm->chip.npwm = NUM_PWM;
>>
>>> +
>>> +	ret = pwmchip_add(&pwm->chip);
>>
>>
>> If a driver fails to initialise the pwm_chip structure correctly it can
>> cause problems in the pwm core. For example, if the dev field doesn't
>> get set, then you will get an oops if you try to cat the pwm debugfs file.
>>
>> pwmchip_add should probably verify that the initialisation of the
>> pwm_chip structure is sane to avoid problems like this.
> 
> Absolutely. What would be the best response to an invalid struct pwm_chip? I
> suppose at least returning -EINVAL, perhaps complemented with WARN_ON?


Just returning -EINVAL should be okay. I don't think you need a WARN_ON,
since failing to register the hardware should be enough of a reason for
a user to report a problem.

~Ryan
