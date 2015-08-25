From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Aug 2015 14:59:43 +0100
Subject: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module power
 gate
In-Reply-To: <CY1PR0301MB0843D5CB5FFC56991B90EB4283610@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1438272681-29338-1-git-send-email-shenwei.wang@freescale.com>
 <55DC677E.1030004@arm.com>
 <CY1PR0301MB0843D5CB5FFC56991B90EB4283610@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <55DC74CF.7070300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/08/15 14:47, Shenwei Wang wrote:
>
>
>> -----Original Message-----
>> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
>> Sent: 2015?8?25? 8:03
>> To: Wang Shenwei-B38339
>> Cc: gregkh at linuxfoundation.org; arnd at arndb.de; Sudeep Holla; Huang
>> Yongcai-B20788; linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH v3 1/1] misc: sram: add dev_pm_ops to support module
>> power gate
>>
>>
>>
>> On 30/07/15 17:11, Shenwei Wang wrote:
>>> When system goes into low power states like SUSPEND_MEM and
>>> HIBERNATION, the hardware IP block may be powered off to reduce the
>>> power consumption. This power down will lost all the data inside the
>>> ram. This patch added the dev_pm_ops and implemented two callbacks:
>>> suspend_noirq and resume_noirq, which will save the data in the
>>> on-chip-ram right before power down and restore it after system
>>> resumes.
>>>
>>
>> Who uses this SRAM ? Can't they be released before suspending ?
>> This might not be feasible and time consuming as the size of SRAM increases.
>
> On Freescale i.MX7D, we are using this kind of SRAM. As I implemented this as an
> optional feature, a user can balance between the suspend/resume time and the power
> consumption.
>
>> Also I just check the entire tree for the users of gen_pool, I found it's used for
>> video/audio and crypto which needs to on-demand basis.
>> Apart from that it's mainly used for low power modes in which case, SRAM needs
>> to be powered on. So can you provide more details on your use-case.
>
> On latest Freescale i.MX7D, it has two SRAMs in side. One is for low
> power mode which will be powered on in suspend state. The other one
> is for other peripherals which can be powered off on demand.
>

What I meant is who will be using the SRAM when entering S2R that you
need to save the content. Either the user needs to take care of the
content or just release the pool when not in use. When the sram pool has
no user, clock can be gated.

Again can you give details of this use-case.

Regards,
Sudeep
