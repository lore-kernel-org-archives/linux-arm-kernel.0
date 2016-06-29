From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 29 Jun 2016 13:56:33 +0800
Subject: [PATCH 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <5772CB12.5080408@wwwdotorg.org>
References: <20160627090248.23621-1-josephl@nvidia.com>
 <20160627090248.23621-2-josephl@nvidia.com> <57714C85.50802@wwwdotorg.org>
 <57724039.7080007@nvidia.com> <5772CB12.5080408@wwwdotorg.org>
Message-ID: <57736311.6020304@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2016 03:08 AM, Stephen Warren wrote:
> On 06/28/2016 03:15 AM, Joseph Lo wrote:
>> On 06/27/2016 11:55 PM, Stephen Warren wrote:
>>> On 06/27/2016 03:02 AM, Joseph Lo wrote:
snip.
>>
>> Currently the usage of HSP HW in the downstream kernel is something like
>> the model below.
>>
>> remote_processor_A-\
>> remote_processor_B--->hsp at 1000 (doorbell func) <-> host CPU
>> remote_processor_C-/
>>
>> remote_processor_D -> hsp at 2000 (shared mailbox) <-> CPU
>>
>> remote_processor_E -> hsp at 3000 (shared mailbox) <-> CPU
>>
>> I am thinking if we can just add the appropriate compatible strings for
>> it to replace "nvidia,tegra186-hsp". e.g. "nvidia,tegra186-hsp-doorbell"
>> and "nvidia,tegra186-hsp-sharedmailbox". So the driver can probe and
>> initialize correctly depend on the compatible property. How do you think
>> about it? Is this the same as the (b) you mentioned above?
>
> Yes, that would be (b) above.
>
> However, please do note (a): I expect that splitting things up will turn
> out to be a mistake, as it has for other HW modules in the past. I would
> far rather see a single hsp node in DT, since there is a single HSP
> block in HW. Sure that block has multiple sub-functions. However, there
> is common logic that affects all of those sub-functions and binds
> everything into a single HW module. If you represent the HW module using
> multiple different DT nodes, it will be hard to correctly represent that
> common logic. Conversely, I see no real advantage to splitting up the DT
> node. I strongly believe we should have a single "hsp" node in DT.

We have 6 HSP block in HW. FYI.

>
> Internally, the SW driver for that node can be structured however you
> want; it could register with multiple subsystems (mailbox, ...) with
> just one struct device, or the HSP driver could be an MFD device with
> sub-drivers for each separate piece of functionality the HW implements.
> All this can easily be done even while using a single DT node. And
> furthermore, we can add this SW structure later if/when we actually need
> it; in other words, there's no need to change your current patches right
> now, except to remove the nvidia,hsp-function DT property.

Thanks,
-Joseph
