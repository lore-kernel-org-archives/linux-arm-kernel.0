From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 10 Apr 2017 10:15:18 +0530
Subject: [PATCH V3 0/5] iommu/arm-smmu: Add runtime pm/sleep support
In-Reply-To: <20170407180105.GA22050@jcrouse-lnx.qualcomm.com>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
 <20170331175457.GD4897@arm.com>
 <CAF6AEGv_1pNvhCc-mVP5S28Yt5kTJmTRfe8tKSJpEmxfOKM7Jg@mail.gmail.com>
 <20170403172307.GI5706@arm.com> <20170404193914.GF18246@codeaurora.org>
 <20170407180105.GA22050@jcrouse-lnx.qualcomm.com>
Message-ID: <1ceef21f-240a-013d-4bcf-0b4ea5a24bf6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jordon,

On 4/7/2017 11:31 PM, Jordan Crouse wrote:
> On Tue, Apr 04, 2017 at 12:39:14PM -0700, Stephen Boyd wrote:
>> On 04/03, Will Deacon wrote:
>>> On Fri, Mar 31, 2017 at 10:58:16PM -0400, Rob Clark wrote:
>>>> On Fri, Mar 31, 2017 at 1:54 PM, Will Deacon <will.deacon@arm.com> wrote:
>>>>> On Thu, Mar 09, 2017 at 09:05:43PM +0530, Sricharan R wrote:
>>>>>> This series provides the support for turning on the arm-smmu's
>>>>>> clocks/power domains using runtime pm. This is done using the
>>>>>> recently introduced device links patches, which lets the symmu's
>>>>>> runtime to follow the master's runtime pm, so the smmu remains
>>>>>> powered only when the masters use it.
>>>>>
>>>>> Do you have any numbers for the power savings you achieve with this?
>>>>> How often do we actually manage to stop the SMMU clocks on an SoC with
>>>>> a handful of masters?
>>>>>
>>>>> In other words, is this too coarse-grained to be useful, or is it common
>>>>> that all the devices upstream of the SMMU are suspended?
>>>>
>>>> well, if you think about a phone/tablet with a command mode panel,
>>>> pretty much all devices will be suspended most of the time ;-)
>>>
>>> Well, that's really what I was asking about. I assumed that periodic
>>> modem/radio transactions would keep the SMMU clocked, so would like to get a
>>> rough idea of the power savings achieved with this coarse-grained approach.
>>
>> Sometimes we distribute SMMUs to each IP block in the system and
>> let each one of those live in their own clock + power domain. In
>> these cases, the SMMU can be powered down along with the only IP
>> block that uses it. Furthermore, sometimes we put the IP block
>> and the SMMU inside the same power domain to really tie the two
>> together, so we definitely have cases where all devices (device?)
>> upstream of the SMMU are suspended. And in the case of
>> multimedia, it could be very often that something like the camera
>> app isn't open and thus the SMMU dedicated for the camera can be
>> powered down.
>>
>> Other times we have two SMMUs in the system where one is
>> dedicated to GPU and the other is "everything else". Even in
>> these cases, we can suspend the GPU one when the GPU is inactive
>> because it's the only consumer. The other SMMU might not be as
>> fine grained, but I think we still power it down quite often
>> because the consumers are mostly multimedia devices that aren't
>> active when the display is off.
>
> And just to confuse things even further: with per-instance pagetables we have an
> interest in forcing the SMMU clocks *on* because we don't know when the GPU
> might try to hit the registers to switch a pagetable and if somebody in the
> pipeline is actively trying to do power management at the same time hilarity
> will ensue.
>

Ok, with per-process pagetables which gpu handles by itself, is the gpu driver
not going to keep its own clocks pm_runtime active before handing it over
to the firmware ? which would in this case take care of having the iommu clocks
also enabled because of the device links in the behind.

> The alternative to pm_runtime is the downstream driver that probes the SMMU
> clocks from DT and frobs them itself. I think we can agree that is far less
> reasonable.

The idea here was to keep the iommu clocks only represented inside the IOMMU DT
and handled by that driver. This works fine with the video decoder which is
already fully pm_runtime enabled and works fine with basic gpu testing. Do you
see any issues in testing this with the per-process pagetables ?

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
