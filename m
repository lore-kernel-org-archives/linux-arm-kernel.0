From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 9 Jul 2015 12:51:58 +0100
Subject: [PATCH v2 0/9] regulator: pwm-regulator: Introduce continuous-mode
In-Reply-To: <20150709083041.3b203eb1@bbrezillon>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
 <20150709083041.3b203eb1@bbrezillon>
Message-ID: <20150709115158.GA3445@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 09 Jul 2015, Boris Brezillon wrote:
> I'm interested in this feature (so as Doug is), could you add us in Cc
> of your next submission ?

There won't be a subsequent submission, as this has already been
accepted.

> On Tue,  7 Jul 2015 16:06:44 +0100
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This patch-set has been rebased on to topic/pwm.
> >   
> > Continuous mode uses the PWM regulator's maximum and minimum supplied
> > voltages specified in the regulator-{min,max}-microvolt properties to
> > calculate appropriate duty-cycle values.  This allows for a much more
> > fine grained solution when compared with voltage-table mode, which
> > this driver already supports.  This solution does make an assumption
> > that a %50 duty-cycle value will cause the regulator voltage to run
> > at half way between the supplied max_uV and min_uV values.
> 
> Well, I'm not sure this assumption works for all pwm driven regulators.
> What if your regulator does not react linearly to the PWM duty-cycle
> config ?
> 
> How about addressing that by using all the entries of the
> voltage<->duty table association and doing the linear interpolation
> between the provided points instead of doing it on the min -> max
> range ?

If you wish to add a 3rd mode, then I'm sure Mark will accept
submissions, but I think what you are suggesting would be pretty
complex and out-of-scope of what this patch-set is trying to achieve.

As a side note, then if the voltage isn't directly proportional to the
duty cycle on a large scale i.e. max => min, then it will not likely
be very accurate between say table entries 1 => 2, or 4 => 5, etc.

What I suggest you do in your case is provide a larger table with all
of the values you find interesting, as it sounds like your PWM
regulator isn't doing what one would normally expect.

> > Lee Jones (9):
> >   ARM: multi_v7_defconfig: Enable ST's PWM driver
> >   ARM: multi_v7_defconfig: Enable ST's Power Reset driver
> >   ARM: multi_v7_defconfig: Enable support for PWM Regulators
> >   ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
> >   ARM: STi: STiH407: Add PWM Regulator node
> >   regulator: pwm-regulator: Re-write bindings
> >   regulator: pwm-regulator: Add support for continuous-voltage
> >   regulator: pwm-regulator: Simplify voltage to duty-cycle call
> >   regulator: pwm-regulator: Don't assign structure attributes right away
> > 
> >  .../bindings/regulator/pwm-regulator.txt           |  68 ++++++++++---
> >  arch/arm/boot/dts/stih407-family.dtsi              |  41 ++++++++
> >  arch/arm/boot/dts/stih407.dtsi                     |  28 ------
> >  arch/arm/configs/multi_v7_defconfig                |   3 +
> >  drivers/regulator/pwm-regulator.c                  | 109 ++++++++++++++++++---
> >  5 files changed, 198 insertions(+), 51 deletions(-)
> > 
> 
> 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
