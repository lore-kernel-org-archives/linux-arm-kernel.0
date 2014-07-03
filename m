From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 3 Jul 2014 14:12:11 +0800
Subject: [PATCH 1/4] clk: add pxa27x clock drivers
In-Reply-To: <1404066744-13416-2-git-send-email-robert.jarzmik@free.fr>
References: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
 <1404066744-13416-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <CAN1soZzoiGAz3OicdKbg5Dv2tW3yeinsu2i=M7KX+j1HuMs3Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 2:32 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Move pxa27x clock drivers from arch/arm/mach-pxa to driver/clk.
> In the move :
>  - convert to new clock framework legacy clocks
>  - provide clocks as before for platform data based boards
>  - provide clocks through devicetree with clk-pxa-dt
>
> This is the preliminary step in the conversion. The remaining steps are
> :
>  - migrate pxa25x and pxa3xx
>  - once PXA is fully converted to device tree, if that happens,
>    clk-pxa2* and clk-pxa3* should only hold the core clocks which cannot
>    be described in devicetree.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/clk/Makefile         |   1 +
>  drivers/clk/pxa/Makefile     |   4 +
>  drivers/clk/pxa/clk-pxa-dt.c |  76 ++++++++++
>  drivers/clk/pxa/clk-pxa27x.c | 324 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/pxa/clk-pxa2xx.c |  74 ++++++++++
>  drivers/clk/pxa/clk-pxa2xx.h |  47 +++++++
>  6 files changed, 526 insertions(+)
>  create mode 100644 drivers/clk/pxa/Makefile
>  create mode 100644 drivers/clk/pxa/clk-pxa-dt.c
>  create mode 100644 drivers/clk/pxa/clk-pxa27x.c
>  create mode 100644 drivers/clk/pxa/clk-pxa2xx.c
>  create mode 100644 drivers/clk/pxa/clk-pxa2xx.h
>
> +
> +static struct pxa27x_clocks_fixed_cken pxa27x_without_dt_clocks[] __initdata = {
> +       PXA2_FIXED_RATE("pxa2xx-uart.0", NULL, FFUART, 14857000, 1),
> +       PXA2_FIXED_RATE("pxa2xx-uart.1", NULL, BTUART, 14857000, 1),
> +       PXA2_FIXED_RATE("pxa2xx-uart.2", NULL, STUART, 14857000, 1),
> +       PXA2_FIXED_RATE(NULL, "UARTCLK", STUART, 14857000, 1),
> +       PXA2_FIXED_RATE("pxa2xx-i2s", NULL, I2S, 14682000, 0),
> +       PXA2_FIXED_RATE("pxa2xx-i2c.0", NULL, I2C, 32842000, 0),
> +       PXA2_FIXED_RATE("pxa27x-udc", NULL, USB, 48000000, 5),
> +       PXA2_FIXED_RATE("pxa2xx-mci.0", NULL, MMC, 19500000, 0),
> +       PXA2_FIXED_RATE("pxa2xx-ir", "FICPCLK", FICP, 48000000, 0),
> +       PXA2_FIXED_RATE("pxa27x-ohci", NULL, USBHOST, 48000000, 0),
> +       PXA2_FIXED_RATE("pxa2xx-i2c.1", NULL, PWRI2C, 13000000, 0),
> +       PXA2_FIXED_RATE("pxa27x-keypad", NULL, KEYPAD, 32768, 0),
> +       PXA2_FIXED_RATE("pxa27x-ssp.0", NULL, SSP1, 13000000, 0),
> +       PXA2_FIXED_RATE("pxa27x-ssp.1", NULL, SSP2, 13000000, 0),
> +       PXA2_FIXED_RATE("pxa27x-ssp.2", NULL, SSP3, 13000000, 0),
> +       PXA2_FIXED_RATE("pxa27x-pwm.0", NULL, PWM0, 13000000, 0),
> +       PXA2_FIXED_RATE("pxa27x-pwm.1", NULL, PWM1, 13000000, 0),
> +       PXA2_FIXED_RATE(NULL, "AC97CLK", AC97, 24576000, 0),
> +       PXA2_FIXED_RATE(NULL, "AC97CONFCLK", AC97CONF, 24576000, 0),
> +       PXA2_FIXED_RATE(NULL, "MSLCLK", MSL, 48000000, 0),
> +       PXA2_FIXED_RATE(NULL, "USIMCLK", USIM, 48000000, 0),
> +       PXA2_FIXED_RATE(NULL, "MSTKCLK", MEMSTK, 19500000, 0),
> +       PXA2_FIXED_RATE(NULL, "IMCLK", IM, 0, 0),
> +       PXA2_FIXED_RATE_AO("pxa27x-memc", "MEMCLK", MEMC, 0, 0),
> +};
> +
> +static struct pxa27x_clocks_var_rate pxa27x_var_rate_clocks[] __initdata = {
> +       PXA2_VAR_RATE("pxa2xx-fb", true, LCD, &clk_pxa27x_lcd_ops),
> +       PXA2_VAR_RATE("pxa27x-camera.0", true, CAMERA, &clk_pxa27x_lcd_ops),
> +       PXA2_VAR_RATE("pxa2xx-pcmcia", false, MEMC, &clk_pxa27x_mem_ops),
> +};
> +

It's not good to define a VAR table any more.

Now we have the common clock framework. Since these three clocks are
used as clock
gate. And their clock frequency is controlled by other bits in
peripheral controller registers.
We can define parent & child clocks in clock tables. I think that you
can get a lot of
reference in clock drivers, such as exynos, hisilicon, ...

Same comment on PXA_FIXED_RATE table.

Regards
Haojian
