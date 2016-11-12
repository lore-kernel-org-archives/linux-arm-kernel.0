From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Nov 2016 22:44:03 +0100
Subject: [PATCH 2/6] pinctrl: rockchip: add support for rk1108
In-Reply-To: <CAFLEztRW8P4kiPZzVX2jM5UZMZun=TBBCij4B7j2TiesCuJYWA@mail.gmail.com>
References: <1478175975-11779-1-git-send-email-andy.yan@rock-chips.com>
 <1478176470-11956-1-git-send-email-andy.yan@rock-chips.com>
 <CAFLEztRW8P4kiPZzVX2jM5UZMZun=TBBCij4B7j2TiesCuJYWA@mail.gmail.com>
Message-ID: <2910206.ioRrj8ivkn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

Am Sonntag, 13. November 2016, 01:41:21 schrieb ??:
> 2016-11-03 20:34 GMT+08:00 Andy Yan <andy.yan@rock-chips.com>:
> > Add basic support for rk1108 soc
> > 
> > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > ---
> > 
> >  drivers/pinctrl/pinctrl-rockchip.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> > b/drivers/pinctrl/pinctrl-rockchip.c index 49bf7dc..9f324b1 100644
> > --- a/drivers/pinctrl/pinctrl-rockchip.c
> > +++ b/drivers/pinctrl/pinctrl-rockchip.c
> > @@ -59,6 +59,7 @@
> > 
> >  #define GPIO_LS_SYNC           0x60
> >  
> >  enum rockchip_pinctrl_type {
> > 
> > +       RK1108,
> > 
> >         RK2928,
> >         RK3066B,
> >         RK3188,
> > 
> > @@ -1123,6 +1124,7 @@ static int rockchip_get_pull(struct
> > rockchip_pin_bank *bank, int pin_num)> 
> >                 return !(data & BIT(bit))
> >                 
> >                                 ? PIN_CONFIG_BIAS_PULL_PIN_DEFAULT
> >                                 
> >                                 : PIN_CONFIG_BIAS_DISABLE;
> > 
> > +       case RK1108:
> >         case RK3188:
> >         case RK3288:
> > 
> >         case RK3368:
> > @@ -1169,6 +1171,7 @@ static int rockchip_set_pull(struct
> > rockchip_pin_bank *bank,> 
> >                 spin_unlock_irqrestore(&bank->slock, flags);
> >                 break;
> > 
> > +       case RK1108:
> >         case RK3188:
> >         case RK3288:
> > 
> >         case RK3368:
> > @@ -1358,6 +1361,7 @@ static bool rockchip_pinconf_pull_valid(struct
> > rockchip_pin_ctrl *ctrl,> 
> >                                         pull == PIN_CONFIG_BIAS_DISABLE);
> >         
> >         case RK3066B:
> >                 return pull ? false : true;
> > 
> > +       case RK1108:
> >         case RK3188:
> >         case RK3288:
> > 
> >         case RK3368:
> > @@ -1385,7 +1389,6 @@ static int rockchip_pinconf_set(struct pinctrl_dev
> > *pctldev, unsigned int pin,> 
> >         for (i = 0; i < num_configs; i++) {
> >         
> >                 param = pinconf_to_config_param(configs[i]);
> >                 arg = pinconf_to_config_argument(configs[i]);
> > 
> > -
> > 
> >                 switch (param) {
> >                 
> >                 case PIN_CONFIG_BIAS_DISABLE:
> >                         rc =  rockchip_set_pull(bank, pin -
> >                         bank->pin_base,
> > 
> > @@ -2455,6 +2458,26 @@ static int rockchip_pinctrl_probe(struct
> > platform_device *pdev)> 
> >         return 0;
> >  
> >  }
> > 
> > +static struct rockchip_pin_bank rk1108_pin_banks[] = {
> > +       PIN_BANK_IOMUX_FLAGS(0, 32, "gpio0", IOMUX_SOURCE_PMU,
> > +                                            IOMUX_SOURCE_PMU,
> > +                                            IOMUX_SOURCE_PMU,
> > +                                            IOMUX_SOURCE_PMU),
> > +       PIN_BANK_IOMUX_FLAGS(1, 32, "gpio1", 0, 0, 0, 0),
> > +       PIN_BANK_IOMUX_FLAGS(2, 32, "gpio2", 0, 0, 0, 0),
> > +       PIN_BANK_IOMUX_FLAGS(3, 32, "gpio3", 0, 0, 0, 0),
> > +};
> > +
> > +static struct rockchip_pin_ctrl rk1108_pin_ctrl = {
> > +       .pin_banks              = rk1108_pin_banks,
> > +       .nr_banks               = ARRAY_SIZE(rk1108_pin_banks),
> > +       .label                  = "RK1108-GPIO",
> > +       .type                   = RK1108,
> > +       .grf_mux_offset         = 0x10,
> > +       .pmu_mux_offset         = 0x0,
> > +       .pull_calc_reg          = rk3288_calc_pull_reg_and_bit,
> > +};
> > +
> > 
> >  static struct rockchip_pin_bank rk2928_pin_banks[] = {
> >  
> >         PIN_BANK(0, 32, "gpio0"),
> >         PIN_BANK(1, 32, "gpio1"),
> > 
> > @@ -2684,6 +2707,8 @@ static struct rockchip_pin_ctrl rk3399_pin_ctrl = {
> > 
> >  };
> >  
> >  static const struct of_device_id rockchip_pinctrl_dt_match[] = {
> > 
> > +       { .compatible = "rockchip,rk1108-pinctrl",
> > +               .data = (void *)&rk1108_pin_ctrl },
> > 
> >         { .compatible = "rockchip,rk2928-pinctrl",
> >         
> >                 .data = (void *)&rk2928_pin_ctrl },
> >         
> >         { .compatible = "rockchip,rk3036-pinctrl",
> > 
> > --
> > 2.7.4
> 
> rk3288_calc_pull_reg_and_bit can't be used directly in rk1108.
> rk1108 have a different PULL_PMU_OFFSET and PULL_OFFSET.

yes, you're right, the offsets are different, so need a new function.

Andy, when at it, you might also want to include drive-strength functionality? 
It is missing here but from looking at the TRM, it should be pretty easy to 
add, as everything looks similar to what other rockchip socs do.


Heiko
