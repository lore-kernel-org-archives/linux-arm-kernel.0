From: robherring2@gmail.com (Rob Herring)
Date: Mon, 30 Jan 2012 10:33:04 -0600
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <20120130150132.GJ28397@ponder.secretlab.ca>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <1327091591-27125-12-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1201201608400.19587@xanadu.home>
 <4F19DB35.9060707@gmail.com>
 <alpine.LFD.2.02.1201201744130.19587@xanadu.home>
 <4F205694.7090906@gmail.com> <20120130150132.GJ28397@ponder.secretlab.ca>
Message-ID: <4F26C640.8050705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2012 09:01 AM, Grant Likely wrote:
> On Wed, Jan 25, 2012 at 01:23:00PM -0600, Rob Herring wrote:
>> On 01/20/2012 04:48 PM, Nicolas Pitre wrote:
>>> On Fri, 20 Jan 2012, Rob Herring wrote:
>>>
>>>> On 01/20/2012 03:11 PM, Nicolas Pitre wrote:
>>>>> On Fri, 20 Jan 2012, Rob Herring wrote:
>>>>>
>>>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>>>
>>>>>> Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
>>>>>> removed by converting platforms over to sparse irq.
>>>>>>
>>>>>> This intentionally breaks platforms that enable SPARSE_IRQ.
>>>>>
>>>>> I don't get what you mean here.  The above seems contradictory.
>>>>>
>>>>
>>>> You're right. The intro explains things more clearly.
>>>
>>> The intro won't be part of the git history, so please make sure 
>>> individual commit logs are sensible on their own.
>>
>> Updated the commit message to this (w/o the email word wrapping):
>>
>> ARM: only include mach/irqs.h for !SPARSE_IRQ
>>
>> Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
>> removed by converting platforms over to sparse irq.
>>
>> This may break platforms where SPARSE_IRQ is user selectable and is enabled.
>> This is on purpose so that SPARSE_IRQ gets properly supported. SPARSE_IRQ
>> should not really be a user visible option.
>>
>> Platforms either need to set nr_irqs in their machine desc or all irqchips
>> used by a platform need to allocate their irq_descs. There cannot be a
>> mixture. Once this is done, the platforms can select SPARSE_IRQ. shmobile
>> does the latter, and mmp and pxa do the former.
>>
>>>> This breaks platforms (at boot time) that don't select SPARSE_IRQ, but 
>>>> let users enable it in their config. I don't understand why sparse irq 
>>>> is a user visible config option. We could move HAVE_SPARSE_IRQ down to 
>>>> each platform that selects SPARSE_IRQ and prevent enabling, but I 
>>>> think allowing it to break is good encouragement for others to fix 
>>>> those platforms. I'm open to other ideas.
>>>
>>> SPARSE_IRQ shouldn't be a user configurable option.  There is just no 
>>> point for a user configuring a kernel to be able to change this.
>>
>> I agree, but I'm inclined to leave this alone for now. PPC doesn't ever
>> select SPARSE_IRQ, but enables it via many defconfigs. So I think
>> changing it may cause some problems.
> 
> I think ppc can probably be moved to always enable SPARSE_IRQ since every
> ppc machine goes through irq_domain anyway.

May be so, but only ~80 of ~100 ppc defconfigs enable SPARSE_IRQ. I'll
leave it to someone more familiar with ppc to change it.

I implemented Russell's suggestion:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/081920.html

Rob
