From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 12 Mar 2018 15:32:25 -0700
Subject: [PATCH 2/3] soc: rockchip: power-domain: Use
 of_clk_get_parent_count() instead of open coding
In-Reply-To: <CAMuHMdVsb+5T-DYfF9v6ANhVxhRk6_r+XPA34mW7Q=90HnitAA@mail.gmail.com>
References: <1516375101-29836-1-git-send-email-geert+renesas@glider.be>
 <1516375101-29836-3-git-send-email-geert+renesas@glider.be>
 <11171053.oOJPuGlHoK@phil>
 <CAEG3pNCioW_FVXj3-j4KC_yO6ZYGXQB_eanHWSb9NUE9kYsWag@mail.gmail.com>
 <CAMuHMdVsb+5T-DYfF9v6ANhVxhRk6_r+XPA34mW7Q=90HnitAA@mail.gmail.com>
Message-ID: <152089394512.147033.16036395348488651030@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2018-03-02 05:15:35)
> Hi Mike,
> 
> On Sun, Feb 18, 2018 at 8:09 PM, Michael Turquette
> <mturquette@baylibre.com> wrote:
> > Moving of_clk_get_parent_count to clk.h seems reasonable to me. It's
> > more of an of-specific helper than a provider-specific helper.
> >
> > Anyone up to submit a patch so that this one doesn't need to include
> > clk-provider.h?
> 
> I gave it a try.
> Just moving of_clk_get_parent_count() from clk-provider.h to clk.h causes
> breakage, as half of the clock providers using of_clk_get_parent_count()
> do not include <linux/clk.h>:
> 
>     drivers/clk/at91/clk-generated.c
>     drivers/clk/at91/clk-main.c
>     drivers/clk/at91/clk-master.c
>     drivers/clk/at91/clk-programmable.c
>     drivers/clk/at91/clk-slow.c
>     drivers/clk/at91/clk-smd.c
>     drivers/clk/at91/clk-usb.c
>     drivers/clk/at91/sckc.c
>     drivers/clk/clk-axi-clkgen.c
>     drivers/clk/clk-gpio.c
>     drivers/clk/clk-hsdk-pll.c
>     drivers/clk/h8300/clk-div.c
>     drivers/clk/h8300/clk-h8s2678.c
>     drivers/clk/renesas/clk-div6.c
>     drivers/clk/ti/composite.c
>     drivers/clk/ti/gate.c
>     drivers/clk/ti/mux.c
> 
> So our options are:
>   1. Add #include <linux/clk.h> to each of the above,
>   2. Add #include <linux/clk.h> to <linux/clk-provider.h>,
>   3. Do nothing, i.e. users of of_clk_get_parent_count () need to
>       #include <linux/clk-provider.h>, cfr. this patch series.
> 
> Any preference? Any option I'm missing?
> 

#2 is a definite no.

How about option #4? Move of_clk_get_parent_count() and
of_clk_get_parent_name() to a new include/linux/of_clk.h, include that
in clk-provider.h, and then have non-clk provider drivers include that
file? After that, we can also move of_clk_init() into this new file, and
then non-provider arch code can call of_clk_init() without including the
provider APIs. I'd also like to get rid of the include of linux/of.h in
clk-provider.h, but that's a ways away.
