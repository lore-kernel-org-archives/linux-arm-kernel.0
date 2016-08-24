From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 24 Aug 2016 10:10:04 -0500
Subject: [PATCH] arm64: dts: hikey: extend default cma size to 128MB
In-Reply-To: <1472045710-15832-1-git-send-email-guodong.xu@linaro.org>
References: <1472045710-15832-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <CAL_JsqJxE+fAbSsp=N7dvzvQiKwh3nM8-oSJH1OzV+KfW3w4jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 8:35 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
> To support display in Debian on HiKey, cma heap is used to allocate
> graphic buffers. The default size of CMA is 16 MB which is not enought.

s/enought/enough/

>
> Increase the default CMA size to 128 MB.
>
> cc: Rob Herring <rob.herring@linaro.org>
> cc: Fathi Boudra <fathi.boudra@linaro.org>
> cc: John Stultz <john.stultz@linaro.org>
> cc: Xinliang Liu <xinliang.liu@linaro.org>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 4a51058..abb3434 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -45,6 +45,20 @@
>                       <0x00000000 0x22000000 0x00000000 0x1c000000>;
>         };
>
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               /* global autoconfigured region for contiguous allocations */
> +               linux,cma {
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +                       size = <0x00000000 0x08000000>;
> +                       linux,cma-default;
> +               };
> +       };
> +
>         pstore: pstore at 0x21f00000 {

So what is upstream (as of 4.8) for ramoops also uses reserved-memory,
so you should separately fix this.

Acked-by: Rob Herring <robh@kernel.org>

Rob
