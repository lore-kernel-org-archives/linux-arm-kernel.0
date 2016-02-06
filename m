From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 6 Feb 2016 17:56:00 +0800
Subject: [PATCH v4 1/2] clk: sunxi: Add sun6i/8i video support
In-Reply-To: <20160206103751.eb21edf56ddc6ef7c27907f0@free.fr>
References: <cover.1454435944.git.moinejf@free.fr>
 <3c0e2cdea659e9e682f80ecf42b252c740095f15.1454435944.git.moinejf@free.fr>
 <20160205093915.GF1139@lukather>
 <20160206103751.eb21edf56ddc6ef7c27907f0@free.fr>
Message-ID: <CAGb2v640YWtdT7Rhz2jP7gnQ1U6HJe9POU40HCp==7GrZxDz0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 6, 2016 at 5:37 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> On Fri, 5 Feb 2016 10:39:15 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>
>> > +CLK_OF_DECLARE(sun6i_display, "allwinner,sun6i-display-clk", sun6i_display_setup);
>>
>> Please use the display driver from my DRM serie, it covers everything
>> you need here.
>
> If you give me a pointer, I will have a look.
>
>> > +CLK_OF_DECLARE(sun6i_pll3, "allwinner,sun6i-pll3-clk", sun6i_pll3_setup);
>>
>> And please use the clk-factors code here.
>
> I don't see how I can get direct 297MHz and 270MHz in fractional mode
> with that code.

clk-factors now supports a custom .recalc callback. Along with get_factors,
you can support pretty much any clock that has four variables, not including
the mux and clock gate.

So for this you'd have the div as factor m, and the integer mode bit as p,
and the fraction bit as n, and recalc would be somewhat like this:

if (p) {
        rate = parent_rate / (m + 1);
} else if (n) {
        rate = 297000000;
} else {
        rate = 270000000;
}

get_factors should be easy enough to figure out.

Regards
ChenYu
