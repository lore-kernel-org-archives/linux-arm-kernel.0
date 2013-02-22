From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 22 Feb 2013 09:32:00 +0800
Subject: [PATCH v3 08/12] gpio: pxa: move gpio properties into child node
In-Reply-To: <CACRpkda7P5GsOB=s0YbeV2rXbpQaHQNkr0Po73Lwo-vyFcN1Nw@mail.gmail.com>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-9-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkda7P5GsOB=s0YbeV2rXbpQaHQNkr0Po73Lwo-vyFcN1Nw@mail.gmail.com>
Message-ID: <CAD6h2NQ2Tz3dTyyJOFhf8t9aCGs4S6EZ_6f1_u8aqO4XoAN9Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2013 03:09, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>
>> Move gpio properties into child node. So pinctrl driver could binds to
>> each gpio chip with gpio range.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> (...)
>> +       np = pdev->dev.of_node;
>> +#ifdef CONFIG_OF
>> +       if (np)
>> +               next = of_get_next_child(np, NULL);
>> +#endif
> (...)
>> +#ifdef CONFIG_OF
>> +               if (np) {
>> +                       gc->of_node = next;
>> +                       next = of_get_next_child(np, next);
>> +
>> +                       gc->of_xlate = pxa_gpio_of_xlate;
>> +                       gc->of_gpio_n_cells = 2;
>> +               }
>>  #endif
> (...)
>> +       of_node_put(next);
>
> So if you're #ifdef:in all the other of_* stuff, why are you not
> #ifdef:in this?
>
> Is the #ifdef really necessary by the way, or will there be stubs
> handling it?
>
> Have you considered using IS_ENABLED() from <linux/kconfig.h>?
>
> Yours,
> Linus Walleij

I also like IS_ENABLED() macro. But the problem is that
of_get_next_child() isn't defined if CONFIG_OF isn't selected. So
I don't have the choice to use IS_ENABLED().

Regards
Haojian
