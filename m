From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 28 Jun 2016 17:15:37 +0800
Subject: [PATCH 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <57714C85.50802@wwwdotorg.org>
References: <20160627090248.23621-1-josephl@nvidia.com>
 <20160627090248.23621-2-josephl@nvidia.com> <57714C85.50802@wwwdotorg.org>
Message-ID: <57724039.7080007@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2016 11:55 PM, Stephen Warren wrote:
> On 06/27/2016 03:02 AM, Joseph Lo wrote:
>> Add DT binding for the Hardware Synchronization Primitives (HSP). The
>> HSP is designed for the processors to share resources and communicate
>> together. It provides a set of hardware synchronization primitives for
>> interprocessor communication. So the interprocessor communication (IPC)
>> protocols can use hardware synchronization primitive, when operating
>> between two processors not in an SMP relationship.
>
> This binding is quite different to the binding you sent to internal IP
> review. I wonder why it changed? Specific comments below:
>
Due to some enhancements for supporting multiple functions of HSP 
sub-modules in the same driver, I re-wrote some parts of the bindings 
and driver.

>> diff --git
>> a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>> b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>
>> +NVIDIA Tegra Hardware Synchronization Primitives (HSP)
>> +
>> +The HSP modules are used for the processors to share resources and
>> communicate
>> +together. It provides a set of hardware synchronization primitives for
>> +interprocessor communication. So the interprocessor communication (IPC)
>> +protocols can use hardware synchronization primitives, when operating
>> between
>> +two processors not in an SMP relationship.
>> +
>> +The features that HSP supported are shared mailboxes, shared semaphores,
>> +arbitrated semaphores and doorbells.
>> +
>> +Required properties:
>> +- name : Should be hsp
>> +- compatible : Should be "nvidia,tegra<chip>-hsp"
>
> I think this should explicitly list the value values of the compatible
> property, rather than being a generic/wildcard description:
>
> - compatible
>      Array of strings.
>      One of:
>    - "nvidia,tegra186-hsp"
>
> If/when this binding supports other SoCs in the future, we'll add more
> entries into that list.
>
>> +- reg : Offset and length of the register set for the device
>> +- interrupts : Should contain the HSP interrupts
>> +- interrupt-names: Should contain the names of the HSP interrupts
>> that the
>> +           client are using.
>> +           "doorbell"
>
> The binding should describe the HW, and not be affected by anything
> "that the client(s) are using". If there are multiple interrupts, we
> should list them all here, from the start.
>
> When revising this, I would consider the following wording canonical:
Okay.
>
> - interrupt-names
>      Array of strings.
>      Contains a list of names for the interrupts described by the
>      interrupts property. May contain the following entries, in any
>      order:
>      - "doorbell"
>      - "..." (no doubt many more items will be listed here, e.g.
>        for semaphores, etc.).
I think I will just list "doorbell" for now. And adding more later once 
we add other HSP sub-module support.

>      Users of this binding MUST look up entries in the interrupts
>      property by name, using this interrupts-names property to do so.
> - interrupts
>      Array of interrupt specifiers.
>      Must contain one entry per entry in the interrupt-names property,
>      in a matching order.
>
>> +- nvidia,hsp-function : Specifies one of the HSP functions that the
>> HSP unit
>> +            will be supported. The function ID can be found in the
>> +            header file <dt-bindings/mailbox/tegra-hsp.h>.
>
> This property wasn't in the internal patch.
>
> This doesn't make sense. The HW feature-set is fixed. This sounds like
> some kind of software configuration option, or a way to allow different
> drivers to handle different aspects of the HW? In general, the binding
> shouldn't be influenced by software structure. Please delete this property.
>
> Now, if you're attempting to set up a binding where each function
> (semaphores, shared mailboxes, doorbells, etc.) has a different DT node,
> then (a) splitting up HW modules into sub-blocks has usually turned out
> to be a mistake in the past, and (b) the differences should likely be
> represented by using a different compatible property for each
> sub-component, rather than via a custom property.

Currently the usage of HSP HW in the downstream kernel is something like 
the model below.

remote_processor_A-\
remote_processor_B--->hsp at 1000 (doorbell func) <-> host CPU
remote_processor_C-/

remote_processor_D -> hsp at 2000 (shared mailbox) <-> CPU

remote_processor_E -> hsp at 3000 (shared mailbox) <-> CPU

I am thinking if we can just add the appropriate compatible strings for 
it to replace "nvidia,tegra186-hsp". e.g. "nvidia,tegra186-hsp-doorbell" 
and "nvidia,tegra186-hsp-sharedmailbox". So the driver can probe and 
initialize correctly depend on the compatible property. How do you think 
about it? Is this the same as the (b) you mentioned above?

>
>
> The following properties were included in the internal patch:
>
>                  nvidia,num-SM = <0x8>;
>                  nvidia,num-AS = <0x2>;
>                  nvidia,num-SS = <0x2>;
>                  nvidia,num-DB = <0x7>;
>                  nvidia,num-SI = <0x8>;
>
> ... yet aren't here. True the compatible value implies those values; was
> that why the properties were removed?
Because these values are available in the HSP_INT_DIMENSIONING register, 
so remove them.

>
>> +Example:
>> +
>> +hsp_top: hsp at 3c00000 {
> ...
>> +bpmp at d0000000 {
>> +    ...
>> +    mboxes = <&hsp_top HSP_DB_MASTER_BPMP>;
>> +    ...
>> +};
>
> I'd suggest not including the bpmp node in the example, since it's not
> part of the HSP node. If you do, recall that bpmp has no reg property
> and hence the node name shouldn't include a unit address.
Okay.
>
>> diff --git a/include/dt-bindings/mailbox/tegra-hsp.h
>> b/include/dt-bindings/mailbox/tegra-hsp.h
>
> This file should probably be named tegra186-hsp, since I doubt the
> master ID values will be stable between chips.
Yes, true. Will fix.
>
>> +/*
>> + * This header provides constants for binding nvidia,tegra<chip>-hsp.
>
> That should say "186" not "<chip>"
>
>> +#ifndef _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H
>> +#define _DT_BINDINGS_MAILBOX_TEGRA186_HSP_H
>
> The two changes mentioned above would be consistent with that include
> guard's name including the text "186".
>
>> +#define HSP_SHARED_MAILBOX        0
>> +#define HSP_SHARED_SEMAPHORE        1
>> +#define HSP_ARBITRATED_SEMAPHORE    2
>> +#define HSP_DOORBELL            3
>
> I think those should be removed, along with the nvidia,hsp-function
> property.
>
Okay.

Thanks,
-Joseph
