From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 29 Sep 2017 13:11:49 +0200
Subject: [PATCH v3] mmc: dt-bindings: Add reg/source_cg/latch-ck for
 Mediatek MMC bindings
In-Reply-To: <1506081829-29296-1-git-send-email-chaotian.jing@mediatek.com>
References: <1506081829-29296-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <f5ef95bf-a085-194b-4412-c72a7813ac08@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/22/2017 02:03 PM, Chaotian Jing wrote:
> Change the comptiable for support of multi-platform
> Add description for reg
> Add description for source_cg
> Add description for mediatek,latch-ck
> Note that source_cg and mediatek,latch-ck are optional for some projects,
> eg, MT2701 do not have source_cg, and MT2712 do not need
> mediatek,latch-ck
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.txt | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 4182ea3..b934a29 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -7,10 +7,15 @@ This file documents differences between the core properties in mmc.txt
>   and the properties used by the msdc driver.
>   
>   Required properties:
> -- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
> +- compatible: value should be either of the following.
> +	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> +	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> +	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> +	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712

NAK, this has to be:
You have to add the fallback comatible ("mediatek,mt8135-mmc") to the binding 
description as otherwise the driver does not get probed.

Regards,
Matthias

> +- reg: physical base address of the controller and length
>   - interrupts: Should contain MSDC interrupt number
> -- clocks: MSDC source clock, HCLK
> -- clock-names: "source", "hclk"
> +- clocks: MSDC source clock, HCLK, source_cg
> +- clock-names: "source", "hclk", "source_cg"
>   - pinctrl-names: should be "default", "state_uhs"
>   - pinctrl-0: should contain default/high speed pin ctrl
>   - pinctrl-1: should contain uhs mode pin ctrl
> @@ -30,6 +35,8 @@ Optional properties:
>   - mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
>   				       If present,HS400 command responses are sampled on rising edges.
>   				       If not present,HS400 command responses are sampled on falling edges.
> +- mediatek,latch-ck: Some SoCs do not support enhance_rx, need set correct latch-ck to avoid data crc
> +		     error caused by stop clock(fifo full)
>   
>   Examples:
>   mmc0: mmc at 11230000 {
> 
