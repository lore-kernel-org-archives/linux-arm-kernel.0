From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 11 Jun 2018 17:27:20 -0700
Subject: [PATCH 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
In-Reply-To: <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
 <f5aa804e-3174-affd-1117-31b0a5b59fc5@gmail.com>
Message-ID: <522816f9-c33f-ee58-619e-84ee86dba418@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/11/2018 3:36 PM, Florian Fainelli wrote:
> On 05/29/2018 02:58 PM, Ray Jui wrote:
>> Change the PCIe INTx mapping to model the 4 INTx interrupts in the
>> IRQ domain of the iProc PCIe controller itself
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>   arch/arm/boot/dts/bcm-cygnus.dtsi | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index 699fdf9..6de21ef 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -254,9 +254,14 @@
>>   			compatible = "brcm,iproc-pcie";
>>   			reg = <0x18012000 0x1000>;
>>   
>> +			interrupt-controller;
>>   			#interrupt-cells = <1>;
>> -			interrupt-map-mask = <0 0 0 0>;
>> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>> +			interrupt-map-mask = <0 0 0 7>;
>> +			interrupt-map = <0 0 0 1 &pcie0 1>,
>> +					<0 0 0 2 &pcie0 2>,
>> +					<0 0 0 3 &pcie0 3>,
>> +					<0 0 0 4 &pcie0 4>;
>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
> 
> You would want to fix those IRQ_TYPE_NONE values as well because since
> commit 83a86fbb5b56b5eed8a476cc3fe214077d7c4f49 ("irqchip/gic: Loudly
> complain about the use of IRQ_TYPE_NONE") this is going to create some
> nice warnings on boot.
> 
> I am about to send fixes for NSP and HR2 since that's what I have access
> to at the moment, but it would be good if you could send updates to the
> Cygnus and NS2 DTS files?
> 
> Thanks
> 

Okay. Thanks for letting me know. How do you want this to be done for 
Cygnus and NS2?

I guess I should have the fix patches to DTS done and sent out first, 
and then rebase this INTx patch series against the patches with the fix.

Does that make sense to you?

Thanks,

Ray

>>   
>>   			linux,pci-domain = <0>;
>>   
>> @@ -289,9 +294,14 @@
>>   			compatible = "brcm,iproc-pcie";
>>   			reg = <0x18013000 0x1000>;
>>   
>> +			interrupt-controller;
>>   			#interrupt-cells = <1>;
>> -			interrupt-map-mask = <0 0 0 0>;
>> -			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
>> +			interrupt-map-mask = <0 0 0 7>;
>> +			interrupt-map = <0 0 0 1 &pcie1 1>,
>> +					<0 0 0 2 &pcie1 2>,
>> +					<0 0 0 3 &pcie1 3>,
>> +					<0 0 0 4 &pcie1 4>;
>> +			interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>>   
>>   			linux,pci-domain = <1>;
>>   
>>
> 
> 
