From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Dec 2016 12:30:58 +0100
Subject: [PATCH v3 4/7] PWM: add pwm driver for stm32 plaftorm
In-Reply-To: <CA+M3ks7_utdw1c0A0m+RzuPTfvFAv5d8HoQvQDzXwHR8M6RKJA@mail.gmail.com>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-5-git-send-email-benjamin.gaignard@st.com>
 <20161205072357.GB18069@ulmo.ba.sec>
 <CA+M3ks7_utdw1c0A0m+RzuPTfvFAv5d8HoQvQDzXwHR8M6RKJA@mail.gmail.com>
Message-ID: <20161205113058.GG19891@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 12:02:45PM +0100, Benjamin Gaignard wrote:
> 2016-12-05 8:23 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> > On Fri, Dec 02, 2016 at 11:17:19AM +0100, Benjamin Gaignard wrote:
> >> This driver add support for pwm driver on stm32 platform.
> >
> > "adds". Also please use PWM in prose because it's an abbreviation.
> >
> >> The SoC have multiple instances of the hardware IP and each
> >> of them could have small differences: number of channels,
> >> complementary output, counter register size...
> >> Use DT parameters to handle those differentes configuration
> >
> > "different configurations"
> 
> ok
> 
> >
> >>
> >> version 2:
> >> - only keep one comptatible
> >> - use DT paramaters to discover hardware block configuration
> >
> > "parameters"
> 
> ok
> 
> >
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>  drivers/pwm/Kconfig     |   8 ++
> >>  drivers/pwm/Makefile    |   1 +
> >>  drivers/pwm/pwm-stm32.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 294 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-stm32.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index bf01288..a89fdba 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -388,6 +388,14 @@ config PWM_STI
> >>         To compile this driver as a module, choose M here: the module
> >>         will be called pwm-sti.
> >>
> >> +config PWM_STM32
> >> +     bool "STMicroelectronics STM32 PWM"
> >> +     depends on ARCH_STM32
> >> +     depends on OF
> >> +     select MFD_STM32_GP_TIMER
> >
> > Should that be a "depends on"?
> 
> I think select is fine because the wanted feature is PWM not the mfd part

I think in that case you may want to hide the MFD Kconfig option. See
Documentation/kbuild/kconfig-language.txt (notes about select) for the
details.

[...]
> >> +};
> >> +
> >> +#define to_stm32_pwm_dev(x) container_of(chip, struct stm32_pwm_dev, chip)
> >
> > Please turn this into a static inline.
> 
> with putting struct pwm_chip as first filed I will just cast the structure

Don't do that, please. container_of() is still preferred because it is
correct and won't break even if you (or somebody else) changes the order
in the future. The fact that it might be optimized away is a detail, or
a micro-optimization. Force-casting is a bad idea because it won't catch
errors if for some reason the field doesn't remain in the first position
forever.

> >> +static void stm32_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >> +{
> >> +     u32 mask;
> >> +     struct stm32_pwm_dev *dev = to_stm32_pwm_dev(chip);
> >> +
> >> +     /* Disable channel */
> >> +     mask = TIM_CCER_CC1E << (pwm->hwpwm * 4);
> >> +     if (dev->caps & CAP_COMPLEMENTARY)
> >> +             mask |= TIM_CCER_CC1NE << (pwm->hwpwm * 4);
> >> +
> >> +     regmap_update_bits(dev->regmap, TIM_CCER, mask, 0);
> >> +
> >> +     /* When all channels are disabled, we can disable the controller */
> >> +     if (!__active_channels(dev))
> >> +             regmap_update_bits(dev->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> >> +
> >> +     clk_disable(dev->clk);
> >> +}
> >
> > All of the above can be folded into the ->apply() hook for atomic PWM
> > support.
> >
> > Also, in the above you use clk_enable() in the ->enable() callback and
> > clk_disable() in ->disable(). If you need the clock to access registers
> > you'll have to enabled it in the others as well because there are no
> > guarantees that configuration will only happen between ->enable() and
> > ->disable(). Atomic PWM simplifies this a bit, but you still need to be
> > careful about when to enable the clock in your ->apply() hook.
> 
> I have used regmap functions enable/disable clk for me when accessing to
> the registers.
> I only have to take care of clk enable/disable when PWM state change.

Okay, that's fine then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/79897d78/attachment.sig>
