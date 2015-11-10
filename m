From: kapilh@broadcom.com (Kapil Hali)
Date: Tue, 10 Nov 2015 21:37:58 +0530
Subject: [PATCH v3 1/4] dt-bindings: add SMP enable-method for Broadcom NSP
In-Reply-To: <563E6FC7.6070700@gmail.com>
References: <1446844273-6460-1-git-send-email-kapilh@broadcom.com>
 <1446844273-6460-2-git-send-email-kapilh@broadcom.com>
 <563E6FC7.6070700@gmail.com>
Message-ID: <5642165E.1080408@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 11/8/2015 3:10 AM, Florian Fainelli wrote:
> Le 06/11/2015 13:11, Kapil Hali a ?crit :
>> Add a compatible string "brcm,bcm-nsp-smp" for Broadcom's
>> Northstar Plus CPU to the 32-bit ARM CPU device tree binding
>> documentation file and create a new binding documentation for
>> Northstar Plus CPU.
>>
>> Signed-off-by: Kapil Hali <kapilh@broadcom.com>
>> ---
>>  .../bindings/arm/bcm/brcm,nsp-cpu-method.txt       | 36 ++++++++++++++++++++++
>>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>>  2 files changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>> new file mode 100644
>> index 0000000..8506da7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>> @@ -0,0 +1,36 @@
>> +Broadcom Northstar Plus SoC CPU Enable Method
>> +---------------------------------------------
>> +This binding defines the enable method used for starting secondary
>> +CPUs in the following Broadcom SoCs:
>> +  BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
>> +
>> +The enable method is specified by defining the following required
>> +properties in the "cpus" device tree node:
>> +  - enable-method = "brcm,bcm-nsp-smp";
>> +  - secondary-boot-reg = <...>;
>> +
>> +The secondary-boot-reg property is a u32 value that specifies the
>> +physical address of the register used to request the ROM holding pen
>> +code release a secondary CPU.
> 
> Is it really how the ROM code is implemented, as a pen holding/release
> mechanism (which sounds like how this was implemented previously in the
> kernel actually) or should this be described in a more generic way as
> the physical address of the register where the secondary CPUs reset
> vector address must be written to? Or something along these lines.
> 
I overlooked this patch and didn't change the description. It is a physical
address of a register which holds the address of the secondary core's entry 
point.

>> +
>> +Example:
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		enable-method = "brcm,bcm-nsp-smp";
> 
> Just a nit, but if NSP and NS are sharing the same mechanism, would not
> a more "NS-centric" property be more appropriate because NS came before NSP?
> 
>> +		secondary-boot-reg = <0xffff042c>;
>> +
>> +		cpu0: cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a9";
>> +			next-level-cache = <&L2>;
>> +			reg = <0>;
>> +		};
>> +
>> +		cpu1: cpu at 1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a9";
>> +			next-level-cache = <&L2>;
>> +			reg = <1>;
>> +		};
>> +	};
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>> index 91e6e5c..6abe3f3 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> @@ -191,6 +191,7 @@ nodes to be present and contain the properties described below.
>>  			    "allwinner,sun8i-a23"
>>  			    "arm,psci"
>>  			    "brcm,brahma-b15"
>> +			    "brcm,bcm-nsp-smp"
>>  			    "marvell,armada-375-smp"
>>  			    "marvell,armada-380-smp"
>>  			    "marvell,armada-390-smp"
>>
> 
> 

Thanks,
Kapil Hali
