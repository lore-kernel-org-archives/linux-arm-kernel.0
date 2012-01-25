From: robherring2@gmail.com (Rob Herring)
Date: Wed, 25 Jan 2012 13:23:00 -0600
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <alpine.LFD.2.02.1201201744130.19587@xanadu.home>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <1327091591-27125-12-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1201201608400.19587@xanadu.home>
 <4F19DB35.9060707@gmail.com>
 <alpine.LFD.2.02.1201201744130.19587@xanadu.home>
Message-ID: <4F205694.7090906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2012 04:48 PM, Nicolas Pitre wrote:
> On Fri, 20 Jan 2012, Rob Herring wrote:
> 
>> On 01/20/2012 03:11 PM, Nicolas Pitre wrote:
>>> On Fri, 20 Jan 2012, Rob Herring wrote:
>>>
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
>>>> removed by converting platforms over to sparse irq.
>>>>
>>>> This intentionally breaks platforms that enable SPARSE_IRQ.
>>>
>>> I don't get what you mean here.  The above seems contradictory.
>>>
>>
>> You're right. The intro explains things more clearly.
> 
> The intro won't be part of the git history, so please make sure 
> individual commit logs are sensible on their own.

Updated the commit message to this (w/o the email word wrapping):

ARM: only include mach/irqs.h for !SPARSE_IRQ

Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
removed by converting platforms over to sparse irq.

This may break platforms where SPARSE_IRQ is user selectable and is enabled.
This is on purpose so that SPARSE_IRQ gets properly supported. SPARSE_IRQ
should not really be a user visible option.

Platforms either need to set nr_irqs in their machine desc or all irqchips
used by a platform need to allocate their irq_descs. There cannot be a
mixture. Once this is done, the platforms can select SPARSE_IRQ. shmobile
does the latter, and mmp and pxa do the former.

>> This breaks platforms (at boot time) that don't select SPARSE_IRQ, but 
>> let users enable it in their config. I don't understand why sparse irq 
>> is a user visible config option. We could move HAVE_SPARSE_IRQ down to 
>> each platform that selects SPARSE_IRQ and prevent enabling, but I 
>> think allowing it to break is good encouragement for others to fix 
>> those platforms. I'm open to other ideas.
> 
> SPARSE_IRQ shouldn't be a user configurable option.  There is just no 
> point for a user configuring a kernel to be able to change this.

I agree, but I'm inclined to leave this alone for now. PPC doesn't ever
select SPARSE_IRQ, but enables it via many defconfigs. So I think
changing it may cause some problems.

Any other comments on this series? I guess all the maintainers copied
are happy with it as there have been no other comments. I like to get
this into next now and send pull request to Russell or arm-soc.

Rob
