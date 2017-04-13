From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Apr 2017 21:57:46 +0200
Subject: [RFC PATCH 1/3] clk: add clk_bulk_get accessories
In-Reply-To: <1491931159.31718.16.camel@nxp.com>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
 <1491969809-20154-2-git-send-email-aisheng.dong@nxp.com>
 <1491931159.31718.16.camel@nxp.com>
Message-ID: <CAMuHMdUpi9rSUNkoEvFWpN-TB0xaYKKrZLy2wO2eOAoig1c56w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 11, 2017 at 7:19 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> On Wed, 2017-04-12 at 12:03 +0800, Dong Aisheng wrote:
>> +/**
>> + * clk_bulk_enable - ungate a bulk of clocks
>> + * @num_clks: the number of clk_bulk_data
>> + * @clks: the clk_bulk_data table being ungated
>> + *
>> + * clk_bulk_enable must not sleep
>> + * Returns 0 on success, -EERROR otherwise.
>> + */
>> +int clk_bulk_enable(int num_clks, struct clk_bulk_data *clks)
>> +{
>> +       int ret;
>> +       int i;
>> +
>> +       for (i = 0; i < num_clks; i++) {
>> +               ret = clk_enable(clks[i].clk);
>> +               if (ret) {
>> +                       pr_err("Failed to enable clk '%s': %d\n",
>> +                               clks[i].id, ret);
>> +                       goto err;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +err:
>> +       while (--i >= 0)
>> +               clk_put(clks[i].clk);
>
> Shouldn't this be clk_disable?
>
> And you can probably use clk_bulk_disable(i, clks) instead

To avoid nasty surprises, clk_bulk_disable() should loop over all clocks
in reverse order.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
