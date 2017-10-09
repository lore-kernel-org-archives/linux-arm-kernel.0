From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 9 Oct 2017 16:53:20 +0200
Subject: [PATCH v2 01/13] mmc: dt-bindings: Add reg/source_cg/latch-ck for
 Mediatek MMC bindings
In-Reply-To: <1507548926-9555-2-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
 <1507548926-9555-2-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <48f6a9fc-96df-e284-2d44-e5e84dc3cd65@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/2017 01:35 PM, Chaotian Jing wrote:
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
>   Documentation/devicetree/bindings/mmc/mtk-sd.txt | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index 4182ea3..3e0a97c 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -7,10 +7,18 @@ This file documents differences between the core properties in mmc.txt
>   and the properties used by the msdc driver.
>   
>   Required properties:
> -- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
> +- compatible: value should be either of the following.
> +	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135

Looks like a typo. You don't need mt8173-mmc binding if you what to use mt8135.

Regards,
Matthias

> +	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173
> +	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> +	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> +- reg: physical base address of the controller and length
>   - interrupts: Should contain MSDC interrupt number
> -- clocks: MSDC source clock, HCLK
> -- clock-names: "source", "hclk"
> +- clocks: Should contain phandle for the clock feeding the MMC controller
> +- clock-names: Should contain the following:
> +	"source" - source clock (required)
> +	"hclk" - HCLK which used for host (required)
> +	"source_cg" - independent source clock gate (required for MT2712)
>   - pinctrl-names: should be "default", "state_uhs"
>   - pinctrl-0: should contain default/high speed pin ctrl
>   - pinctrl-1: should contain uhs mode pin ctrl
> @@ -30,6 +38,8 @@ Optional properties:
>   - mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
>   				       If present,HS400 command responses are sampled on rising edges.
>   				       If not present,HS400 command responses are sampled on falling edges.
> +- mediatek,latch-ck: Some SoCs do not support enhance_rx, need set correct latch-ck to avoid data crc
> +		     error caused by stop clock(fifo full)
>   
>   Examples:
>   mmc0: mmc at 11230000 {
> 
