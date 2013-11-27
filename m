From: dan.j.williams@gmail.com (Dan Williams)
Date: Wed, 27 Nov 2013 14:35:17 -0800
Subject: [PATCH v4] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <1377570010-21870-2-git-send-email-zhangfei.gao@linaro.org>
References: <1377570010-21870-1-git-send-email-zhangfei.gao@linaro.org>
 <1377570010-21870-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <CAA9_cmd6crfVdeLQhnfWLcJViAwHG=c3V5SDgu9teEd3pfch7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 7:20 PM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> Add dmaengine driver for hisilicon k3 platform based on virt_dma
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Kai Yang <jean.yangkai@huawei.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt |   46 ++
>  drivers/dma/Kconfig                             |    9 +
>  drivers/dma/Makefile                            |    1 +
>  drivers/dma/k3dma.c                             |  837 +++++++++++++++++++++++
>  4 files changed, 893 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/k3dma.txt
>  create mode 100644 drivers/dma/k3dma.c
>
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> new file mode 100644
> index 0000000..23f8d71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -0,0 +1,46 @@
> +* Hisilicon K3 DMA controller
> +
> +See dma.txt first
> +
> +Required properties:
> +- compatible: Should be "hisilicon,k3-dma-1.0"
> +- reg: Should contain DMA registers location and length.
> +- interrupts: Should contain one interrupt shared by all channel
> +- #dma-cells: see dma.txt, should be 1, para number
> +- dma-channels: physical channels supported
> +- dma-requests: virtual channels supported, each virtual channel
> +               have specific request line
> +- clocks: clock required
> +
> +Example:
> +
> +Controller:
> +               dma0: dma at fcd02000 {
> +                       compatible = "hisilicon,k3-dma-1.0";
> +                       reg = <0xfcd02000 0x1000>;
> +                       #dma-cells = <1>;
> +                       dma-channels = <16>;
> +                       dma-requests = <27>;
> +                       interrupts = <0 12 4>;
> +                       clocks = <&pclk>;
> +                       status = "disable";
> +               };
> +
> +Client:
> +Use specific request line passing from dmax
> +For example, i2c0 read channel request line is 18, while write channel use 19
> +
> +               i2c0: i2c at fcb08000 {
> +                       compatible = "snps,designware-i2c";
> +                       dmas =  <&dma0 18          /* read channel */
> +                                &dma0 19>;        /* write channel */
> +                       dma-names = "rx", "tx";
> +               };
> +
> +               i2c1: i2c at fcb09000 {
> +                       compatible = "snps,designware-i2c";
> +                       dmas =  <&dma0 20          /* read channel */
> +                                &dma0 21>;        /* write channel */
> +                       dma-names = "rx", "tx";
> +               };
> +
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 6825957..2945ff0 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -300,6 +300,15 @@ config DMA_JZ4740
>         select DMA_ENGINE
>         select DMA_VIRTUAL_CHANNELS
>
> +config K3_DMA
> +       tristate "Hisilicon K3 DMA support"
> +       depends on ARCH_HI3xxx

Unless I am missing something this driver cannot be built since
ARCH_HI3xxx does not exist.  Is this arch still winding its way
upstream?
