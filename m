From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 1 Jul 2016 10:23:02 +0800
Subject: [PATCH 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <5775427B.9040907@wwwdotorg.org>
References: <20160627090248.23621-1-josephl@nvidia.com>
 <20160627090248.23621-2-josephl@nvidia.com> <57714C85.50802@wwwdotorg.org>
 <57724039.7080007@nvidia.com> <5772CB12.5080408@wwwdotorg.org>
 <57736311.6020304@nvidia.com> <5773E900.8060903@wwwdotorg.org>
 <5774E599.4000204@nvidia.com> <5775427B.9040907@wwwdotorg.org>
Message-ID: <5775D406.4080204@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2016 12:02 AM, Stephen Warren wrote:
> On 06/30/2016 03:25 AM, Joseph Lo wrote:
>> On 06/29/2016 11:28 PM, Stephen Warren wrote:
>>> On 06/28/2016 11:56 PM, Joseph Lo wrote:
>>>> On 06/29/2016 03:08 AM, Stephen Warren wrote:
>>>>> On 06/28/2016 03:15 AM, Joseph Lo wrote:
>>>>>> On 06/27/2016 11:55 PM, Stephen Warren wrote:
>>>>>>> On 06/27/2016 03:02 AM, Joseph Lo wrote:
>>>> snip.
>>>>>>
>>>>>> Currently the usage of HSP HW in the downstream kernel is something
>>>>>> like
>>>>>> the model below.
>>>>>>
>>>>>> remote_processor_A-\
>>>>>> remote_processor_B--->hsp at 1000 (doorbell func) <-> host CPU
>>>>>> remote_processor_C-/
>>>>>>
>>>>>> remote_processor_D -> hsp at 2000 (shared mailbox) <-> CPU
>>>>>>
>>>>>> remote_processor_E -> hsp at 3000 (shared mailbox) <-> CPU
>>>>>>
>>>>>> I am thinking if we can just add the appropriate compatible strings
>>>>>> for
>>>>>> it to replace "nvidia,tegra186-hsp". e.g.
>>>>>> "nvidia,tegra186-hsp-doorbell"
>>>>>> and "nvidia,tegra186-hsp-sharedmailbox". So the driver can probe and
>>>>>> initialize correctly depend on the compatible property. How do you
>>>>>> think
>>>>>> about it? Is this the same as the (b) you mentioned above?
>>>>>
>>>>> Yes, that would be (b) above.
>>>>>
>>>>> However, please do note (a): I expect that splitting things up will
>>>>> turn
>>>>> out to be a mistake, as it has for other HW modules in the past. I
>>>>> would
>>>>> far rather see a single hsp node in DT, since there is a single HSP
>>>>> block in HW. Sure that block has multiple sub-functions. However,
>>>>> there
>>>>> is common logic that affects all of those sub-functions and binds
>>>>> everything into a single HW module. If you represent the HW module
>>>>> using
>>>>> multiple different DT nodes, it will be hard to correctly represent
>>>>> that
>>>>> common logic. Conversely, I see no real advantage to splitting up
>>>>> the DT
>>>>> node. I strongly believe we should have a single "hsp" node in DT.
>>>>
>>>> We have 6 HSP block in HW. FYI.
>>>
>>> Yes, we have 6 /instances/ of the overall HSP block. Those should each
>>> have their own node, since they're entirely separate modules, all
>>> instances of the same configurable IP block.
>>>
>>> Above, I was talking about the sub-blocks within each HSP instance,
>>> which should all be represented into a single node per instance, for a
>>> total of 6 DT nodes overall.
>> Yes.
>>
>> So, one thing still concerns me is that the binding and driver still
>> can't work with multiple HSP sub-modules per HSP block. It only supports
>> one HSP module per HSP block right how.
>
> The driver can be enhanced without affecting the DT binding, providing
> the binding is reasonably designed, as I believe it is.
>
> I believe the existing binding can work fine for multiple HSP
> sub-modules, or at least be extended in a backwards-compatible way.
> Aside from the mailbox cells issue you mention below, is there any other
> reason you believe the binding can't be extended in a
> backwards-compatible way? Interrupts are already accessed solely by
> name, so we can add more later without issue. The node can become a
> provider for any other resource type besides mailboxes in a
> backwards-compatible way without issue.

Because the mbox client has no idea to know which hsb sub-module to bind 
with. However, the way you suggested below should solve my concern and 
back-ward compatible indeed.

>
>> Although, I said it matches the
>> model that we are using in the downstream kernel. But I still concern if
>> we need to enable and work with multiple HSP modules per HSP block at
>> sometime in future, then the binding and driver need lots of change to
>> achieve that. And the binding is not back-ward compatible obviously.
>>
>> So I want to revise it again.
>>
>> #mbox-cells: should be 2.
>>
>> The mobxes property in the client node should contain the phandle of the
>> HSP block, HSP sub-module ID and the specifier of the module.
>>
>> Ex.
>> hsp_top0: hsp at 1000 {
>>      ...
>>      #mbox-cells = <2>;
>> };
>>
>> clientA {
>>      ....
>>      mboxes = <&hsp_top0 HSP_DOORBELL DB_MASTER_XXX>;
>> };
>>
>> clientB {
>>      ...
>>      mboxes = <&hsp_top0 HSP_SHARED_MAILBOX SM_MASTER_XXX>;
>> };
>>
>> Stephen, How do you think of this change?
>
> Well, we could do that. Or, since we won't have 2^32 instances of
> doorbells, we could also have #mbox-cells=<1> as we do now, and encode
> mailbox IDs as "(type << 16) | id" where TEGRA186_HSP_MAILBOX_TYPE_DB is
> 0. That would be backwards-compatible with no change to the binding. I
> think either way is fine. I have a slight preference for keeping
> #mbox-cells=<1> to avoid revising the U-Boot driver code I wrote, but I
> can deal with changing it if I have to.

Ah, yes. I think the U-Boot doesn't need to deal with the multiple HSP 
sub-module supporting issue, and the binding I purposed was more 
complicate for that. The idea with "#mbox-cells=<1>" and 
"mboxes=<(type<<16)|id>" is fine with me. I will revise the hsp driver 
for this.

Thanks,
-Joseph
