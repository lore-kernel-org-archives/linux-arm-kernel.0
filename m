From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Aug 2016 12:07:36 +0100
Subject: [PATCH] generic: Add the exception case checking routine for ppi
 interrupt
In-Reply-To: <57C5617B.6080801@huawei.com>
References: <1472530639-21616-1-git-send-email-majun258@huawei.com>
 <57C548D0.3090700@arm.com> <57C5617B.6080801@huawei.com>
Message-ID: <57C568F8.20802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Mark

On 30/08/16 11:35, majun (F) wrote:
> 
> 
> ? 2016/8/30 16:50, Marc Zyngier ??:
>> On 30/08/16 05:17, MaJun wrote:
>>> From: Ma Jun <majun258@huawei.com>
>>>
>>> During system booting, if the interrupt which has no action registered
>>> is triggered, it would cause system panic when try to access the
>>> action member.
>>
>> And why would that interrupt be enabled? If you enable a PPI before
>> registering a handler, you're doing something wrong.
>>
> 
> Actually,the problem described above happened during the capture
> kernel booting.
> 
> In my system, sometimes there is a pending physical timer
> interrupt(30) when the first kernel panic and the status is kept
> until the capture kernel booting.

And that's perfectly fine. The interrupt can be pending forever, as it
shouldn't get enabled.

> So, this interrupt will be handled during capture kernel booting.

Why? Who enables it?

> 
> Becasue we use virt timer interrupt but not physical timer interrupt
> in capture kernel, the interrupt 30 has no action handler.

Again: who enables this interrupt? Whichever driver enables it should be
fixed.

> Besides, I think we need to do exception check in this function just
> like "handle_fasteoi_irq" does.

I respectfully disagree. This will only hide a whole class of silly
bugs, and I'd rather squash them instead of papering over them.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
