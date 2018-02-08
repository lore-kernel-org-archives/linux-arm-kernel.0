From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 8 Feb 2018 14:22:00 -0800
Subject: [RFC PATCH] Documentation: DT: arm: Add topology property to
 define package boundaries
In-Reply-To: <20180208105702.GA1179@e107981-ln.cambridge.arm.com>
References: <20180122171534.7681-1-lorenzo.pieralisi@arm.com>
 <b58b99e8-dfa3-40d6-aba2-bc1f96170fd6@gmail.com>
 <20180208105702.GA1179@e107981-ln.cambridge.arm.com>
Message-ID: <d4ef76c3-fb4a-f879-44a8-7322ebde36ac@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/18 02:57, Lorenzo Pieralisi wrote:
> On Mon, Jan 22, 2018 at 08:45:26PM -0800, Frank Rowand wrote:
>> On 01/22/18 09:15, Lorenzo Pieralisi wrote:
>>> The current ARM DT topology description provides the operating system
>>> with a topological view of the system that is based on leaf nodes
>>> representing either cores or threads (in an SMT system) and a
>>> hierarchical set of cluster nodes that creates a hierarchical topology
>>> view of how those cores and threads are grouped.
>>>
>>> As opposed to the ACPI topology description ([1], PPTT table), this
>>> hierarchical representation of clusters does not allow to describe what
>>> topology level actually represents the physical package boundary, which
>>> is a key piece of information to be used by an operating system to
>>> optimize resource allocation and scheduling.
>>>
>>> Define an optional, backward compatible boolean property for cluster
>>> nodes that, by reusing the ACPI nomenclature, add to the ARM DT
>>> topological description a binding to define what cluster level
>>> represents a physical package boundary.
>>>
>>> [1] http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
>>>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Jeremy Linton <jeremy.linton@arm.com>
>>> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/topology.txt | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
>>> index de9eb0486630..8e78d76b0671 100644
>>> --- a/Documentation/devicetree/bindings/arm/topology.txt
>>> +++ b/Documentation/devicetree/bindings/arm/topology.txt
>>> @@ -109,6 +109,15 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
>>>  	The cluster node name must be "clusterN" as described in 2.1 above.
>>>  	A cluster node can not be a leaf node.
>>>  
>>> +	Properties for cluster nodes:
>>> +
>>> +	- physical-package
>>> +		Usage: optional
>>> +		Value type: <empty>
>>> +		Definition: if present the cluster node represents the
>>> +			    boundary of a physical package, whether socketed
>>> +			    or surface mounted.
>>
>> I don't know how to interpret this.  Is the node with this property inside
>> or outside the boundary?  If I had to guess, I would guess inside.  A few
>> extra words to clarify this please.
> 
> The node is neither inside nor outside, it _is_ the boundary. Every node
> defines a topology level - the property is there to define which one
> corresponds to a package, please let me know if it makes things clearer.

Not at all clear.

Using Example 1, from section "4 - Example dts" of topology.txt:


       cpu-map {
                cluster0 {
                        cluster0 {
                                core0 {
                                        thread0 {
                                                cpu = <&CPU0>;
                                        };
                                        thread1 {
                                                cpu = <&CPU1>;
                                        };
                                };

                                core1 {
                                        thread0 {
                                                cpu = <&CPU2>;
                                        };
                                        thread1 {
                                                cpu = <&CPU3>;
                                        };
                                };
                        };

                        cluster1 {
                                core0 {
                                        thread0 {
                                                cpu = <&CPU4>;
                                        };
                                        thread1 {
                                                cpu = <&CPU5>;
                                        };
                                };

                                core1 {
                                        thread0 {
                                                cpu = <&CPU6>;
                                        };
                                        thread1 {
                                                cpu = <&CPU7>;
                                        };
                                };
                        };
                };

Pretend that cpu-map/cluster0/cluster0 is a physical package that
contains two cores, and cpu-map/cluster0/cluster1 is another
physical package that contains two cores.  My guess as to how
to use the property "physical-package" would be to place it
in nodes cpu-map/cluster0/cluster0 and cpu-map/cluster0/cluster1.
In that case, those two nodes are on the "inside" of two different
packages.

The alternate way to use the property "physical-package" would be
to place it in node cpu-map/cluster0.  In this case, the node is
"outside" of the packages.

Again, I suspect that the intended use is the first of my two
examples, but the proposed binding wording does not make that
clear to me.  My use of "inside" and "outside" may not be the
proper words or concept, but the binding somehow needs to
say which of my two above example locations is the correct place
to use the "physical-package" property.

-Frank

> 
> Thanks,
> Lorenzo
> 
>>> +
>>>  	A cluster node's child nodes must be:
>>>  
>>>  	- one or more cluster nodes; or
>>>
>>
> .
> 
