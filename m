From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 19 Apr 2018 14:39:31 +0530
Subject: [PATCH v2 1/2] cpufreq: imx6q: check speed grades for i.MX6ULL
In-Reply-To: <20180419071942.14828-1-sebastien.szymanski@armadeus.com>
References: <20180419071942.14828-1-sebastien.szymanski@armadeus.com>
Message-ID: <CAOh2x==MCPnANhww2JYhGkaALcAPZe_qAUcbZmhyCDwPjOjT2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 12:49 PM, S?bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> Check the max speed supported from the fuses for i.MX6ULL and update the
> operating points table accordingly.
>
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>
> Changes for v2:
>  - none

Please cc all the maintainers present in MAINTAINERS file. You missed cc'ing me
and I missed V1 earlier.

>  drivers/cpufreq/imx6q-cpufreq.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 83cf631fc9bc..f094687cae52 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -266,6 +266,8 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
>  }
>
>  #define OCOTP_CFG3_6UL_SPEED_696MHZ    0x2
> +#define OCOTP_CFG3_6ULL_SPEED_792MHZ   0x2
> +#define OCOTP_CFG3_6ULL_SPEED_900MHZ   0x3

Looking at the wording everywhere, this represents the maximum
supported frequency ?
In that case ...

>
>  static void imx6ul_opp_check_speed_grading(struct device *dev)
>  {
> @@ -287,16 +289,30 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
>          * Speed GRADING[1:0] defines the max speed of ARM:
>          * 2b'00: Reserved;
>          * 2b'01: 528000000Hz;
> -        * 2b'10: 696000000Hz;
> -        * 2b'11: Reserved;
> +        * 2b'10: 696000000Hz on i.MX6UL, 792000000Hz on i.MX6ULL;
> +        * 2b'11: 900000000Hz on i.MX6ULL only;
>          * We need to set the max speed of ARM according to fuse map.
>          */
>         val = readl_relaxed(base + OCOTP_CFG3);
>         val >>= OCOTP_CFG3_SPEED_SHIFT;
>         val &= 0x3;
> -       if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
> -               if (dev_pm_opp_disable(dev, 696000000))
> -                       dev_warn(dev, "failed to disable 696MHz OPP\n");
> +
> +       if (of_machine_is_compatible("fsl,imx6ul")) {
> +               if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
> +                       if (dev_pm_opp_disable(dev, 696000000))
> +                               dev_warn(dev, "failed to disable 696MHz OPP\n");
> +       }
> +
> +       if (of_machine_is_compatible("fsl,imx6ull")) {
> +               if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
> +                       if (dev_pm_opp_disable(dev, 792000000))
> +                               dev_warn(dev, "failed to disable 792MHz OPP\n");
> +
> +               if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
> +                       if (dev_pm_opp_disable(dev, 900000000))
> +                               dev_warn(dev, "failed to disable 900MHz OPP\n");

... this looks wrong to me as you will end up disabling 792 MHz if max speed is
900 MHz.

> +       }
> +
>         iounmap(base);
>  put_node:
>         of_node_put(np);
> @@ -356,7 +372,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>                 goto put_reg;
>         }
>
> -       if (of_machine_is_compatible("fsl,imx6ul"))
> +       if (of_machine_is_compatible("fsl,imx6ul") ||
> +           of_machine_is_compatible("fsl,imx6ull"))
>                 imx6ul_opp_check_speed_grading(cpu_dev);
>         else
>                 imx6q_opp_check_speed_grading(cpu_dev);
> --
> 2.16.1
>
