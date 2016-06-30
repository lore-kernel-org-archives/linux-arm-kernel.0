From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 30 Jun 2016 17:25:45 +0800
Subject: [PATCH 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <5773E900.8060903@wwwdotorg.org>
References: <20160627090248.23621-1-josephl@nvidia.com>
 <20160627090248.23621-2-josephl@nvidia.com> <57714C85.50802@wwwdotorg.org>
 <57724039.7080007@nvidia.com> <5772CB12.5080408@wwwdotorg.org>
 <57736311.6020304@nvidia.com> <5773E900.8060903@wwwdotorg.org>
Message-ID: <5774E599.4000204@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2016 11:28 PM, Stephen Warren wrote:
> On 06/28/2016 11:56 PM, Joseph Lo wrote:
>> On 06/29/2016 03:08 AM, Stephen Warren wrote:
>>> On 06/28/2016 03:15 AM, Joseph Lo wrote:
>>>> On 06/27/2016 11:55 PM, Stephen Warren wrote:
>>>>> On 06/27/2016 03:02 AM, Joseph Lo wrote:
>> snip.
>>>>
>>>> Currently the usage of HSP HW in the downstream kernel is something
>>>> like
>>>> the model below.
>>>>
>>>> remote_processor_A-\
>>>> remote_processor_B--->hsp at 1000 (doorbell func) <-> host CPU
>>>> remote_processor_C-/
>>>>
>>>> remote_processor_D -> hsp at 2000 (shared mailbox) <-> CPU
>>>>
>>>> remote_processor_E -> hsp at 3000 (shared mailbox) <-> CPU
>>>>
>>>> I am thinking if we can just add the appropriate compatible strings for
>>>> it to replace "nvidia,tegra186-hsp". e.g.
>>>> "nvidia,tegra186-hsp-doorbell"
>>>> and "nvidia,tegra186-hsp-sharedmailbox". So the driver can probe and
>>>> initialize correctly depend on the compatible property. How do you
>>>> think
>>>> about it? Is this the same as the (b) you mentioned above?
>>>
>>> Yes, that would be (b) above.
>>>
>>> However, please do note (a): I expect that splitting things up will turn
>>> out to be a mistake, as it has for other HW modules in the past. I would
>>> far rather see a single hsp node in DT, since there is a single HSP
>>> block in HW. Sure that block has multiple sub-functions. However, there
>>> is common logic that affects all of those sub-functions and binds
>>> everything into a single HW module. If you represent the HW module using
>>> multiple different DT nodes, it will be hard to correctly represent that
>>> common logic. Conversely, I see no real advantage to splitting up the DT
>>> node. I strongly believe we should have a single "hsp" node in DT.
>>
>> We have 6 HSP block in HW. FYI.
>
> Yes, we have 6 /instances/ of the overall HSP block. Those should each
> have their own node, since they're entirely separate modules, all
> instances of the same configurable IP block.
>
> Above, I was talking about the sub-blocks within each HSP instance,
> which should all be represented into a single node per instance, for a
> total of 6 DT nodes overall.
Yes.

So, one thing still concerns me is that the binding and driver still 
can't work with multiple HSP sub-modules per HSP block. It only supports 
one HSP module per HSP block right how. Although, I said it matches the 
model that we are using in the downstream kernel. But I still concern if 
we need to enable and work with multiple HSP modules per HSP block at 
sometime in future, then the binding and driver need lots of change to 
achieve that. And the binding is not back-ward compatible obviously.

So I want to revise it again.

#mbox-cells: should be 2.

The mobxes property in the client node should contain the phandle of the 
HSP block, HSP sub-module ID and the specifier of the module.

Ex.
hsp_top0: hsp at 1000 {
     ...
     #mbox-cells = <2>;
};

clientA {
     ....
     mboxes = <&hsp_top0 HSP_DOORBELL DB_MASTER_XXX>;
};

clientB {
     ...
     mboxes = <&hsp_top0 HSP_SHARED_MAILBOX SM_MASTER_XXX>;
};

Stephen, How do you think of this change?

Thanks,
-Joseph
