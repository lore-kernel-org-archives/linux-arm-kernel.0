From: robherring2@gmail.com (Rob Herring)
Date: Fri, 23 Aug 2013 14:30:44 -0500
Subject: [PATCH v2] dt: update PSCI binding documentation for v0.2
In-Reply-To: <20130823172452.GF7015@e106331-lin.cambridge.arm.com>
References: <1377270613-28435-1-git-send-email-robherring2@gmail.com>
 <20130823172452.GF7015@e106331-lin.cambridge.arm.com>
Message-ID: <5217B864.802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 12:24 PM, Mark Rutland wrote:
> On Fri, Aug 23, 2013 at 04:10:13PM +0100, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> The PSCI spec from ARM has been updated to 0.2 version. Update the
>> binding document to reflect the spec changes. For the binding, the
>> major changes are addition of system reset and poweroff functions.
>> The recommended function id numbering has also changed.
>>
>> This update also defines 32 and 64 bit calling conventions. The calling
>> convention is defined by the method property.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <Ian.Campbell@citrix.com>
>> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>,
>> Cc: Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>
>> Cc: Matt Sealey <neko@bakuhatsu.net>
>> Cc: devicetree at vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/arm/psci.txt | 85 +++++++++++++++++++++-----
>>  1 file changed, 69 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
>> index 433afe9..2c03d0b 100644
>> --- a/Documentation/devicetree/bindings/arm/psci.txt
>> +++ b/Documentation/devicetree/bindings/arm/psci.txt
>> @@ -1,16 +1,17 @@
>>  * Power State Coordination Interface (PSCI)
>>  
>>  Firmware implementing the PSCI functions described in ARM document number
>> -ARM DEN 0022A ("Power State Coordination Interface System Software on ARM
>> +ARM DEN 0022B ("Power State Coordination Interface System Software on ARM
>>  processors") can be used by Linux to initiate various CPU-centric power
>>  operations.
>>  
>> -Issue A of the specification describes functions for CPU suspend, hotplug
>> -and migration of secure software.
>> +Issue B of the specification describes functions for CPU suspend, hotplug,
>> +migration of secure software, and system level reset and powerdown.
>>  
>>  Functions are invoked by trapping to the privilege level of the PSCI
>>  firmware (specified as part of the binding below) and passing arguments
>> -in a manner similar to that specified by AAPCS:
>> +as defined in ARM document "SMC Calling Convention" (ARM DEN 0028) in a manner
>> +similar to that specified by AAPCS:
>>  
>>  	 r0		=> 32-bit Function ID / return value
>>  	{r1 - r3}	=> Parameters
>> @@ -21,16 +22,37 @@ to #0.
>>  
>>  Main node required properties:
>>  
>> - - compatible    : Must be "arm,psci"
>> + - compatible    : Must be "arm,psci-0.2" or "arm,psci"
>>  
>> - - method        : The method of calling the PSCI firmware. Permitted
>> -                   values are:
>> + - method        : The method defines the calling convention for the PSCI
>> +                   firmware. If the firmware supports multiple calling
>> +                   conventions (i.e. 32 and 64 bit), then the DT shall have a
>> +                   node for each method. Permitted values are:
> 
> I really don't see the point in a node per method when I described how
> we could handle this in a single node last time [1], in a way that was
> backwards-compatible with the existing binding.
> 
>>  
>>                     "smc" : SMC #0, with the register assignments specified
>> -		           in this binding.
>> +		           in this binding (deprecated, "arm,psci" only).
>> +
>> +                   "smc32" : SMC #0, using 32-bit SMC calling convention with
>> +                             32-bit register assignments specified in this
>> +                             binding.
>> +
>> +                   "smc64" : SMC #0, using 64-bit SMC calling convention with
>> +                             64-bit register assignments specified in this
>> +                             binding.
>>  
>>                     "hvc" : HVC #0, with the register assignments specified
>> -		           in this binding.
>> +		           in this binding (deprecated, "arm,psci" only).
>> +
>> +                   "hvc32" : HVC #0, using 32-bit HVC calling convention with
>> +                             32-bit register assignments specified in this
>> +                             binding.
>> +
>> +                   "hvc64" : HVC #0, using 64-bit HVCC calling convention with
>> +                             64-bit register assignments specified in this
>> +                             binding.
> 
> I also don't think the bit-widths of function IDs are a property of the
> conduit used.

Right, function IDs are 32-bit, but the register arguments can be 64-bit.

> 
>> +
>> + - psci_version  : Function ID for PSCI_VERSION operation. Required for
>> +                   "arm,psci-0.2" compatible version or later.
>>  
>>  Main node optional properties:
>>  
>> @@ -40,16 +62,47 @@ Main node optional properties:
>>  
>>   - cpu_on        : Function ID for CPU_ON operation
>>  
>> + - affinity_info : Function ID for AFFINITY_INFO operation
>> +
>>   - migrate       : Function ID for MIGRATE operation
>>  
>> + - migrate_info_type : Function ID for MIGRATE_INFO_TYPE operation
>> +
>> + - migrate_info_up_cpu : Function ID for MIGRATE_INFO_UP_CPU operation
>> +
>> + - system_reset  : Function ID for SYSTEM_RESET operation
>> +
>> + - system_off    : Function ID for SYSTEM_OFF operation
>> +
>>  
>>  Example:
>>  
>> -	psci {
>> -		compatible	= "arm,psci";
>> -		method		= "smc";
>> -		cpu_suspend	= <0x95c10000>;
>> -		cpu_off		= <0x95c10001>;
>> -		cpu_on		= <0x95c10002>;
>> -		migrate		= <0x95c10003>;
>> +	psci32 {
>> +		compatible	= "arm,psci-0.2";
>> +		method		= "smc32";
>> +		psci_version	= <0x84000000>;
>> +		cpu_suspend	= <0x84000001>;
>> +		cpu_off		= <0x84000002>;
>> +		cpu_on		= <0x84000003>;
>> +		affinity_info	= <0x84000004>; 
>> +		migrate		= <0x84000005>;
>> +		migrate_info_type = <0x84000006>;
>> +		migrate_info_up_cpu = <0x84000007>;
>> +		system_off	= <0x84000008>; 
>> +		system_reset	= <0x84000009>; 
>> +	};
>> +
>> +	psci64 {
>> +		compatible	= "arm,psci-0.2";
>> +		method		= "smc64";
>> +		psci_version	= <0x84000000>;
>> +		cpu_suspend	= <0xc4000001>;
>> +		cpu_off		= <0x84000002>;
>> +		cpu_on		= <0xc4000003>;
>> +		affinity_info	= <0xc4000004>; 
>> +		migrate		= <0xc4000005>;
>> +		migrate_info_type = <0x84000006>;
>> +		migrate_info_up_cpu = <0xc4000007>;
>> +		system_off	= <0x84000008>; 
>> +		system_reset	= <0x84000009>; 
>>  	};
> 
> With that style of binding we can't use a new DT with an old kernel,
> despite the fact the actual firmware interface is compatible. I believe
> having this as one node, with $FUNCTION, $FUNCTION-32, and $FUNCTION-64
> variants makes much more sense.
> 
> Consider KVM. If we want to provide new functionality (e.g.
> affinity_info) without breaking compatibility with older kernels, we'd
> have to embed three device nodes repeatedly describing the same IDs.
> That's a complete waste when we can handle this in a single node, taking
> up less space with some degree of forwards compatibility:

I don't really have a strong opinion either way. I happen to prefer
multiple nodes as Matt had proposed, but am okay with this. I really
just want to get system reset and off added so I can finish highbank
support.

> psci {
> 	compatible = "arm,psci-0.2", "arm,psci";
> 	method = "smc";
> 
> 	/* common IDs for 32-bit and 64-bit */
> 	cpu_off = <0x1>;
> 	cpu_on = <0x2>;
> 	cpu_suspend = <0x3>;
> 
> 	/* different IDs for 64-bit and 32-bit */
> 	psci_version32 = <0xbbbb>;
> 	psci_version64 = <0xdddd>;

According to the spec, psci_version is the same for 32 and 64-bit. For
functions like that, do we need to specify the size?

Rob

> 	migrate_info_type32 = <0x57>;
> 	migrate_info_type64 = <0xb7>;
> };
> 
> Thanks,
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187725.html
> 
