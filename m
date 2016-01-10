From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 10 Jan 2016 20:13:54 +0100
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <93C244A0-20B7-4E21-A183-E09F83CFE035@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
 <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
 <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
 <20160110115858.GV6588@sirena.org.uk>
 <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
 <CAMuHMdXan4aM76aAx_wbnrib7wH5W7tkg60jgRkyQjGFmUEo=A@mail.gmail.com>
 <D415BD6A-6BE1-4B87-B0D4-D0AC6D39785A@martin.sperl.org>
 <CAMuHMdVG+ox4JJWAiNRVgTtV_Lz4Njhekp0=dOyY-G+=mxby3Q@mail.gmail.com>
 <93C244A0-20B7-4E21-A183-E09F83CFE035@martin.sperl.org>
Message-ID: <CAMuHMdXwwPMskWtgMr8rnA4h9ZLYU9OYFcM5sxdgOavqbkpbrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Sun, Jan 10, 2016 at 8:07 PM, Martin Sperl <kernel@martin.sperl.org> wrote:
>> On 10.01.2016, at 19:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Sun, Jan 10, 2016 at 7:01 PM, Martin Sperl <kernel@martin.sperl.org> wrote:
>>>> On 10.01.2016, at 14:02, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> I wrote:
>>>> | Hence it can better be replaced (it seems to be unused in dts files, but you
>>>> | can keep the definition to be 100% sure) by an ARRAY_SIZE() in the C driver.
>>>> | This requires changing the driver to e.g. initialize clks[] in
>>>> |bcm2835_clk_probe() based on a table instead of explicit code.
>>>>
>>>> If you fill in clks[] from a static table, you can take ARRAY_SIZE of
>>>> the static table.
>>>
>>> You mean something like the below?
>>> (note: copy/paste from console issues - spaces instead of tabs)
>>
>> More or less.
>>
>>> };
>>>
>>> static inline void cprman_write(struct bcm2835_cprman *cprman, u32 reg, u32 val
>>> @@ -496,6 +496,14 @@ static const struct bcm2835_pll_data bcm2835_pllh_data = {
>>>        .max_fb_rate = BCM2835_MAX_FB_RATE,
>>> };
>>>
>>> +static const struct bcm2835_pll_data *bcm2835_plls[] = {
>>> +       [BCM2835_PLLA] = &bcm2835_plla_data,
>>> +       [BCM2835_PLLB] = &bcm2835_pllb_data,
>>> +       [BCM2835_PLLC] = &bcm2835_pllc_data,
>>> +       [BCM2835_PLLD] = &bcm2835_plld_data,
>>> +       [BCM2835_PLLH] = &bcm2835_pllh_data,
>>> +};
>>
>> This is a sparse array?
> Yes - for all.
>
>>> struct bcm2835_pll {
>>>        struct clk_hw hw;
>>>        struct bcm2835_cprman *cprman;
>>> @@ -1560,8 +1600,13 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
>>>        struct clk **clks;
>>>        struct bcm2835_cprman *cprman;
>>>        struct resource *res;
>>> +       const int clks_cnt = max(ARRAY_SIZE(bcm2835_plls),
>>> +                                max(ARRAY_SIZE(bcm2835_pll_divs),
>>> +                                    ARRAY_SIZE(bcm2835_clks))) + 1;
>>> +       size_t alloc = sizeof(*cprman) + clks_cnt * sizeof(*clks);
>>> +       size_t i;
>>
>> If you combine all 3 arrays in a single non-sparse array, you could get rid
>> of the dynamic allocation using the maximum of the 3 sizes, and can just
>> use a single ARRAY_SIZE().
>
> The problem is that we need different initialization methods for pll, pll-dividers
> and derived clocks, so we can not easily make them a common setting unless we
> would use function and void pointers to work arround this, which would make it
> less readable (and more code again just for the - repeated - assignment).

You can store the clock type in the array elements, too?

I'm doing something similar, cfr. drivers/clk/shmobile/*-cpg-mssr.* in next.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
