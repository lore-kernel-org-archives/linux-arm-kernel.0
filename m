From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Oct 2014 10:39:40 +0200
Subject: [PATCH] at91: sam9x5 dt: add usart dma definitions to dt
In-Reply-To: <20141010081229.GD13921@ldesroches-Latitude-E6320>
References: <775af3ca3993517ceeb45da786dd69a4d000829b.1412922258.git.jiri.prchal@aksignal.cz>
 <20141010081229.GD13921@ldesroches-Latitude-E6320>
Message-ID: <54379B4C.8060703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2014 10:12, Ludovic Desroches :
> Hi,
> 
> On Fri, Oct 10, 2014 at 08:35:56AM +0200, Jiri Prchal wrote:
>> This patch adds usart dma definitions to both dtsi for sam9x5 chips. Without
>> usage of dma it's unable to catch all bytes on usart receiver.

At which speed, with which kind of load on the CPU?

> Adding DMA configuration is a good idea. But I think we will have an
> issue because we have too many requested channels for DMA0.
> 
> Adding usart0, 9 dma channels will be requested. So a choice has to be
> done. On DMA0 we have:
> - 2 channels for SSC,
> - 1 channel for MMC,
> - 2 channels for I2C0,
> - 2 channels for SPI0,
> - 2 channels for USART0.

Yes, so maybe disable the DMA for SPI0. But the decision is pretty
related to the use of the board. So I would not change things...

> I have only mentioned enabled devices.

Yes indeed,

So maybe we can add the "dmas" properties in the files mentioned by
Jiri, but not enable them like you did Ludovic in this patch:

d24cd78399a3625a69887c8124638260c1c37a2b (ARM: at91: sama5d3: add usart
dma configurations)

Bye,


>> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
>> ---
>>  arch/arm/boot/dts/at91sam9x5.dtsi        | 20 ++++++++++++++++++++
>>  arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  5 +++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
>> index 726274f..f9acf6d 100644
>> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
>> @@ -860,6 +860,11 @@
>>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>>  				pinctrl-names = "default";
>>  				pinctrl-0 = <&pinctrl_dbgu>;
>> +				atmel,use-dma-tx;
>> +				atmel,use-dma-rx;
>> +				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(8)>,
>> +				       <&dma1 1 (AT91_DMA_CFG_PER_ID(9) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
>> +				dma-names = "tx", "rx";
>>  				clocks = <&mck>;
>>  				clock-names = "usart";
>>  				status = "disabled";
>> @@ -871,6 +876,11 @@
>>  				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
>>  				pinctrl-names = "default";
>>  				pinctrl-0 = <&pinctrl_usart0>;
>> +				atmel,use-dma-rx;
>> +				atmel,use-dma-tx;
>> +				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(3)>,
>> +				       <&dma0 1 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
>> +				dma-names = "tx", "rx";
>>  				clocks = <&usart0_clk>;
>>  				clock-names = "usart";
>>  				status = "disabled";
>> @@ -882,6 +892,11 @@
>>  				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
>>  				pinctrl-names = "default";
>>  				pinctrl-0 = <&pinctrl_usart1>;
>> +				atmel,use-dma-rx;
>> +				atmel,use-dma-tx;
>> +				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(5)>,
>> +				       <&dma0 1 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
>> +				dma-names = "tx", "rx";
>>  				clocks = <&usart1_clk>;
>>  				clock-names = "usart";
>>  				status = "disabled";
>> @@ -893,6 +908,11 @@
>>  				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
>>  				pinctrl-names = "default";
>>  				pinctrl-0 = <&pinctrl_usart2>;
>> +				atmel,use-dma-rx;
>> +				atmel,use-dma-tx;
>> +				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(12)>,
>> +				       <&dma1 1 (AT91_DMA_CFG_PER_ID(13) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
>> +				dma-names = "tx", "rx";
>>  				clocks = <&usart2_clk>;
>>  				clock-names = "usart";
>>  				status = "disabled";
>> diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
>> index 140217a5..731da0e 100644
>> --- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
>> @@ -57,6 +57,11 @@
>>  				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
>>  				pinctrl-names = "default";
>>  				pinctrl-0 = <&pinctrl_usart3>;
>> +				atmel,use-dma-rx;
>> +				atmel,use-dma-tx;
>> +				dmas = <&dma1 1 AT91_DMA_CFG_PER_ID(14)>,
>> +				       <&dma1 1 (AT91_DMA_CFG_PER_ID(15) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
>> +				dma-names = "tx", "rx";
>>  				clocks = <&usart3_clk>;
>>  				clock-names = "usart";
>>  				status = "disabled";
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 


-- 
Nicolas Ferre
