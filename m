From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 13 Oct 2015 20:04:26 +0800
Subject: [PATCH v7 1/7] ARM: dts: imx: imx7d-sbd remove fixed can2-3v3
 regulator
In-Reply-To: <1443477401-17238-1-git-send-email-aalonso@freescale.com>
References: <1443477401-17238-1-git-send-email-aalonso@freescale.com>
Message-ID: <CAA+hA=Tuj6xTvcPB7xFi6jghBJZAMNTkMheR8HBz8-bfBdRn8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 5:56 AM, Adrian Alonso <aalonso@freescale.com> wrote:
> Remove incorrect can2-3v3 fixed regulator, imx7d-sdb doesn't
> have a dedicated can2 fixed regulator instead it shares PERI_3V3
> fixed regulator (RT8070ZS) which is enabled by default (hardwired)
> from pmic pfuze3000 NVCC_3V3 power rail.
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
> ---
> Changes for V7: New patch in series
>

It is a correct regulator here, but i have to admit that it's a bit confusing.
Here the regulator is an abstract regulator which is actually used to
control CAN
transceiver STBY signals, it is introduced by below patch:
commit b7c4114b07bbacfe0aee1d04ad1ade9e42309620
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Mon Jun 10 23:12:57 2013 -0300

    can: flexcan: Use a regulator to control the CAN transceiver

    Instead of using a GPIO to turn on/off the CAN transceiver, it is better to
    use a regulator as some systems may use a PMIC to power the CAN transceiver.

    Acked-by: Shawn Guo <shawn.guo@linaro.org>
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

>From the commit messages, it should be likely to control the
transceiver external suppy,
not control signals, but it does do that unproper work currently.

Besides the unproperly handling control signals, this solution also can't handle
multiple CAN transceiver control signals ways.

I was trying to write a common transceiver driver to handling this issue.
But get interrupted by a few other FSL official works, will resume soon.

I would suggest keep the regulator first until the new solution got in.

Regards
Dong Aisheng

>  arch/arm/boot/dts/imx7d-sdb.dts | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 8059458..83f0053 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -78,16 +78,7 @@
>                         enable-active-high;
>                 };
>
> -               reg_can2_3v3: regulator at 2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "can2-3v3";
> -                       regulator-min-microvolt = <3300000>;
> -                       regulator-max-microvolt = <3300000>;
> -                       gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               reg_vref_1v8: regulator at 3 {
> +               reg_vref_1v8: regulator at 2 {
>                         compatible = "regulator-fixed";
>                         reg = <3>;
>                         regulator-name = "vref-1v8";
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
