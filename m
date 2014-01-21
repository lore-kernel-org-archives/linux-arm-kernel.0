From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 21 Jan 2014 05:09:22 +0100
Subject: pinctrl: at91: drive strength control
In-Reply-To: <CAJjB1qKAeMOdP03v85ZPcvxvS96A+_-HzO0565wtaKK8278guw@mail.gmail.com>
References: <1390266470.26159.1.camel@bb>
 <20140121021925.GM9558@ns203013.ovh.net>
 <CAJjB1qKAeMOdP03v85ZPcvxvS96A+_-HzO0565wtaKK8278guw@mail.gmail.com>
Message-ID: <20140121040922.GN9558@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:34 Mon 20 Jan     , Mark Roszko wrote:
> If I choose it at runtime what's the best way for me to detect the SoC
> type to choose the correct register address at runtime? Only way I see
> is adding new compatible types for the SAMA5s and the SAM9s with the
> registers.
>

we could do it via cpu_is as a check as we may have older dts
but it's better to do it via compatible
> On Mon, Jan 20, 2014 at 9:19 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 20:07 Mon 20 Jan     , Marek Roszko wrote:
> >> Hello Nick and Jean-Christophe,
> >>
> >> I submit a idea/patch for comments. The current pintctrl driver is missing the ability to set the drive strength in the SAMA5D3s and a few of the SAM9s.
> >> A little feature I myself need for the SAMA5D3s because somebody let an analog engineer do the hardware design.
> >>
> >> Issues with this patch I need help with:
> >> 1. Atmel for some reason shifted the PIO_DRIVER1 and PIO_DRIVER2 registers by one register address between the SAM9 chips and the SAMA5D3s
> >>
> >> i.e. this is the SAM9s
> >> #define PIO_DRIVER1_V1 0x114
> >> #define PIO_DRIVER2_V1 0x118
> >>
> >> this is the SAMA5D3s
> >> #define PIO_DRIVER1_V2 0x118
> >> #define PIO_DRIVER2_V2 0x11C
> >>
> >>
> >> 2. Atmel changed the meaning of value of "low", "medium" and "high" drive strengths between the two sets of chips as well.
> >>
> >> SAM9s do:
> >> 00 = high
> >> 01 = medium
> >> 10 = low
> >> 11 = reserved/undefined
> >>
> >> SAMA5D3s do:
> >> 00 = low
> >> 01 = low
> >> 10 = medium
> >> 11 = high
> >>
> >> 3. The SAM9G25, SAM9G35 have the PIO_DRIVER but the SAM9G45 does not have the PIO_DRIVER register as an example of
> >> how oddly the behavior doesn't appear everywhere. This could also be because the datasheets for the G45 and G46 are
> >> not updated to the new style while the others already have been?
> >>
> >> Side note: The SAMA5D3 datasheet says the default drive strength is "low" with register values 0x00000000,
> >> in reality the default is "medium" with 0xAAAAAAAA as the default value.
> >> Confirmed with the JLINK debugger and by Atmel support. Not an real issue, just a note when testing.
> >
> > check the coding style tab for indentatnion, 80 charrs per line max etc...
> >>
> >>
> >> So the only simple way I see is to #ifdef the SOC type/chip.
> >> There's probably better far better ways I don't know.
> >>
> >> ---
> >>  arch/arm/mach-at91/include/mach/at91_pio.h |    9 +++++
> >>  drivers/pinctrl/pinctrl-at91.c             |   54 +++++++++++++++++++++++++++-
> >>  include/dt-bindings/pinctrl/at91.h         |   13 +++++++
> >>  3 files changed, 75 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mach-at91/include/mach/at91_pio.h b/arch/arm/mach-at91/include/mach/at91_pio.h
> >> index 732b11c..28e8801 100644
> >> --- a/arch/arm/mach-at91/include/mach/at91_pio.h
> >> +++ b/arch/arm/mach-at91/include/mach/at91_pio.h
> >> @@ -66,6 +66,15 @@
> >>  #define PIO_FRLHSR   0xd8    /* Fall/Rise - Low/High Status Register */
> >>  #define PIO_SCHMITT  0x100   /* Schmitt Trigger Register */
> >>
> >> +/*
> >> + * SoC Specific PIO Address Offsets
> >> + */
> >> +#define PIO_DRIVER1_V1               0x114
> >> +#define PIO_DRIVER2_V1               0x118
> >> +
> >> +#define PIO_DRIVER1_V2               0x118
> >> +#define PIO_DRIVER2_V2               0x11C
> >> +
> >>  #define ABCDSR_PERIPH_A      0x0
> >>  #define ABCDSR_PERIPH_B      0x1
> >>  #define ABCDSR_PERIPH_C      0x2
> >> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> >> index a7549c4..ccf456e 100644
> >> --- a/drivers/pinctrl/pinctrl-at91.c
> >> +++ b/drivers/pinctrl/pinctrl-at91.c
> >> @@ -62,10 +62,37 @@ static int gpio_banks;
> >>  #define DEGLITCH     (1 << 2)
> >>  #define PULL_DOWN    (1 << 3)
> >>  #define DIS_SCHMIT   (1 << 4)
> >> +#define SET_DRIVE_STRENGTH  (1 << 5)
> >> +#define DRIVE_STRENGTH_SHIFT    6
> >> +#define DRIVE_STRENGTH   (0x3 << DRIVE_STRENGTH_SHIFT)
> >>  #define DEBOUNCE     (1 << 16)
> >>  #define DEBOUNCE_VAL_SHIFT   17
> >>  #define DEBOUNCE_VAL (0x3fff << DEBOUNCE_VAL_SHIFT)
> >>
> >> +#define DRIVE_STRENGTH_MASK  0x3
> >> +
> >> +#define NUM_PINS_PER_DRIVE_STRENGTH_REG      16
> >> +
> >> +#define TWO_BIT_PIN_TO_SHIFT(pin)\
> >> +     (2*((pin >= NUM_PINS_PER_DRIVE_STRENGTH_REG) ? \
> >> +             pin - NUM_PINS_PER_DRIVE_STRENGTH_REG : pin))
> >
> >> +
> >> +#define TWO_BIT_PIN_TO_MASK(pin)\
> >> +     (DRIVE_STRENGTH_MASK  <<  TWO_BIT_PIN_TO_SHIFT(pin))
> >> +
> >> +#if defined(CONFIG_SOC_SAMA5D3)
> >> +     #define PIO_DRIVER1  PIO_DRIVER1_V2  /* Drive Strength Register 1 */
> >> +     #define PIO_DRIVER2  PIO_DRIVER2_V2  /* Drive Strength Register 2 */
> >> +#elif defined(CONFIG_SOC_AT91SAM9X5) || defined(SOC_AT91SAM9G35) || defined(SOC_AT91SAM9G25)
> >> +     #define PIO_DRIVER1  PIO_DRIVER1_V1  /* Drive Strength Register 1 */
> >> +     #define PIO_DRIVER2  PIO_DRIVER2_V1  /* Drive Strength Register 2 */
> >> +#endif
> > no ifdef this is choose at runtime
> >> +
> >> +#if defined(PIO_DRIVER1) && defined(PIO_DRIVER2)
> >> +     #define PIO_DRIVER(pin)\
> >> +             ((pin > NUM_PINS_PER_DRIVE_STRENGTH_REG-1) ? PIO_DRIVER2 : PIO_DRIVER1)
> >> +#endif
> > use inline function
> >> +
> >>  /**
> >>   * struct at91_pmx_func - describes AT91 pinmux functions
> >>   * @name: the name of this specific function
> >> @@ -148,6 +175,8 @@ struct at91_pinctrl_mux_ops {
> >>       void (*set_deglitch)(void __iomem *pio, unsigned mask, bool is_on);
> >>       bool (*get_debounce)(void __iomem *pio, unsigned pin, u32 *div);
> >>       void (*set_debounce)(void __iomem *pio, unsigned mask, bool is_on, u32 div);
> >> +     int (*get_drivestrength)(void __iomem *pio, unsigned pin);
> >> +     void (*set_drivestrength)(void __iomem *pio, unsigned pin, u32 strength);
> >>       bool (*get_pulldown)(void __iomem *pio, unsigned pin);
> >>       void (*set_pulldown)(void __iomem *pio, unsigned mask, bool is_on);
> >>       bool (*get_schmitt_trig)(void __iomem *pio, unsigned pin);
> >> @@ -462,6 +491,20 @@ static void at91_mux_pio3_set_pulldown(void __iomem *pio, unsigned mask, bool is
> >>       __raw_writel(mask, pio + (is_on ? PIO_PPDER : PIO_PPDDR));
> >>  }
> >>
> >> +static int at91_mux_pio3_get_drivestrength(void __iomem *pio, unsigned pin)
> >> +{
> >> +    return (__raw_readl(pio + PIO_DRIVER(pin)) >> TWO_BIT_PIN_TO_SHIFT(pin)) & DRIVE_STRENGTH_MASK;
> >> +}
> >> +
> >> +static void at91_mux_pio3_set_drivestrength(void __iomem *pio, unsigned pin, u32 strength)
> >> +{
> >> +    unsigned tmp = __raw_readl(pio + PIO_DRIVER(pin));
> >> +    tmp &= ~TWO_BIT_PIN_TO_MASK(pin);
> >> +    tmp |= strength << TWO_BIT_PIN_TO_SHIFT(pin);
> >> +
> >> +    __raw_writel(tmp, pio + PIO_DRIVER(pin));
> >> +}
> >> +
> >>  static void at91_mux_pio3_disable_schmitt_trig(void __iomem *pio, unsigned mask)
> >>  {
> >>       __raw_writel(__raw_readl(pio + PIO_SCHMITT) | mask, pio + PIO_SCHMITT);
> >> @@ -491,6 +534,8 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
> >>       .set_deglitch   = at91_mux_pio3_set_deglitch,
> >>       .get_debounce   = at91_mux_pio3_get_debounce,
> >>       .set_debounce   = at91_mux_pio3_set_debounce,
> >> +     .get_drivestrength = at91_mux_pio3_get_drivestrength,
> >> +     .set_drivestrength = at91_mux_pio3_set_drivestrength,
> >>       .get_pulldown   = at91_mux_pio3_get_pulldown,
> >>       .set_pulldown   = at91_mux_pio3_set_pulldown,
> >>       .get_schmitt_trig = at91_mux_pio3_get_schmitt_trig,
> >> @@ -736,6 +781,8 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
> >>               *config |= DEGLITCH;
> >>       if (info->ops->get_debounce && info->ops->get_debounce(pio, pin, &div))
> >>               *config |= DEBOUNCE | (div << DEBOUNCE_VAL_SHIFT);
> >> +     if (info->ops->get_drivestrength)
> >> +             *config |= DRIVE_STRENGTH | (info->ops->get_drivestrength(pio, pin) << DRIVE_STRENGTH_SHIFT);
> >>       if (info->ops->get_pulldown && info->ops->get_pulldown(pio, pin))
> >>               *config |= PULL_DOWN;
> >>       if (info->ops->get_schmitt_trig && info->ops->get_schmitt_trig(pio, pin))
> >> @@ -753,6 +800,7 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
> >>       void __iomem *pio;
> >>       int i;
> >>       unsigned long config;
> >> +     unsigned pin;
> >>
> >>       for (i = 0; i < num_configs; i++) {
> >>               config = configs[i];
> >> @@ -761,7 +809,8 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
> >>                       "%s:%d, pin_id=%d, config=0x%lx",
> >>                       __func__, __LINE__, pin_id, config);
> >>               pio = pin_to_controller(info, pin_to_bank(pin_id));
> >> -             mask = pin_to_mask(pin_id % MAX_NB_GPIO_PER_BANK);
> >> +             pin = pin_id % MAX_NB_GPIO_PER_BANK;
> >> +             mask = pin_to_mask(pin);
> >>
> >>               if (config & PULL_UP && config & PULL_DOWN)
> >>                       return -EINVAL;
> >> @@ -773,6 +822,9 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
> >>               if (info->ops->set_debounce)
> >>                       info->ops->set_debounce(pio, mask, config & DEBOUNCE,
> >>                               (config & DEBOUNCE_VAL) >> DEBOUNCE_VAL_SHIFT);
> >> +             if (info->ops->set_drivestrength && config & SET_DRIVE_STRENGTH)
> >> +                     info->ops->set_drivestrength(pio, pin,
> >> +                             (config & DRIVE_STRENGTH) >> DRIVE_STRENGTH_SHIFT);
> >>               if (info->ops->set_pulldown)
> >>                       info->ops->set_pulldown(pio, mask, config & PULL_DOWN);
> >>               if (info->ops->disable_schmitt_trig && config & DIS_SCHMIT)
> >> diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
> >> index 0fee6ff..78621a4 100644
> >> --- a/include/dt-bindings/pinctrl/at91.h
> >> +++ b/include/dt-bindings/pinctrl/at91.h
> >> @@ -20,6 +20,19 @@
> >>
> >>  #define AT91_PINCTRL_PULL_UP_DEGLITCH        (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DEGLITCH)
> >>
> >> +#define AT91_PINCTRL_SET_DRIVE_STRENGTH  (1 << 5)
> >> +
> >> +#if defined(CONFIG_SOC_SAMA5D3)
> >> +     #define AT91_PINCTRL_DRIVE_STRENGTH_LOW (0x2 << 6)
> >> +     #define AT91_PINCTRL_DRIVE_STRENGTH_MED (0x1 << 6)
> >> +     #define AT91_PINCTRL_DRIVE_STRENGTH_HI  (0x0 << 6)
> >> +#elif defined(CONFIG_SOC_AT91SAM9X5) || defined(SOC_AT91SAM9G35) || defined(SOC_AT91SAM9G25)
> >> +     #define AT91_PINCTRL_DRIVE_STRENGTH_LOW (0x1 << 6)
> >> +     #define AT91_PINCTRL_DRIVE_STRENGTH_MED (0x2 << 6)
> >> +     #define AT91_PINCTRL_DRIVE_STRENGTH_HI  (0x3 << 6)
> >> +#endif
> >
> > no only one binding we do not care of the IP details
> >
> > 0 means no drive strength specified
> >> +
> >> +
> >>  #define AT91_PIOA    0
> >>  #define AT91_PIOB    1
> >>  #define AT91_PIOC    2
> >> --
> >> 1.7.10.4
> >>
> >>
> >>
> >>
> >> --
> >> Mark
> >>
> >>
> 
> 
> 
> -- 
> Mark
