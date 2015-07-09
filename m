From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 9 Jul 2015 08:30:41 +0200
Subject: [PATCH v2 0/9] regulator: pwm-regulator: Introduce continuous-mode
In-Reply-To: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150709083041.3b203eb1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

I'm interested in this feature (so as Doug is), could you add us in Cc
of your next submission ?

On Tue,  7 Jul 2015 16:06:44 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> This patch-set has been rebased on to topic/pwm.
>   
> Continuous mode uses the PWM regulator's maximum and minimum supplied
> voltages specified in the regulator-{min,max}-microvolt properties to
> calculate appropriate duty-cycle values.  This allows for a much more
> fine grained solution when compared with voltage-table mode, which
> this driver already supports.  This solution does make an assumption
> that a %50 duty-cycle value will cause the regulator voltage to run
> at half way between the supplied max_uV and min_uV values.

Well, I'm not sure this assumption works for all pwm driven regulators.
What if your regulator does not react linearly to the PWM duty-cycle
config ?

How about addressing that by using all the entries of the
voltage<->duty table association and doing the linear interpolation
between the provided points instead of doing it on the min -> max
range ?

Best Regards,

Boris

> 
> Lee Jones (9):
>   ARM: multi_v7_defconfig: Enable ST's PWM driver
>   ARM: multi_v7_defconfig: Enable ST's Power Reset driver
>   ARM: multi_v7_defconfig: Enable support for PWM Regulators
>   ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
>   ARM: STi: STiH407: Add PWM Regulator node
>   regulator: pwm-regulator: Re-write bindings
>   regulator: pwm-regulator: Add support for continuous-voltage
>   regulator: pwm-regulator: Simplify voltage to duty-cycle call
>   regulator: pwm-regulator: Don't assign structure attributes right away
> 
>  .../bindings/regulator/pwm-regulator.txt           |  68 ++++++++++---
>  arch/arm/boot/dts/stih407-family.dtsi              |  41 ++++++++
>  arch/arm/boot/dts/stih407.dtsi                     |  28 ------
>  arch/arm/configs/multi_v7_defconfig                |   3 +
>  drivers/regulator/pwm-regulator.c                  | 109 ++++++++++++++++++---
>  5 files changed, 198 insertions(+), 51 deletions(-)
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
