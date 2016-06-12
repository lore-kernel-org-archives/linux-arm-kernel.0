From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 12 Jun 2016 10:43:04 -0300
Subject: [PATCH 1/2] ARM: dts: imx6q-cm-fx6: fix the operation points
In-Reply-To: <6b48c849983548f29259b42d69c5224c@rwthex-s1-b.rwth-ad.de>
References: <6b48c849983548f29259b42d69c5224c@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5AMK7CtDHwZbOTL45LzNO9SypxSoTFLtyn5SpdUZKKjuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Sun, Jun 12, 2016 at 10:20 AM,  <christopher.spinrath@rwth-aachen.de> wrote:
> From: Valentin Raevsky <valentin@compulab.co.il>
>
> Fix the cm-fx6 operation points. Remove settings for 1.2GHz.
> The current ldo settings do not allow 1.2GHz cpu frequency.
>
> Signed-off-by: Valentin Raevsky <valentin@compulab.co.il>
> [christopher.spinrath at rwth-aachen.de: rebased on upstream and adapted
>  commit title]
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> ---
>  arch/arm/boot/dts/imx6q-cm-fx6.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> index 6d8d5e9..c912d58 100644
> --- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
> +++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> @@ -91,6 +91,23 @@
>         };
>  };
>
> +&cpu0 {
> +       operating-points = <
> +               /* kHz  uV */
> +               996000  1250000
> +               852000  1250000
> +               792000  1150000
> +               396000  975000
> +       >;
> +       fsl,soc-operating-points = <
> +               /* ARM kHz      SOC-PU uV */
> +               996000          1250000
> +               852000          1250000
> +               792000          1175000
> +               396000          1175000
> +       >;

These operating points do not match the ones from imx6q.dtsi.

In order to avoid 1.2GHz operation we have
imx6q_opp_check_speed_grading() inside arch/arm/mach-imx/mach-imx6q.c.
This function checks if the mx6q is capable of running at 1.2GHz or
not, depending on the fuse reading and then it will skip the 1.2GHz
operating point if it detects it can't run at such frequency.

These operating points are defined at the SoC dtsi and we don't have
any board dts that define them locally like this patch proposes, so I
recommend we keep using the operating points from imx6q.dtsi.
