From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Tue, 21 Mar 2017 20:13:29 +0100
Subject: [PATCH] arm64: dts: hi6220: enable DMA in spi0
In-Reply-To: <20170321070818.3247-1-guodong.xu@linaro.org>
References: <20170321070818.3247-1-guodong.xu@linaro.org>
Message-ID: <CAAj6DX3kvc-wy+xSPBC26Xw0s6BBApTJQGrVS1BsiFgfDybBbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 8:08 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
> From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
>
> Enable DMA in spi0.

Hi Guodong, Xiaoyin,

added linux-spi in copy.

Actually the patch does not enable the DMA. The commit message is not correct.

> Cc: Antonio Borneo <borneo.antonio@gmail.com>
> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 470461d..e40625f 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -682,7 +682,8 @@
>                         reg = <0x0 0xf7106000 0x0 0x1000>;
>                         interrupts = <0 50 4>;
>                         bus-id = <0>;
> -                       enable-dma = <0>;
> +                       dmas =  <&dma0 0 &dma0 1>;
> +                       dma-names = "rx", "tx";

The controller spi0 is a standard ARM PL022.
This patch removes the nonexistent property "enable-dma" and specifies
which DMA controller and which DMA channels are connected to spi0.
The values are coherent with the documentation available for hi6220.

Apart from the commit message, I'm fine with this patch.

On PL022 the DMA is not enabled in the DT node of the controller but
in the DT node of each spi device, through the property
"pl022,com-mode".
A separate patch should eventually enable the DMA for those spi
devices that require it.

Best Regards,
Antonio

>                         clocks = <&sys_ctrl HI6220_SPI_CLK>;
>                         clock-names = "apb_pclk";
>                         pinctrl-names = "default";
> --
> 2.10.2
>
