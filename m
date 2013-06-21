From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 21 Jun 2013 10:54:45 +0100
Subject: [PATCH 3/3] ARM: kernel: document ARM CPUs clocks and
 clock-frequency properties
In-Reply-To: <20130621093011.GB14268@e102568-lin.cambridge.arm.com>
References: <1371739146-32639-1-git-send-email-f.fainelli@gmail.com>
 <1371739146-32639-4-git-send-email-f.fainelli@gmail.com>
 <20130621093011.GB14268@e102568-lin.cambridge.arm.com>
Message-ID: <CAGVrzcZib6qBpugJn9WQ6hLo1EVkZB3r2PjbYwfvXOL3W5tbow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/21 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>:
> On Thu, Jun 20, 2013 at 03:39:06PM +0100, Florian Fainelli wrote:
>> ARM CPU device tree nodes may contain a "clock-frequency" property,
>> when set, this property must contain the CPU frequency in Hz,
>> which is then used by the topology parsing code in
>> arch/arm/kernel/topology.c to deduced the CPU capacity. The "clocks"
>> property, if present shall be a phandle to a valid clock node.
>>
>> Document thes properties to avoid any possible confusion on the
>> clock-frequency unit and also specify that "device_type" is also
>> used by the topology code.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/cpus.txt | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>> index f32494d..1ce1ace 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> @@ -10,7 +10,7 @@ http://devicetree.org
>>
>>  For the ARM architecture every CPU node must contain the following properties:
>>
>> -- device_type:       must be "cpu"
>> +- device_type:       must be "cpu". Use by the topology code.
>
> No. These are DT bindings, they are not related to kernel code and must
> be defined independently.

Ok.

>
>>  - reg:               property matching the CPU MPIDR[23:0] register bits
>>               reg[31:24] bits must be set to 0
>>  - compatible:        should be one of:
>> @@ -45,6 +45,11 @@ For the ARM architecture every CPU node must contain the following properties:
>>               "marvell,xsc3"
>>               "marvell,xscale"
>>
>> +- clocks:    phandle and clock specifier for the CPU clock, used if
>> +             "device_type" is present.
>
> "device_type" must be present, no "if" there (see latest bindings that are on
> their way to the kernel)
>
> git://linux-arm.org/linux-2.6-lp.git dt-cpus-bindings
>
> Then we can see if a "clocks" property is suitable here, and try to understand
> what needs to happen when a platform has DVFS capabilities. I need to think
> more about this.
>
>> +- clock-frequency: the frequency of the CPU, in Hz. Mandatory if "device_type"
>> +                is also present, used as fallback is "clocks" is not present.
> We should not define bindings to fix kernel code. Either "clock-frequency"
> is required or it is not, it should not depend on "device_type" being
> present and "device_type" is mandatory anyway. As I mentioned above, we
> still have to check how to handle multiple frequencies, and how to do it.
>
> I will give it more thought on my side.

Sure. On the short term, I think it would be wise to clarify that
"clock-frequency" must be in Hz so that people that define their
binding now get it correctly.
