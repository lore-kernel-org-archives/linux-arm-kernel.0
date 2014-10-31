From: flora.fu@mediatek.com (Flora Fu)
Date: Fri, 31 Oct 2014 11:35:55 +0800
Subject: [PATCH 3/3] ARM: dts: mt8135: Add Reset Controller for
 MediaTek SoC
In-Reply-To: <1414659745.3069.2.camel@pengutronix.de>
References: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
 <1414638733-10080-4-git-send-email-flora.fu@mediatek.com>
 <1414659745.3069.2.camel@pengutronix.de>
Message-ID: <1414726555.25409.38.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Philipp,

On Thu, 2014-10-30 at 10:02 +0100, Philipp Zabel wrote:
> Since the reset controller driver accesses registers solely through the
> syscon regmap, I'd prefer to keep with the device tree control graph
> concept and make the reset-controller nodes children of the syscon
> nodes. I've brought this up before: https://lkml.org/lkml/2014/5/27/422,
> and I think this is another case where child node support for syscon
> makes sense:
> 
>         infracfg: syscon at 10001000 {
>                 compatible = "mediatek,mt8135-infracfg", "syscon";
>                 reg = <0 0x10001000 0 0x1000>;
>                 
>                 infrarst: reset-controller at 30 {
>                         #reset-cells = <1>;
>                         compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
>                         reg = <0x30 0x8>;
>                 };
>         };
> 
>         pericfg: syscon at 10003000 {
>                 compatible = "mediatek,mt8135-pericfg", "syscon";
>                 reg = <0 0x10003000 0 0x1000>;
> 
>                 perirst: reset-controller at 00 {                                                                                               
>                         #reset-cells = <1>;
>                         compatible = "mediatek,mt8135-pericfg-reset", "mediatek,reset";
>                         reg = <0x00 0x8>;
>                 };
>         };
> 
> regards
> Philipp
> 

Yes, such dts arrangement looks better to me. Implementation in this
version is trying to doing the same thing as your proposal. The new
property "mediatek,syscon-reset = <&infracfg 0x30 0x8>;" specifies base
address of reset and byte width for controlling resets.

If https://lkml.org/lkml/2014/5/27/422 is adopt into kernel release, it
will be well organized to configure reset controller as child of regmap
which is compatible to syscon.

In reset driver, it is able to get syscon regmap from parent node and
retrieve the address offset and byte with for controlling resets.
--- 
syscon_np = of_get_parent(np);
data->regmap = syscon_node_to_regmap(syscon_np);
if (IS_ERR(data->regmap)) {
	dev_err(&pdev->dev, "couldn't get syscon-reset regmap\n");
	return PTR_ERR(data->regmap);
}
ret = of_property_read_u32_array(np, "reg", reg, 2);
if (ret) {
	dev_err(&pdev->dev, "couldn't read reset base from syscon!\n");
	return -EINVAL;
}

---


Thanks,
Flora
