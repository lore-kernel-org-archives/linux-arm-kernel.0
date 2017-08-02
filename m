From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 2 Aug 2017 22:33:15 +0530
Subject: [PATCH 1/6] dt-bindings: ti, edma: Add 66AK2G specific information
In-Reply-To: <31fe2206-675b-5425-412f-0033017f6511@ti.com>
References: <20170801044119.16201-1-lokeshvutla@ti.com>
 <20170801044119.16201-2-lokeshvutla@ti.com>
 <31fe2206-675b-5425-412f-0033017f6511@ti.com>
Message-ID: <f1d0ec82-6b93-9eff-9a7f-08994ffebcb4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/1/2017 6:20 PM, Peter Ujfalusi wrote:
> 
> 
> On 2017-08-01 07:41, Lokesh Vutla wrote:
>> Update ti,edma binding documentation to reflect 66AK2G specific
>> properties.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  Documentation/devicetree/bindings/dma/ti-edma.txt | 95
>> +++++++++++++++++++++--
>>  1 file changed, 90 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt
>> b/Documentation/devicetree/bindings/dma/ti-edma.txt
>> index 18090e7226b4..05fe2931d025 100644
>> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
>> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
>> @@ -9,7 +9,12 @@ execute the actual DMA tansfer.
>>  eDMA3 Channel Controller
>>
>>  Required properties:
>> -- compatible:    "ti,edma3-tpcc" for the channel controller(s)
>> +--------------------
>> +- compatible:    Should be:
>> +        - "ti,edma3-tpcc" for the channel controller(s) on OMAP,
>> +          AM33xx and AM43xx SoCs.
>> +        - "ti,k2g-edma3-tpcc", "ti,edma3-tpcc" for the
>> +          channel controller(s) on 66AK2G.
>>  - #dma-cells:    Should be set to <2>. The first number is the DMA
>> request
>>          number and the second is the TC the channel is serviced on.
>>  - reg:        Memory map of eDMA CC
>> @@ -19,8 +24,19 @@ Required properties:
>>  - ti,tptcs:    List of TPTCs associated with the eDMA in the
>> following form:
>>          <&tptc_phandle TC_priority_number>. The highest priority is 0.
>>
>> +SoC-specific Required properties:
>> +--------------------------------
>> +The following are mandatory properties for OMAP, AM33xx and AM43xx
>> SoCs only:
>> +- ti,hwmods:    Name of the hwmods associated to the eDMA CC.
>> +
>> +The following are mandatory properties for 66AK2G SoCs only:
>> +- power-domains:Should contain a phandle to a PM domain provider node
>> +        and an args specifier containing the device id
>> +        value. This property is as per the binding,
>> +        Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>> +
>>  Optional properties:
>> -- ti,hwmods:    Name of the hwmods associated to the eDMA CC
>> +-------------------
>>  - ti,edma-memcpy-channels: List of channels allocated to be used for
>> memcpy, iow
>>          these channels will be SW triggered channels. See example.
>>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be
>> used by
>> @@ -31,17 +47,34 @@ Optional properties:
>>  eDMA3 Transfer Controller
>>
>>  Required properties:
>> -- compatible:    "ti,edma3-tptc" for the transfer controller(s)
>> +--------------------
>> +- compatible:    Should be:
>> +        - "ti,edma3-tptc" for the transfer controller(s) on OMAP,
>> +          AM33xx and AM43xx SoCs.
>> +        - "ti,k2g-edma3-tptc", "ti,edma3-tptc" for the
>> +          transfer controller(s) on 66AK2G.
>>  - reg:        Memory map of eDMA TC
>>  - interrupts:    Interrupt number for TCerrint.
>>
>> +SoC-specific Required properties:
>> +--------------------------------
>> +The following are mandatory properties for OMAP, AM33xx and AM43xx
>> SoCs only:
>> +- ti,hwmods:    Name of the hwmods associated to the eDMA TC.
>> +
>> +The following are mandatory properties for 66AK2G SoCs only:
>> +- power-domains:Should contain a phandle to a PM domain provider node
>> +        and an args specifier containing the device id
>> +        value. This property is as per the binding,
>> +        Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>> +
>>  Optional properties:
>> -- ti,hwmods:    Name of the hwmods associated to the given eDMA TC
>> +-------------------
>>  - interrupt-names: "edma3_tcerrint"
>>
>>  ------------------------------------------------------------------------------
>>
>> -Example:
>> +Examples:
> 
> Do we really need to expand the examples to have identical set, but with
> power-domains?

