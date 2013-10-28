From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Oct 2013 22:17:19 -0700
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAOesGMjB6D3owftDUfmMbVNx8_EtY9-RXoGbS3Rmry4FQhSfZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Looks reasonable overall but one question:

On Sun, Oct 6, 2013 at 2:06 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
> index 80c177c..e6edcd3 100644
> --- a/arch/arm/mach-imx/system.c
> +++ b/arch/arm/mach-imx/system.c
> @@ -42,6 +42,9 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
>  {
>         unsigned int wcr_enable;
>
> +       if (cpu_is_imx6q() || cpu_is_imx6dl())
> +               imx_src_prepare_restart();
> +
>         if (wdog_clk)
>                 clk_enable(wdog_clk);
>
> @@ -52,6 +55,8 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
>
>         /* Assert SRS signal */
>         __raw_writew(wcr_enable, wdog_base);
> +       /* write twice to ensure the request will not get ignored */
> +       __raw_writew(wcr_enable, wdog_base);
>
>         /* wait for reset to assert... */
>         mdelay(500);

"will not get ignored" seems like an odd choice of words here. What's
the actual purpose of the double write? Does some versions of the
hardware ignore the first write, or is it that you need to make sure
that the write has reached the hardware block for some other reason?

I came across this patch in your pull request -- I will merge the
branch anyway but I'd like to get the above answered and fixed up
later for clarification if needed.


-Olof
