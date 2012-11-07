From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 7 Nov 2012 15:27:28 +0800
Subject: [PATCH 08/10] pinctrl: single: support pinconf generic
In-Reply-To: <20121101004406.GJ15766@atomide.com>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
 <1351724661-29050-4-git-send-email-haojian.zhuang@gmail.com>
 <20121101004406.GJ15766@atomide.com>
Message-ID: <CAN1soZzX_0O7GtGfHHn-8N=CFSpEmBYhTSuvUGpQ0ajh8Hp2wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 1, 2012, Tony Lindgren wrote:
>
> > --- a/drivers/pinctrl/pinctrl-single.c
> > +++ b/drivers/pinctrl/pinctrl-single.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/of_address.h>
> >
> > +#include <linux/pinctrl/pinconf-generic.h>
> >  #include <linux/pinctrl/pinctrl.h>
> >  #include <linux/pinctrl/pinmux.h>
> >
> > @@ -28,6 +29,9 @@
> >  #define DRIVER_NAME                  "pinctrl-single"
> >  #define PCS_MUX_PINS_NAME            "pinctrl-single,pins"
> >  #define PCS_MUX_BITS_NAME            "pinctrl-single,bits"
> > +#define PCS_BIAS_NAME                        "pinctrl-single,bias"
> > +#define PCS_POWER_SOURCE_NAME                "pinctrl-single,power-source"
> > +#define PCS_SCHMITT_NAME             "pinctrl-single,input-schmitt"
> >  #define PCS_REG_NAME_LEN             ((sizeof(unsigned long) * 2) + 1)
> >  #define PCS_OFF_DISABLED             ~0U
> >  #define PCS_MAX_GPIO_VALUES          3
>
> Here too you can remove the new defines.
>
> >  static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
> >                                               struct device_node *np,
> >                                               struct pinctrl_map **map,
> > +                                             unsigned num_configs,
> >                                               const char **pgnames)
> >  {
> ...
>
> Then I suggest you add a generic pinconf-generic property to
> indicate the controller supports pinconf. At least for omaps,
> only some register ranges support pinconf. And by adding
> pinconf-generic, you can parse it once during the probe of
> pinctrl-single.c, and set pcs->pinconf flag.
>
> Then you can use here and avoid calling of_property_read_u32
> for about 600 times unnecessarily for omap4:
>
I don't want to add new property for this. I think that we can use
compatible name instead.

"pinctrl-single" is only for pinmux & gpio range.
"pinconf-single" is for pinmux & gpio range & generic pinconf.
