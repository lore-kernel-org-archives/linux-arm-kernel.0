From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Aug 2015 11:49:06 -0500
Subject: [PATCH 1/2] drm/layerscape: Add HDMI support for DCU DRM driver
In-Reply-To: <1440649198-27244-1-git-send-email-jianwei.wang.chn@gmail.com>
References: <1440649198-27244-1-git-send-email-jianwei.wang.chn@gmail.com>
Message-ID: <CAL_JsqJGPuZOya+UARaKkhWus2cHjr=8ByhL7WnQhMrCj7-beQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 11:19 PM, Jianwei Wang
<jianwei.wang.chn@gmail.com> wrote:
> Some Freescale SoCs, there has an DVI/HDMI controller and a PHY,
> attached to one of their display controller unit's LCDC interfaces.
> This patch adds a driver for SiI902x. The SiI902x is a HDMI
> transmitter It supports resolutions from standard definition
> 480i/p and 576i/p all the way to high-definition 720p, 1080i,
> and 1080p, the highest resolution supported by HDTVs today.
>
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
> ---
>  .../devicetree/bindings/video/SiI902x.txt          |  17 +
>  drivers/gpu/drm/fsl-dcu/Makefile                   |   1 +
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_hdmi.c         | 639 +++++++++++++++++++++

This is a separate chip. It should not be part of the FSL DCU driver.

>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c          |  10 +
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_output.h       |  10 +
>  5 files changed, 677 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/SiI902x.txt
>  create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_hdmi.c
>
> diff --git a/Documentation/devicetree/bindings/video/SiI902x.txt b/Documentation/devicetree/bindings/video/SiI902x.txt
> new file mode 100644
> index 0000000..d304499
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/SiI902x.txt
> @@ -0,0 +1,17 @@
> +Device-Tree bindings for the SiI902x hdmi transmitter.
> +
> +Required properties:
> +- compatible:  Should be "sii902x".

This should have the vendor prefix sil. It should also be specific to
which chip number. There is already a binding for the 9022 in
vexpress-v2m.dtsi, so we should use the same binding although it is
not documented. I'm not too sure about the -tpi and -cpi parts of the
binding though. It appears the device has multiple i2c addresses which
is fairly common. I would not do multiple nodes like was done. If the
secondary addresses are known or programmable thru the primary
address, we can just hardcode them in the driver (ADV7511 is an
example). If we don't know the addresses, then we can just put
multiple addresses in the reg property.

Rob

> +- reg:                 The I2C address of the device.
> +- interrupts:  Interrupt number to the cpu.
> +
> +Example:
> +
> +&i2c1 {
> +       status = "okay";
> +       hdmi: sii9022a at 39 {
> +             compatible = "sii902x";
> +             reg = <0x39>;
> +             interrupts = <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
> +       };

You should be using the OF graph to describe the connection to the DCU output.

Rob
