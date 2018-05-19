From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 19 May 2018 21:00:38 +0300
Subject: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
In-Reply-To: <3427199.r4OBoDP6Xz@z50>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180518210954.29044-5-jmkrzyszt@gmail.com>
 <CAHp75VdNUW6KoM6oupyQ80A1WVRk7vewwDt6WEZOyjrAUifqRg@mail.gmail.com>
 <3427199.r4OBoDP6Xz@z50>
Message-ID: <CAHp75VcUxjubx=zOGyCjmpjCk5RBLPCaHcaOieDie9LdTCa+5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2018 at 2:15 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> On Friday, May 18, 2018 11:21:14 PM CEST Andy Shevchenko wrote:
>> On Sat, May 19, 2018 at 12:09 AM, Janusz Krzysztofik
>>
>> <jmkrzyszt@gmail.com> wrote:
>> > +       gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
>> > +       if (!IS_ERR_OR_NULL(gpiod_rdy)) {
>>
>> So, is it optional or not at the end?
>> If it is, why do we check for NULL?
>
> As far as I can understand, nand_chip->dev_ready() callback is optional.
> That's why I decided to use the _optional variant of devm_gpiod_get(). In case
> of ams-delta, the dev_ready() callback depends on availability of the 'rdy'
> GPIO pin. As a consequence, I'm checking for both NULL and ERR in order to
> decide if dev_ready() will be supported.
>
> I can pretty well replace it with the standard form and check for ERR only if
> the purpose of the _optional form is different.

NULL check in practice discards the _optional part of gpiod_get(). So,
either you use non-optional variant and decide how to handle an
errors, or user _optional w/o NULL check.

>> > +err_gpiod:
>> > +       if (err == -ENODEV || err == -ENOENT)
>> > +               err = -EPROBE_DEFER;
>>
>> Hmm...
>
> Amstrad Delta uses gpio-mmio driver. Unfortunatelty that driver is not
> availble before device init phase, unlike other crucial GPIO drivers which are
> initialized earlier, e.g. during the postcore or at latetst the subsys phase.
> Hence, devices which depend on GPIO pins provided by gpio-mmio must either be
> declared late or fail softly so they get another chance of being probed
> succesfully.
>
> I thought of replacing the gpio-mmio platform driver with bgpio functions it
> exports but for now I haven't implemented it, not even shared the idea.
>
> Does it really hurt to return -EPROBE_DEFER if a GPIO pin can't be obtained?

I'm only concerned if it would be an infinite defer in the case when
driver will never appear.
But I don't remember the details.

-- 
With Best Regards,
Andy Shevchenko
