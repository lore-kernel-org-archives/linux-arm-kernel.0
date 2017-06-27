From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Tue, 27 Jun 2017 08:08:30 +0000
Subject: [PATCH v2 1/5] dt-bindings: Document the STM32 DMAMUX bindings
In-Reply-To: <20170626192849.zd5e53cidgen3ypq@rob-hp-laptop>
References: <1498222853-11110-1-git-send-email-pierre-yves.mordret@st.com>
 <1498222853-11110-2-git-send-email-pierre-yves.mordret@st.com>
 <20170626192849.zd5e53cidgen3ypq@rob-hp-laptop>
Message-ID: <0437426e-b2cd-6bfb-4682-5cb393d118b8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/26/2017 09:28 PM, Rob Herring wrote:
> On Fri, Jun 23, 2017 at 03:00:49PM +0200, Pierre-Yves MORDRET wrote:
>> This patch adds the documentation of device tree bindings for the STM32
>> DMAMUX.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>      v2:
>>          * Move clock bindings from optional to mandatory one
>>          * Drop channelID bindings as managed dynamically from now on by
>>            DMAMUX driver.
>> ---
>> ---
>>   .../devicetree/bindings/dma/stm32-dmamux.txt       | 57 ++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/stm32-dmamux.txt b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
>> new file mode 100644
>> index 0000000..1d413c5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/stm32-dmamux.txt
>> @@ -0,0 +1,57 @@
>> +STM32 DMA MUX (DMA request router)
>> +
>> +Required properties:
>> +- compatible:	"st,stm32-dmamux"
> 
> This should be SoC specific (or at least have f4, h7, etc.).

Ok.
compatible:    "st,stm32h7-dmamux"

> 
>> +- reg:		Memory map for accessing module
>> +- #dma-cells:	Should be set to <3>.
>> +		For more details about the three cells, please see
>> +		stm32-dma.txt documentation binding file
> 
> The example below has 4 cells for the dma ctrlr?
> 

Yes.
DMA Controller has 4 cells and DMAMUX only 3.
But I agree this is not very clear. I should add a comment on each cells 
to highlight the mapping onto DMA Cells

>> +- dma-masters:	Phandle pointing to the DMA controller
>> +
>> +Optional properties:
>> +- dma-channels : Number of DMA channels supported.
>> +- dma-requests : Number of DMA requests supported.
>> +- resets: Reference to a reset controller asserting the DMA controller
>> +- clocks: Input clock of the DMAMUX instance.
>> +
>> +Example:
>> +
>> +/* DMA controller */
>> +dma2: dma-controller at 40026400 {
>> +	compatible = "st,stm32-dma";
>> +	reg = <0x40026400 0x400>;
>> +	interrupts = <56>,
>> +		     <57>,
>> +		     <58>,
>> +		     <59>,
>> +		     <60>,
>> +		     <68>,
>> +		     <69>,
>> +		     <70>;
>> +	clocks = <&clk_hclk>;
>> +	#dma-cells = <4>;
>> +	st,mem2mem;
>> +	resets = <&rcc 150>;
>> +	st,dmamux;
>> +	dma-channels = <8>;
>> +};
>> +
>> +/* DMA mux */
>> +dmamux2: dma-router at 40020820 {
>> +	compatible = "st,stm32-dmamux";
>> +	reg = <0x40020800 0x1c>;
>> +	#dma-cells = <3>;
>> +	dma-requests = <128>;
>> +	dma-masters = <&dma2>;
>> +};
>> +
>> +/* DMA client */
>> +usart1: serial at 40011000 {
>> +	compatible = "st,stm32-usart", "st,stm32-uart";
>> +	reg = <0x40011000 0x400>;
>> +	interrupts = <37>;
>> +	clocks = <&clk_pclk2>;
>> +	dmas = <&dmamux2 41 0x414 0>,
>> +	       <&dmamux2 42 0x414 0>;
>> +	dma-names = "rx", "tx";
>> +};
>> -- 
>> 1.9.1
>>

Py
