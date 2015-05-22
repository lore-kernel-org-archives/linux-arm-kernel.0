From: wangbintian@gmail.com (Brent Wang)
Date: Sat, 23 May 2015 02:57:04 +0800
Subject: [PATCH v7 6/7] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <20150522184131.GD1885@codeaurora.org>
References: <1432117752-7074-1-git-send-email-bintian.wang@huawei.com>
 <1432117752-7074-2-git-send-email-bintian.wang@huawei.com>
 <555D09F3.7020506@codeaurora.org> <555D57BB.8080702@huawei.com>
 <555E1D55.1050907@codeaurora.org> <555EBCA4.9030303@huawei.com>
 <CAAS=xmgHJVThR2hVeMYZjKgJdodEG_hrs09BBA01gOXMSc8Rdg@mail.gmail.com>
 <555F76D9.10308@codeaurora.org>
 <20150522184131.GD1885@codeaurora.org>
Message-ID: <CAAS=xmi98pvXR_qXREnpMfG+Tuh1d8ZdTmhJSvoMNJ0=iOoPpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

2015-05-23 2:41 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 05/22, Stephen Boyd wrote:
>> On 05/22/15 11:30, Brent Wang wrote:
>> > Hello Stephen,
>> >
>> > 2015-05-22 13:20 GMT+08:00 Bintian <bintian.wang@huawei.com>:
>> >>
>> >>>
>> >>> Is pl011 the uart device? Does it have a node in DT somewhere? If it
>> >>> does, then we could put the assigned-parents properties in that node so
>> >>> that when the pl011 probes the uart1 clock has its parent set to
>> >>> clk_150m. See the "Assigned clock parents and rates" section of
>> >>> Documentation/devicetree/bindings/clock/clock-bindings.txt.
>> >>>
>> >> I will verify this.
>> > Currently the "assigned-clock*" doesn't work for pl011 UART device
>> > node, maybe we will
>> > do some fix for its driver later or other modules.
>>
>> Why doesn't it work?
>>
>
> Does this patch help?
Yes, it works!

I also tested adding  "of_clk_set_defaults" to "pl011_probe()", and
"assigned-clock*"
also works.

So you will submit another patch to fix this problem and I can revove
the "clk_set_parent"
from my patch, right ?

Thanks,

Bintian
>
> ---8<----
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index f0099360039e..350ed93d4281 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -19,6 +19,7 @@
>  #include <linux/amba/bus.h>
>  #include <linux/sizes.h>
>  #include <linux/limits.h>
> +#include <linux/clk/clk-conf.h>
>
>  #include <asm/irq.h>
>
> @@ -237,6 +238,10 @@ static int amba_probe(struct device *dev)
>         int ret;
>
>         do {
> +               ret = of_clk_set_defaults(dev->of_node, false);
> +               if (ret < 0)
> +                       break;
> +
>                 ret = dev_pm_domain_attach(dev, true);
>                 if (ret == -EPROBE_DEFER)
>                         break;
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
