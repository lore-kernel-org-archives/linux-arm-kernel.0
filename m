From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 10 Jan 2016 19:56:20 +0100
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <D415BD6A-6BE1-4B87-B0D4-D0AC6D39785A@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
 <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
 <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
 <20160110115858.GV6588@sirena.org.uk>
 <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
 <CAMuHMdXan4aM76aAx_wbnrib7wH5W7tkg60jgRkyQjGFmUEo=A@mail.gmail.com>
 <D415BD6A-6BE1-4B87-B0D4-D0AC6D39785A@martin.sperl.org>
Message-ID: <CAMuHMdVG+ox4JJWAiNRVgTtV_Lz4Njhekp0=dOyY-G+=mxby3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Sun, Jan 10, 2016 at 7:01 PM, Martin Sperl <kernel@martin.sperl.org> wrote:
>> On 10.01.2016, at 14:02, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> I wrote:
>> | Hence it can better be replaced (it seems to be unused in dts files, but you
>> | can keep the definition to be 100% sure) by an ARRAY_SIZE() in the C driver.
>> | This requires changing the driver to e.g. initialize clks[] in
>> |bcm2835_clk_probe() based on a table instead of explicit code.
>>
>> If you fill in clks[] from a static table, you can take ARRAY_SIZE of
>> the static table.
>
> You mean something like the below?
> (note: copy/paste from console issues - spaces instead of tabs)

More or less.

> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index dee67b3..5ce5e7f 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -294,7 +294,7 @@ struct bcm2835_cprman {
>         const char *osc_name;
>
>         struct clk_onecell_data onecell;
> -       struct clk *clks[BCM2835_CLOCK_COUNT];
> +       struct clk *clks[];

If all clocks would be in a single array, you could get rid of the extra
dynamic allocation, and still use

        struct clk *clks[ARRAY_SIZE(all_clocks_array)];

here.

>  };
>
>  static inline void cprman_write(struct bcm2835_cprman *cprman, u32 reg, u32 val
> @@ -496,6 +496,14 @@ static const struct bcm2835_pll_data bcm2835_pllh_data = {
>         .max_fb_rate = BCM2835_MAX_FB_RATE,
>  };
>
> +static const struct bcm2835_pll_data *bcm2835_plls[] = {
> +       [BCM2835_PLLA] = &bcm2835_plla_data,
> +       [BCM2835_PLLB] = &bcm2835_pllb_data,
> +       [BCM2835_PLLC] = &bcm2835_pllc_data,
> +       [BCM2835_PLLD] = &bcm2835_plld_data,
> +       [BCM2835_PLLH] = &bcm2835_pllh_data,
> +};

This is a sparse array?

> +
>  struct bcm2835_pll_divider_data {
>         const char *name;
>         const struct bcm2835_pll_data *source_pll;
> @@ -625,6 +633,20 @@ static const struct bcm2835_pll_divider_data bcm2835_pllh_p
>         .fixed_divider = 10,
>  };
>
> +static const struct bcm2835_pll_divider_data *bcm2835_pll_divs[] = {
> +       [BCM2835_PLLA_CORE]     = &bcm2835_plla_core_data,
> +       [BCM2835_PLLA_PER]      = &bcm2835_plla_per_data,
> +       [BCM2835_PLLC_CORE0]    = &bcm2835_pllc_core0_data,
> +       [BCM2835_PLLC_CORE1]    = &bcm2835_pllc_core1_data,
> +       [BCM2835_PLLC_CORE2]    = &bcm2835_pllc_core2_data,
> +       [BCM2835_PLLC_PER]      = &bcm2835_pllc_per_data,
> +       [BCM2835_PLLD_CORE]     = &bcm2835_plld_core_data,
> +       [BCM2835_PLLD_PER]      = &bcm2835_plld_per_data,
> +       [BCM2835_PLLH_RCAL]     = &bcm2835_pllh_rcal_data,
> +       [BCM2835_PLLH_AUX]      = &bcm2835_pllh_aux_data,
> +       [BCM2835_PLLH_PIX]      = &bcm2835_pllh_pix_data,
> +};

Likewise.

>  struct bcm2835_clock_data {
>         const char *name;
>
> @@ -837,6 +859,24 @@ static const struct bcm2835_clock_data bcm2835_clock_pcm_da
>         .mash = 1,
>  };
>
> +static const struct bcm2835_clock_data *bcm2835_clks[] = {
> +       [BCM2835_CLOCK_TIMER]   = &bcm2835_clock_timer_data,
> +       [BCM2835_CLOCK_OTP]     = &bcm2835_clock_otp_data,
> +       [BCM2835_CLOCK_TSENS]   = &bcm2835_clock_tsens_data,
> +       [BCM2835_CLOCK_VPU]     = &bcm2835_clock_vpu_data,
> +       [BCM2835_CLOCK_V3D]     = &bcm2835_clock_v3d_data,
> +       [BCM2835_CLOCK_ISP]     = &bcm2835_clock_isp_data,
> +       [BCM2835_CLOCK_H264]    = &bcm2835_clock_h264_data,
> +       [BCM2835_CLOCK_V3D]     = &bcm2835_clock_v3d_data,
> +       [BCM2835_CLOCK_SDRAM]   = &bcm2835_clock_sdram_data,
> +       [BCM2835_CLOCK_UART]    = &bcm2835_clock_uart_data,
> +       [BCM2835_CLOCK_VEC]     = &bcm2835_clock_vec_data,
> +       [BCM2835_CLOCK_HSM]     = &bcm2835_clock_hsm_data,
> +       [BCM2835_CLOCK_EMMC]    = &bcm2835_clock_emmc_data,
> +       [BCM2835_CLOCK_PWM]     = &bcm2835_clock_pwm_data,
> +       [BCM2835_CLOCK_PCM]     = &bcm2835_clock_pcm_data,
> +};

Likewise.

>  struct bcm2835_pll {
>         struct clk_hw hw;
>         struct bcm2835_cprman *cprman;
> @@ -1560,8 +1600,13 @@ static int bcm2835_clk_probe(struct platform_device *pdev)
>         struct clk **clks;
>         struct bcm2835_cprman *cprman;
>         struct resource *res;
> +       const int clks_cnt = max(ARRAY_SIZE(bcm2835_plls),
> +                                max(ARRAY_SIZE(bcm2835_pll_divs),
> +                                    ARRAY_SIZE(bcm2835_clks))) + 1;
> +       size_t alloc = sizeof(*cprman) + clks_cnt * sizeof(*clks);
> +       size_t i;

If you combine all 3 arrays in a single non-sparse array, you could get rid
of the dynamic allocation using the maximum of the 3 sizes, and can just
use a single ARRAY_SIZE().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
