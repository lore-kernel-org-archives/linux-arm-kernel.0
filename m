From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 08:58:48 -0500
Subject: [PATCH  2/8] dt-bindings: stm32-dwmac: add support of MPU families
In-Reply-To: <1524582120-4451-3-git-send-email-christophe.roullier@st.com>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
 <1524582120-4451-3-git-send-email-christophe.roullier@st.com>
Message-ID: <20180501135848.GA12597@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 05:01:54PM +0200, Christophe Roullier wrote:
> Add description for Ethernet MPU families fields
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.txt | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> index 489dbcb..e9d1c4a 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> @@ -6,14 +6,26 @@ Please see stmmac.txt for the other unchanged properties.
>  The device node has following properties.
>  
>  Required properties:
> -- compatible:  Should be "st,stm32-dwmac" to select glue, and
> +- compatible:  For MCU family should be "st,stm32-dwmac" to select glue, and
>  	       "snps,dwmac-3.50a" to select IP version.
> +	       For MPU family should be "st,stm32mp1-dwmac" to select
> +	       glue, and "snps,dwmac-4.20a" to select IP version.
>  - clocks: Must contain a phandle for each entry in clock-names.
>  - clock-names: Should be "stmmaceth" for the host clock.
>  	       Should be "mac-clk-tx" for the MAC TX clock.
>  	       Should be "mac-clk-rx" for the MAC RX clock.
> +	       For MPU family "ethstp" for power mode clock.
> +	       For MPU family need also "syscfg-clk" for SYSCFG clock.

These are in addition or instead of the first 3 clocks.

> +- interrupt-names: Should contain a list of interrupt names corresponding to
> +           the interrupts in the interrupts property, if available.

You need to list the names. Seems unrelated to MPU support.

>  - st,syscon : Should be phandle/offset pair. The phandle to the syscon node which
> -	      encompases the glue register, and the offset of the control register.
> +	       encompases the glue register, and the offset of the control register.
> +
> +Optional properties:
> +- clock-names:     For MPU family "mac-clk-ck" for PHY without quartz

The clock is always connected whether you use it or not, right? So it 
shouldn't be optional based on use.

> +- st,int-phyclk :  valid only where PHY do not have quartz and need to be clock
> +	           by RCC

Boolean?


> +
>  Example:
>  
>  	ethernet at 40028000 {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
