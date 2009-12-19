From: dirk.behme@googlemail.com (Dirk Behme)
Date: Sat, 19 Dec 2009 09:20:44 +0100
Subject: [PATCH] ARM: Fix a race in the vfp_notifier() function
	on	SMPsystems
In-Reply-To: <20091218145345.GD32481@n2100.arm.linux.org.uk>
References: <20091218134423.21279.93962.stgit@pc1117.cambridge.arm.com>	<20091218141100.GA32481@n2100.arm.linux.org.uk>	<20091218142503.GB32481@n2100.arm.linux.org.uk>	<20091218144728.GC32481@n2100.arm.linux.org.uk>	<1261147901.13520.73.camel@pc1117.cambridge.arm.com>
	<20091218145345.GD32481@n2100.arm.linux.org.uk>
Message-ID: <4B2C8CDC.3070507@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.12.2009 15:53, Russell King - ARM Linux wrote:
> On Fri, Dec 18, 2009 at 02:51:41PM +0000, Catalin Marinas wrote:
>> On Fri, 2009-12-18 at 14:47 +0000, Russell King - ARM Linux wrote:
>>> Actually, I think we should go further and kill off THREAD_NOTIFY_RELEASE
>>> completely.  Added a few more people because EP93xx and PXA (well,
>>> Xscale) is now impacted by this change.
>>>
>>> [PATCH] ARM: Convert VFP/Crunch/XscaleCP thread_release() to exit_thread()
>>>
>>> This avoids races in the VFP code where the dead thread may have
>>> state on another CPU.  By moving this code to exit_thread(), we
>>> will be running as the thread, and therefore be running on the
>>> current CPU.
>>>
>>> This means that we can ensure that the only local state is accessed
>>> in the thread notifiers.
>>>
>>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
>> [...]
>>>   static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
>>>   {
>>> @@ -132,8 +135,8 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
>>>
>>>          if (cmd == THREAD_NOTIFY_FLUSH)
>>>                  vfp_thread_flush(thread);
>>> -       else
>>> -               vfp_thread_release(thread);
>>> +       else if (cmd == THREAD_NOTIFY_EXIT)
>>> +               vfp_thread_exit(thread);
>>
>> Do we still need the second "if" or "else" will do (though it's safer if
>> anyone adds some extra THREAD_NOTIFY_* in the future.
>
> The previous patch iteration did need it, but this done doesn't.  Killed.

Sorry if I missed something, but any hint where to find the latest 
version of the patch for testing?

Many thanks and best regards

Dirk
