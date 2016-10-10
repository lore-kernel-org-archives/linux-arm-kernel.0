From: marex@denx.de (Marek Vasut)
Date: Mon, 10 Oct 2016 16:42:13 +0200
Subject: [PATCH] ARM: dts: imx6sx: Fix LCDIF interrupt type
In-Reply-To: <1476106556.2376.12.camel@pengutronix.de>
References: <20161002164435.5812-1-marex@denx.de>
 <1476106556.2376.12.camel@pengutronix.de>
Message-ID: <af1a450d-c36b-a5fa-b9e5-d02177b21501@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2016 03:35 PM, Lucas Stach wrote:
> Am Sonntag, den 02.10.2016, 18:44 +0200 schrieb Marek Vasut:
>> The LCDIF interrupt should be triggered by the rising edge of the
>> IRQ line because we only want the interrupt to trigger once per each
>> frame. It seems the LCDIF IRQ line cannot be explicitly de-asserted
>> by software, so the previous behavior before this patch, where the
>> interrupt was triggered by level-high status of the IRQ line, caused
>> the interrupt to fire again immediatelly after it was handled, which
>> caused the system to lock up due to the high rate of interrupts.
>>
> If there is no way to ack the IRQ how is the line going low again? Some
> hardware state machine?

My understanding is that it goes down at the end of VBLANK period.

>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> ---
>>  arch/arm/boot/dts/imx6sx.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
>> index 1a473e8..9526c38 100644
>> --- a/arch/arm/boot/dts/imx6sx.dtsi
>> +++ b/arch/arm/boot/dts/imx6sx.dtsi
>> @@ -1143,7 +1143,7 @@
>>  				lcdif1: lcdif at 02220000 {
>>  					compatible = "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
>>  					reg = <0x02220000 0x4000>;
>> -					interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +					interrupts = <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
>>  					clocks = <&clks IMX6SX_CLK_LCDIF1_PIX>,
>>  						 <&clks IMX6SX_CLK_LCDIF_APB>,
>>  						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
>> @@ -1154,7 +1154,7 @@
>>  				lcdif2: lcdif at 02224000 {
>>  					compatible = "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
>>  					reg = <0x02224000 0x4000>;
>> -					interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>> +					interrupts = <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>;
>>  					clocks = <&clks IMX6SX_CLK_LCDIF2_PIX>,
>>  						 <&clks IMX6SX_CLK_LCDIF_APB>,
>>  						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
> 
> 


-- 
Best regards,
Marek Vasut
