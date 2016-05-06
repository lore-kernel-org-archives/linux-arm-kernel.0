From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri, 06 May 2016 15:06:11 +0200
Subject: [PATCH v7 3/3] gpio: move clps711x, moxart,
 ts4800 and gpio-ge into gpio-mmio
In-Reply-To: <CAHp75VeFjcPX+f3j+h+OL2jEpfGP+aqL78ymcsj4JwUfO0RvtA@mail.gmail.com>
References: <cover.1462372360.git.chunkeey@googlemail.com>
 <e936c3c38deee5cd954862c5ed11f9cffa2ba6a9.1462372360.git.chunkeey@googlemail.com>
 <CAHp75VeFjcPX+f3j+h+OL2jEpfGP+aqL78ymcsj4JwUfO0RvtA@mail.gmail.com>
Message-ID: <4995974.1A7SuhXPf2@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 06, 2016 02:53:24 PM Andy Shevchenko wrote:
> On Fri, May 6, 2016 at 2:10 PM, Christian Lamparter
> <chunkeey@googlemail.com> wrote:
> > This patch integrates these GPIO drivers into gpio-mmio.
> 
> Would be nice to repeat a list here.
Ok.
 
> > @@ -285,14 +274,6 @@ config GPIO_MM_LANTIQ
> >           (EBU) found on Lantiq SoCs. The gpios are output only as they are
> >           created by attaching a 16bit latch to the bus.
> >
> > -config GPIO_MOXART
> > -       bool "MOXART GPIO support"
> > -       depends on ARCH_MOXART || COMPILE_TEST
> > -       select GPIO_GENERIC
> > -       help
> > -         Select this option to enable GPIO driver for
> > -         MOXA ART SoC devices.
> > -
> 
> Doesn't it change behaviour? So, as a user of old .config I expect to
> have driver enabled. How is it achieved now?
Ok, I'll restore the configs and let them select GPIO_GENERIC_PLATFORM.

> > --- a/drivers/gpio/gpio-mmio.c
> > +++ b/drivers/gpio/gpio-mmio.c
> > @@ -610,10 +610,200 @@ static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
> >         return 0;
> >  }
> >
> > +static int clps711x_parse_dt(struct platform_device *pdev,
> > +                            struct bgpio_pdata *pdata,
> > +                            unsigned long *flags)
> > +{
> > +       struct device_node *np = pdev->dev.of_node;
> > +       struct resource *res;
> > +       const char *dir_reg_name;
> > +       int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
> > +
> > +       if ((id < 0) || (id > 4))
> > +               return -ENODEV;
> > +
> 
> > +       /* PORTE is 3 lines only */
> > +       pdata->ngpio = (id == 4) ? 3 : /* determined by register width */ 0;
> > +
> > +       /* PORTD is inverted logic for direction register */
> > +       dir_reg_name = (id == 3) ? "dirin" : "dirout",
Actually, the , should be a ; it compiled because , is an operator.
But yes, fixed.

> Just a nit: possible to use switch case?
I think so. I've integrated the id < 0 || id > 4 check as well.
I don't know, I liked the old version more, it was shorter

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index f116786..f71021c 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -619,14 +619,25 @@ static int clps711x_parse_dt(struct platform_device *pdev,
 	const char *dir_reg_name;
 	int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
 
-	if ((id < 0) || (id > 4))
+	switch (id) {
+	case 0:
+	case 1:
+	case 2:
+		pdata->ngpio = 0; /* determined by register width */
+		dir_reg_name = "dirout";
+		break;
+	case 3:
+		pdata->ngpio = 0; /* determined by register width */
+		/* PORTD is inverted logic for direction register */
+		dir_reg_name = "dirin";
+		break;
+	case 4:
+		pdata->ngpio = 3; /* PORTE is 3 lines only */
+		dir_reg_name = "dirout";
+		break;
+	default:
 		return -ENODEV;
-
-	/* PORTE is 3 lines only */
-	pdata->ngpio = (id == 4) ? 3 : /* determined by register width */ 0;
-
-	/* PORTD is inverted logic for direction register */
-	dir_reg_name = (id == 3) ? "dirin" : "dirout",
+	}
 
 	pdata->base = id * 8;
---
  
> > +
> > +       pdata->base = id * 8;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res)
> > +               return -EINVAL;
> > +       if (!res->name || strcmp("dat", res->name))
> > +               res->name = devm_kstrdup(&pdev->dev, "dat", GFP_KERNEL);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +       if (!res)
> > +               return -EINVAL;
> > +       if (!res->name || strcmp(dir_reg_name, res->name))
> > +               res->name = devm_kstrdup(&pdev->dev, dir_reg_name, GFP_KERNEL);
> > +
> > +       return 0;
> > +}

[...]

> > +struct compat_gpio_device_data {
> > +       unsigned int expected_resource_size;
> > +       unsigned int ngpio;
> > +       resource_size_t register_width;
> > +       unsigned long flags;
> > +       int (*call_back)(struct platform_device *pdev,
> > +                        struct bgpio_pdata *pdata,
> > +                        unsigned long *flags);
> > +       struct resource_replacement {
> > +               resource_size_t start_offset;
> > +               const char *name;
> > +       } resources[5];
> 
> I would define magic number with a description what are those 5.

Difficult, these are 5 placeholders for the named resources.
There's particular order so a enum like
{
	DAT,
	SET,
	CLR,
	DIRIN,
	DIROUT,
	__NUM_RES 
}

might look nice but it has no purpose other than maybe confusing people
why the entries aren't used.

> > +};
> 
> [...]
> 
> > +static int compat_parse_dt(struct platform_device *pdev,
> > +                          struct bgpio_pdata *pdata,
> > +                          unsigned long *flags)
> > +{
> > +       const struct device_node *node = pdev->dev.of_node;
> > +       const struct compat_gpio_device_data *entry;
> > +       const struct of_device_id *of_id;
> > +       struct resource *res;
> > +       int err;
> > +
> > +       of_id = of_match_node(compat_gpio_devices, node);
> > +       if (!of_id)
> > +               return -ENODEV;
> > +
> > +       entry = of_id->data;
> > +       if (!entry || !entry->resources[0].name)
> > +               return -EINVAL;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res)
> > +               return -EINVAL;
> > +
> > +       if (!res->name || strcmp(entry->resources[0].name, res->name)) {
> > +               struct resource nres[ARRAY_SIZE(entry->resources)];
> > +               int i;
> 
> unsigned int i; ?
yes. I think I change it to size_t. ARRAY_SIZE uses sizeof internally.
 
Regards,
Christian
