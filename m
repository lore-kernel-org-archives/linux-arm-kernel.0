From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 May 2016 11:06:48 +0200
Subject: [PATCH v3] gpio: UniPhier: add driver for UniPhier GPIO controller
In-Reply-To: <CAK7LNAQcfrvuG6fD+gN2Ojq4wzCSNa=qpr5kh2QSFJZMCA2UaQ@mail.gmail.com>
References: <1436841787-7734-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdYaAMw5U3pctf96j0QpY2Qf+e=LX740F0okCmVU6pXkhA@mail.gmail.com>
 <CAK7LNAQ+_ynWT944fPZsHCzMBLtfNu5AnppzaOxNgPSBTvj_tw@mail.gmail.com>
 <CACRpkdZK41P-1JQsL6RiywqFEUj6=g5xJMKy86wDdp6BxLJNzQ@mail.gmail.com>
 <CAK7LNASd9z99RBmUgLVEM1WuLNSzGFM8qzrHwDf58tgGDy2SAw@mail.gmail.com>
 <CACRpkdbBfidn_otxzSV-8HMv2AuD-htUbcRHZ8n9CHAUO=TB9w@mail.gmail.com>
 <CAK7LNAQH+Ge61+MJo2rLmjCBJRnYviT3LyCo0nrOPRQL+RtK2g@mail.gmail.com>
 <CAK7LNAQcfrvuG6fD+gN2Ojq4wzCSNa=qpr5kh2QSFJZMCA2UaQ@mail.gmail.com>
Message-ID: <CACRpkdYn3WWAKeKa0dUjXg3QtMYdTrysGGK3aND5VwBH=NPqTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 6:30 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> So, I'd like to know the recommended driver coding style
> based on 4.7-rc1.

Sure, best is to look at other recently added drivers
I guess.

> Diving into the git-log so far, I came up the following list:
>
> [1] The "dev" member of gpiochip was renamed to "parent"

Yes.

> [2] The most recommended register function is now
>     devm_gpiochip_add_data()

Yes, saves some code.

> [3] Pass the driver private data to the
>     3rd argument of devm_gpiochip_add_data().

Yes.

> [4] Do not use container_of() to covert
>     from gpiochip to driver private data.
>     Instead, gpiochip_get_data() should be used.

Yes.

>     (I used of_mm_gpio_chip in v3,
>      but I needed to use container_of() to
>      convert from gpiochip to of_mm_gpio_chip.
>      I am wondering if you are happy with it or not.)

We will see when we look at the code ;)
I guess it is OK. The alternative is to use gpio-generic instead,
see commit 42178e2a1e42b480ada954750f248b53d3fb5940
"drivers/gpio: Switch gpio-mpc8xxx to use gpio-generic"
for an example of that approach.

> [5] gpiochip.owner is being deprecated.
>     So, platform drivers need not set
>      "gpiochip.owner =  THIS_MODULE".

Yes.

> Correct?

Yes.

> Is there anything else missing?

I advice to add a .get_direction() callback if possible and
also .set_single_ended() if the GPIO chip supports open
drain / open source in hardware.

Yours,
Linus Walleij
