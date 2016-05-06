From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 6 May 2016 16:25:49 +0300
Subject: [PATCH v7 3/3] gpio: move clps711x, moxart, ts4800 and gpio-ge
 into gpio-mmio
In-Reply-To: <4995974.1A7SuhXPf2@debian64>
References: <cover.1462372360.git.chunkeey@googlemail.com>
 <e936c3c38deee5cd954862c5ed11f9cffa2ba6a9.1462372360.git.chunkeey@googlemail.com>
 <CAHp75VeFjcPX+f3j+h+OL2jEpfGP+aqL78ymcsj4JwUfO0RvtA@mail.gmail.com>
 <4995974.1A7SuhXPf2@debian64>
Message-ID: <CAHp75Vf5AP88TMFqVHOD5197vj40QpKRaW0jkOQ9kwz2rzYdWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 6, 2016 at 4:06 PM, Christian Lamparter
<chunkeey@googlemail.com> wrote:
> On Friday, May 06, 2016 02:53:24 PM Andy Shevchenko wrote:
>> On Fri, May 6, 2016 at 2:10 PM, Christian Lamparter
>> <chunkeey@googlemail.com> wrote:

>> Just a nit: possible to use switch case?
> I think so. I've integrated the id < 0 || id > 4 check as well.
> I don't know, I liked the old version more, it was shorter
>
> diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
> index f116786..f71021c 100644
> --- a/drivers/gpio/gpio-mmio.c
> +++ b/drivers/gpio/gpio-mmio.c
> @@ -619,14 +619,25 @@ static int clps711x_parse_dt(struct platform_device *pdev,
>         const char *dir_reg_name;
>         int id = np ? of_alias_get_id(np, "gpio") : pdev->id;
>
> -       if ((id < 0) || (id > 4))
> +       switch (id) {
> +       case 0:
> +       case 1:
> +       case 2:
> +               pdata->ngpio = 0; /* determined by register width */
> +               dir_reg_name = "dirout";
> +               break;
> +       case 3:
> +               pdata->ngpio = 0; /* determined by register width */
> +               /* PORTD is inverted logic for direction register */
> +               dir_reg_name = "dirin";
> +               break;
> +       case 4:
> +               pdata->ngpio = 3; /* PORTE is 3 lines only */
> +               dir_reg_name = "dirout";
> +               break;
> +       default:
>                 return -ENODEV;
> -
> -       /* PORTE is 3 lines only */
> -       pdata->ngpio = (id == 4) ? 3 : /* determined by register width */ 0;
> -
> -       /* PORTD is inverted logic for direction register */
> -       dir_reg_name = (id == 3) ? "dirin" : "dirout",
> +       }

For my personal taste the switch case more understandable / readable.
But i'm not totally objecting the old model, just a subject to discuss.

>> > +struct compat_gpio_device_data {
>> > +       unsigned int expected_resource_size;
>> > +       unsigned int ngpio;
>> > +       resource_size_t register_width;
>> > +       unsigned long flags;
>> > +       int (*call_back)(struct platform_device *pdev,
>> > +                        struct bgpio_pdata *pdata,
>> > +                        unsigned long *flags);
>> > +       struct resource_replacement {
>> > +               resource_size_t start_offset;
>> > +               const char *name;
>> > +       } resources[5];
>>
>> I would define magic number with a description what are those 5.
>
> Difficult, these are 5 placeholders for the named resources.
> There's particular order so a enum like
> {
>         DAT,
>         SET,
>         CLR,
>         DIRIN,
>         DIROUT,
>         __NUM_RES
> }
>
> might look nice but it has no purpose other than maybe confusing people
> why the entries aren't used.

OK, might be just

#define ?_SUPPORTED_RES_MAX 5
?
} resources[_SUPPORTED_RES_MAX];

-- 
With Best Regards,
Andy Shevchenko