IIRC, there was a feedback to add an example(not able to fine that
specific email). If you strongly disagree with this, I can drop it and
resend it.

Thanks and regards,
Lokesh

> 
>>
>> +1.
>>  edma: edma at 49000000 {
>>      compatible = "ti,edma3-tpcc";
>>      ti,hwmods = "tpcc";
>> @@ -109,6 +142,58 @@ mcasp0: mcasp at 48038000 {
>>      dma-names = "tx", "rx";
>>  };
>>
>> +2.
>> +edma1: edma at 02728000 {
>> +    compatible = "ti,k2g-edma3-tpcc", "ti,edma3-tpcc";
>> +    reg =    <0x02728000 0x8000>;
>> +    reg-names = "edma3_cc";
>> +    interrupts = <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
>> +            <GIC_SPI 219 IRQ_TYPE_EDGE_RISING>,
>> +            <GIC_SPI 220 IRQ_TYPE_EDGE_RISING>;
>> +    interrupt-names = "edma3_ccint", "emda3_mperr",
>> +              "edma3_ccerrint";
>> +    dma-requests = <64>;
>> +    #dma-cells = <2>;
>> +
>> +    ti,tptcs = <&edma1_tptc0 7>, <&edma1_tptc1 0>;
>> +
>> +    /*
>> +     * memcpy is disabled, can be enabled with:
>> +     * ti,edma-memcpy-channels = <12 13 14 15>;
>> +     * for example.
>> +     */
>> +
>> +    power-domains = <&k2g_pds 0x4f>;
>> +};
>> +
>> +edma1_tptc0: tptc at 027b0000 {
>> +    compatible = "ti,k2g-edma3-tptc", "ti,edma3-tptc";
>> +    reg =    <0x027b0000 0x400>;
>> +    power-domains = <&k2g_pds 0x4f>;
>> +};
>> +
>> +edma1_tptc1: tptc at 027b8000 {
>> +    compatible = "ti, k2g-edma3-tptc", "ti,edma3-tptc";
>> +    reg =    <0x027b8000 0x400>;
>> +    power-domains = <&k2g_pds 0x4f>;
>> +};
>> +
>> +mmc0: mmc at 23000000 {
>> +    compatible = "ti,k2g-hsmmc", "ti,omap4-hsmmc";
>> +    reg = <0x23000000 0x400>;
>> +    interrupts = <GIC_SPI 96 IRQ_TYPE_EDGE_RISING>;
>> +    dmas = <&edma1 24 0>, <&edma1 25 0>;
>> +    dma-names = "tx", "rx";
>> +    bus-width = <4>;
>> +    ti,needs-special-reset;
>> +    no-1-8-v;
>> +    max-frequency = <96000000>;
>> +    power-domains = <&k2g_pds 0xb>;
>> +    clocks = <&k2g_clks 0xb 1>, <&k2g_clks 0xb 2>;
>> +    clock-names = "fck", "mmchsdb_fck";
>> +    status = "disabled";
>> +};
>> +
>>  ------------------------------------------------------------------------------
>>
>>  DEPRECATED binding, new DTS files must use the
>> ti,edma3-tpcc/ti,edma3-tptc
>>  binding.
>>
> 
> - P?ter
