From: neko@bakuhatsu.net (Matt Sealey)
Date: Fri, 28 Jun 2013 23:49:10 -0500
Subject: [PATCH 1/2] ARM: dts: mx53qsb: Enable VPU support
In-Reply-To: <1372459759-10488-1-git-send-email-festevam@gmail.com>
References: <1372459759-10488-1-git-send-email-festevam@gmail.com>
Message-ID: <CAHCPf3s6_+aNs=LycgJzcOajmFuWy-mp66-BX+OMCLYDApS9cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 5:49 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Enable Video Processing Unit (VPU) support.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Depends on Philipp Zabel's patch:
> [PATCH] ARM: dts: add sram for imx53 and imx6q
>
> Philipp,
>
> I tried using the original mx53 vpu firmware that comes with the FSL BSP, but it
> failed to load:
>
> coda 63ff4000.vpu: firmware get command error
> coda 63ff4000.vpu: HW initialization failed
>
> Any suggestions?
>
> Thanks!
>
>  arch/arm/boot/dts/imx53-qsb.dts |  4 ++++
>  arch/arm/boot/dts/imx53.dtsi    | 10 ++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> index 512a1f6..eedd27e 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -297,6 +297,10 @@
>         status = "okay";
>  };
>
> +&vpu {
> +       status = "okay";
> +};
> +
>  &usbh1 {
>         status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 3def46f..f94d4e5 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -1086,6 +1086,16 @@
>                                 crtcs = <&ipu 1>;
>                                 status = "disabled";
>                         };
> +
> +                       vpu: vpu at 63ff4000 {
> +                               compatible = "fsl,imx53-vpu";
> +                               reg = <0x63ff4000 0x1000>;
> +                               interrupts = <9>;
> +                               clocks = <&clks 63>, <&clks 63>;
> +                               clock-names = "per", "ahb";
> +                               iram = <&ocram>;
> +                               status = "disabled";
> +                       };
>                 };
>
>                 ocram: ocram at f8000000 {

Nitpick: what I see here around enabling the VPU driver is;

* A property called iram
* ... that references a node called ocram
* ... which is coincidentally driven by a driver called sram

Could we make up our minds as to what to call it? Something generic
that's potentially not i.MX-specific (since it does change over the
models, and it may not be technically SRAM..) that gets used
everywhere and belies it's purpose rather than naming a particular
technology, or particular IP core documentation if it changes a lot?

--
Matt Sealey <neko@bakuhatsu.net>
