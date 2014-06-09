From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 9 Jun 2014 14:51:03 -0700
Subject: exynos5420-peach-pi: linux-next boot fails unless mau_epll left
 enabled?
In-Reply-To: <7hoay6sxjl.fsf@paris.lan>
References: <7hoay6sxjl.fsf@paris.lan>
Message-ID: <CAGa+x86ko1N+T+QAqnY+md4+nyzza_cDt0wa-s06TdCX+27fSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping for any Samsung folks that might be able to explain this.

On Thu, Jun 5, 2014 at 5:15 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Hello,
>
> I'm trying to boot next-20140605[1] on my recently arrived Chromebook2
> (peach-pi) and was not getting to userspace.  Comparing notes with Doug
> Anderson, his was booting just fine, so after some debugging and adding
> 'clk_ignore_unused' to the command-line, it started booting fine.
>
> So then, I tracked it down to which clock was causing the problems and
> found that it's the mau_epll clock gating that's causing the problem,
> and leaving it enabled[1] allows me to boot again.
>
> Any ideas what's going on here?
>
> And in particular, any ideas why it would affect my board and not other
> boards like Doug's?
>
> Thanks,
>
> Kevin
>
> [1] Using this defconfig:
> https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/eclass/cros-kernel/exynos5_defconfig
>
> [2]
> diff --git a/drivers/clk/samsung/clk-exynos5420.c
> b/drivers/clk/samsung/clk-exynos5420.c
> index 61eccf0dd72f..ed175088ee7e 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -911,7 +911,7 @@ static struct samsung_gate_clock
> exynos5x_gate_clks[] __initdata = {
>                         SRC_MASK_TOP2, 24, 0, 0),
>
>         GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
> -                       SRC_MASK_TOP7, 20, 0, 0),
> +                       SRC_MASK_TOP7, 20, CLK_IGNORE_UNUSED, 0),
>
>         /* sclk */
>         GATE(CLK_SCLK_UART0, "sclk_uart0", "dout_uart0",
