From: christophe.roullier@st.com (Christophe ROULLIER)
Date: Wed, 2 May 2018 08:15:07 +0000
Subject: [PATCH  2/8] dt-bindings: stm32-dwmac: add support of MPU families
In-Reply-To: <20180501135848.GA12597@rob-hp-laptop>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
 <1524582120-4451-3-git-send-email-christophe.roullier@st.com>
 <20180501135848.GA12597@rob-hp-laptop>
Message-ID: <8e49db87619b4577863b3d677ab71dd6@SFHDAG5NODE3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
My answers below under "CRO"

Thanks.
Christophe

-----Original Message-----
From: Rob Herring [mailto:robh at kernel.org] 
Sent: mardi 1 mai 2018 15:59
To: Christophe ROULLIER <christophe.roullier@st.com>
Cc: mark.rutland at arm.com; mcoquelin.stm32 at gmail.com; Alexandre TORGUE <alexandre.torgue@st.com>; Peppe CAVALLARO <peppe.cavallaro@st.com>; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; netdev at vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: stm32-dwmac: add support of MPU families

On Tue, Apr 24, 2018 at 05:01:54PM +0200, Christophe Roullier wrote:
> Add description for Ethernet MPU families fields
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.txt | 16 
> ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt 
> b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> index 489dbcb..e9d1c4a 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> @@ -6,14 +6,26 @@ Please see stmmac.txt for the other unchanged properties.
>  The device node has following properties.
>  
>  Required properties:
> -- compatible:  Should be "st,stm32-dwmac" to select glue, and
> +- compatible:  For MCU family should be "st,stm32-dwmac" to select 
> +glue, and
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
CRO: This is in addition of the first 3 clocks, I will modified my comment:
>>  - clock-names: Should be "stmmaceth" for the host clock.
>>  	       Should be "mac-clk-tx" for the MAC TX clock.
>>  	       Should be "mac-clk-rx" for the MAC RX clock.
>> +	       For MPU family need to add also "ethstp" for power mode clock and,
>> +	                                                                   "syscfg-clk" for SYSCFG clock.

> +- interrupt-names: Should contain a list of interrupt names corresponding to
> +           the interrupts in the interrupts property, if available.

You need to list the names. Seems unrelated to MPU support.
CRO: 		   
> +- interrupt-names: Should contain a list of interrupt names corresponding to
> +           the interrupts in the interrupts property, if available.
        + Should be "macirq" for the main MAC IT
        + Should be "eth_wake_irq" for the IT which wake up system

>  - st,syscon : Should be phandle/offset pair. The phandle to the syscon node which
> -	      encompases the glue register, and the offset of the control register.
> +	       encompases the glue register, and the offset of the control register.
> +
> +Optional properties:
> +- clock-names:     For MPU family "mac-clk-ck" for PHY without quartz

The clock is always connected whether you use it or not, right? So it shouldn't be optional based on use.
CRO: Yes the clock is always connected but it is not necessary to enable it if you have phy with quartz (it will not use)
So it is optional.

> +- st,int-phyclk :  valid only where PHY do not have quartz and need to be clock
> +	           by RCC

Boolean?
CRO: Yes
> +- st,int-phyclk (boolean) :  valid only where PHY do not have quartz and need to be clock

Is it ok ?

> +
>  Example:
>  
>  	ethernet at 40028000 {
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" 
> in the body of a message to majordomo at vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
