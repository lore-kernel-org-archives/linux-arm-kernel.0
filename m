From: robherring2@gmail.com (Rob Herring)
Date: Fri, 23 Aug 2013 14:06:17 -0500
Subject: [PATCH v2] dt: update PSCI binding documentation for v0.2
In-Reply-To: <20130823163233.GA29368@localhost.localdomain>
References: <1377270613-28435-1-git-send-email-robherring2@gmail.com>
 <20130823163233.GA29368@localhost.localdomain>
Message-ID: <5217B2A9.2010305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 11:32 AM, Dave Martin wrote:
> On Fri, Aug 23, 2013 at 10:10:13AM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>

[snip]

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
> If I've understood right, the "foo32" and "foo64" methods can't be
> allowed for "arm,psci .  The arm,psci and arm,psci-0.2 method
> sets are mutually exclusive, so we can't have "arm,psci" and
> "arm,psci-0.2" on the same node.
> 
> There must also not be more than one "arm,psci" node, because that will
> cause old kernels to mis-probe (and maybe fail) depending arbitrarily
> on which node is matched first from the DT.
> 
> 0.2-compliant platforms which provide a backwards-compatible interface
> would need to provide 2 or 3 nodes in most situations (one arm,psci node,
> and one (32 bit only) or two (32 + 64-bit) arm,psci-0.2 nodes depending
> on whether the platform is 64-bit capable).
> 
> If that's correct, we should add some clarification here to make
> sure the intent of the binding is not misunderstood.

Yes, I will make that more clear.

>> +
>> +	psci64 {
>> +		compatible	= "arm,psci-0.2";
>> +		method		= "smc64";
>> +		psci_version	= <0x84000000>;
> 
> Why didn't some of these change to match the modified spec?

You mean why is it not 0xc4000000? Read the spec. It is kind of screwy
that functions which don't need 64-bit parameters, only have the 32-bit
variant.

Rob

> 
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
>> -- 
>> 1.8.1.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
