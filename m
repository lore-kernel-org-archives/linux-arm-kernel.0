From: robherring2@gmail.com (Rob Herring)
Date: Wed, 23 Jan 2013 07:55:26 -0600
Subject: [PATCH] ARM: dts: specify all the per-cpu interrupts of arch
 timer for exynos5440
In-Reply-To: <20130123103614.GD32237@e106331-lin.cambridge.arm.com>
References: <1358818887-16870-1-git-send-email-kgene.kim@samsung.com>
 <20130122101554.GA18876@e106331-lin.cambridge.arm.com>
 <063f01cdf8ec$926cda30$b7468e90$@samsung.com>
 <20130123103614.GD32237@e106331-lin.cambridge.arm.com>
Message-ID: <50FFEBCE.3080502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2013 04:36 AM, Mark Rutland wrote:
> On Tue, Jan 22, 2013 at 10:05:18PM +0000, Kukjin Kim wrote:
>> Mark Rutland wrote:
>>>
>> + devicetree-discuss, Grant Likely, Rob Herring and Tony Lindgren
>>  
>>> On Tue, Jan 22, 2013 at 01:41:27AM +0000, Kukjin Kim wrote:
>>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>>
>>>> Need to be changed requirements in the 'cpus' node for exynos5440
>>>> to specify all the per-cpu interrupts of arch timer.
>>>
>>> The node(s) for the arch timer should not be in the cpus/cpu at N nodes.
>>> Instead, there should be one node (in the root of the tree).
>>>
>> Well, I don't think so. As per my understanding, the local timers are
>> attached to every ARM cores (cpus) and it generates certain interrupt to the
>> GIC. So the correct representation for this in device tree is to include the
>> interrupts in the cpu nodes in dts file. Your comments  refer to a
>> limitation in the Linux kernel implementation of the arch_timer and it
>> should not result in representing the hardware details incorrectly in the
>> dts file.
> 
> I disagree. The "correct representation" is whatever the devicetree binding
> documentation describes. It does not describe placing timer nodes in the cpu
> nodes.

I don't think we should add other nodes to /cpus besides cpu nodes.

The presence of architected timers is defined by the cpu being a
Cortex-A15. So you don't really need a timer node at all. All that is
really needed is the interrupt. You could add interrupts property
directly to each cpu node. The location of PMU nodes has come up
recently as well, and the PMU interrupt could be added as well.

Whether we should change the binding at this point is questionable.
Normally, we wouldn't want to do that, but as this is all pretty new it
may be okay to make an exception here. However, I don't see anything
that is fundamentally broken with the current binding. Multi-cluster
could introduce some issues.

>>
>>> If this works currently it's only because the driver picks up one of the
>> nodes,
>>> and luckily it's the same as the others. This is not guaranteed to work in
>>> future, and will likely break.
>>>
>> It is up to the Linux kernel implementation of arch_timer to handle the
>> hardware details in dts file accordingly.
> 
> The binding specification does not specify that there should be multiple timer
> nodes, nor does it specify that they should be under cpu nodes. The timers,
> being a banked resource, can be described with one node.
> 
> It is not up to the Linux kernel to handle undocumented variations of bindings.

Except things done before documentation was enforced.

Rob
