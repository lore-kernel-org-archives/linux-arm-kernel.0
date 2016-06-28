From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 Jun 2016 13:08:02 -0600
Subject: [PATCH 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <57724039.7080007@nvidia.com>
References: <20160627090248.23621-1-josephl@nvidia.com>
 <20160627090248.23621-2-josephl@nvidia.com> <57714C85.50802@wwwdotorg.org>
 <57724039.7080007@nvidia.com>
Message-ID: <5772CB12.5080408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2016 03:15 AM, Joseph Lo wrote:
> On 06/27/2016 11:55 PM, Stephen Warren wrote:
>> On 06/27/2016 03:02 AM, Joseph Lo wrote:
>>> Add DT binding for the Hardware Synchronization Primitives (HSP). The
>>> HSP is designed for the processors to share resources and communicate
>>> together. It provides a set of hardware synchronization primitives for
>>> interprocessor communication. So the interprocessor communication (IPC)
>>> protocols can use hardware synchronization primitive, when operating
>>> between two processors not in an SMP relationship.
>>
>> This binding is quite different to the binding you sent to internal IP
>> review. I wonder why it changed? Specific comments below:
>
> Due to some enhancements for supporting multiple functions of HSP
> sub-modules in the same driver, I re-wrote some parts of the bindings
> and driver.
>
>>> diff --git
>>> a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
>>> b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt

>>> +- reg : Offset and length of the register set for the device
>>> +- interrupts : Should contain the HSP interrupts
>>> +- interrupt-names: Should contain the names of the HSP interrupts
>>> that the
>>> +           client are using.
>>> +           "doorbell"
>>
>> The binding should describe the HW, and not be affected by anything
>> "that the client(s) are using". If there are multiple interrupts, we
>> should list them all here, from the start.
>>
>> When revising this, I would consider the following wording canonical:
>>
>> - interrupt-names
>>      Array of strings.
>>      Contains a list of names for the interrupts described by the
>>      interrupts property. May contain the following entries, in any
>>      order:
>>      - "doorbell"
>>      - "..." (no doubt many more items will be listed here, e.g.
>>        for semaphores, etc.).
 >
> I think I will just list "doorbell" for now. And adding more later once
> we add other HSP sub-module support.

That should be OK; adding more entries in interrupt-names is backwards 
compatible. Still, since the HW is fixed, it would be nice to just get 
the complete list documented up front if possible.

>>> +- nvidia,hsp-function : Specifies one of the HSP functions that the HSP unit
>>> +            will be supported. The function ID can be found in the
>>> +            header file <dt-bindings/mailbox/tegra-hsp.h>.
>>
>> This property wasn't in the internal patch.
>>
>> This doesn't make sense. The HW feature-set is fixed. This sounds like
>> some kind of software configuration option, or a way to allow different
>> drivers to handle different aspects of the HW? In general, the binding
>> shouldn't be influenced by software structure. Please delete this
>> property.
>>
>> Now, if you're attempting to set up a binding where each function
>> (semaphores, shared mailboxes, doorbells, etc.) has a different DT node,
>> then (a) splitting up HW modules into sub-blocks has usually turned out
>> to be a mistake in the past, and (b) the differences should likely be
>> represented by using a different compatible property for each
>> sub-component, rather than via a custom property.
>
> Currently the usage of HSP HW in the downstream kernel is something like
> the model below.
>
> remote_processor_A-\
> remote_processor_B--->hsp at 1000 (doorbell func) <-> host CPU
> remote_processor_C-/
>
> remote_processor_D -> hsp at 2000 (shared mailbox) <-> CPU
>
> remote_processor_E -> hsp at 3000 (shared mailbox) <-> CPU
>
> I am thinking if we can just add the appropriate compatible strings for
> it to replace "nvidia,tegra186-hsp". e.g. "nvidia,tegra186-hsp-doorbell"
> and "nvidia,tegra186-hsp-sharedmailbox". So the driver can probe and
> initialize correctly depend on the compatible property. How do you think
> about it? Is this the same as the (b) you mentioned above?

Yes, that would be (b) above.

However, please do note (a): I expect that splitting things up will turn 
out to be a mistake, as it has for other HW modules in the past. I would 
far rather see a single hsp node in DT, since there is a single HSP 
block in HW. Sure that block has multiple sub-functions. However, there 
is common logic that affects all of those sub-functions and binds 
everything into a single HW module. If you represent the HW module using 
multiple different DT nodes, it will be hard to correctly represent that 
common logic. Conversely, I see no real advantage to splitting up the DT 
node. I strongly believe we should have a single "hsp" node in DT.

Internally, the SW driver for that node can be structured however you 
want; it could register with multiple subsystems (mailbox, ...) with 
just one struct device, or the HSP driver could be an MFD device with 
sub-drivers for each separate piece of functionality the HW implements. 
All this can easily be done even while using a single DT node. And 
furthermore, we can add this SW structure later if/when we actually need 
it; in other words, there's no need to change your current patches right 
now, except to remove the nvidia,hsp-function DT property.
