From: kapilh@broadcom.com (Kapil Hali)
Date: Thu, 15 Oct 2015 21:43:32 +0530
Subject: [PATCH 1/3] dt-bindings: add SMP enable-method for Broadcom NSP
In-Reply-To: <561ED6E8.4000208@hauke-m.de>
References: <1444844820-24290-1-git-send-email-kapilh@broadcom.com>
 <1444844820-24290-2-git-send-email-kapilh@broadcom.com>
 <561ED6E8.4000208@hauke-m.de>
Message-ID: <561FD0AC.50403@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/15/2015 3:57 AM, Hauke Mehrtens wrote:
> On 10/14/2015 07:46 PM, Kapil Hali wrote:
>> Add a compatible string "brcm,bcm-nsp-smp" for Broadcom's
>> Northstar Plus CPU to the 32-bit ARM CPU device tree binding
>> documentation file and create a new binding documentation for
>> Northstar Plus CPU pen-release mechanism.
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
>> +
>> +Example:
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		enable-method = "brcm,bcm-nsp-smp";
>> +		secondary-boot-reg = <0xffff042c>;
> 
> Isn't this some offset in a SRAM? If this is a SRAM it should be handled
> like it is done in some other SoC code.
> 
It is an internal SKU region. Is it handled differently in rest of the 
SoCs? What is that method?

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
>> index 91e6e5c..1172d9b 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> @@ -190,6 +190,7 @@ nodes to be present and contain the properties described below.
>>  			    "allwinner,sun6i-a31"
>>  			    "allwinner,sun8i-a23"
>>  			    "arm,psci"
>> +			    "brcm,bcm-nsp-smp"
>>  			    "brcm,brahma-b15"
>>  			    "marvell,armada-375-smp"
>>  			    "marvell,armada-380-smp"
>>
> 
Thanks,
Kapil
