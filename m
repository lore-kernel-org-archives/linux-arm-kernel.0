From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Sat, 5 Sep 2015 00:46:37 +0300
Subject: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
In-Reply-To: <Pine.LNX.4.44L0.1509041443360.29995-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1509041443360.29995-100000@iolanthe.rowland.org>
Message-ID: <55EA113D.9000806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2015 09:45 PM, Alan Stern wrote:
> On Fri, 4 Sep 2015, Grygorii Strashko wrote:
> 
>> There is one "small" problem with such approach :(
>>
>> - It's incompatible with -RT kernel, because PM runtime can't be used
>> in atomic context on -RT.
> 
> Can you explain this more fully?  Why can't runtime PM be used in
> atomic context in the -rt kernels?
>  

See:
 http://lwn.net/Articles/146861/
 https://rt.wiki.kernel.org/index.php/Frequently_Asked_Questions#How_does_the_CONFIG_PREEMPT_RT_patch_work.3F

spinlock_t
    Critical sections are preemptible. The _irq operations (e.g., spin_lock_irqsave())
 do -not- disable hardware interrupts. Priority inheritance is used to prevent priority
 inversion. An underlying rt_mutex is used to implement spinlock_t in PREEMPT_RT. 

As result, have to do things like:
https://lkml.org/lkml/2015/8/18/161
https://lkml.org/lkml/2015/8/18/162

Sorry for brief reply - Friday/Sat night :)

-- 
regards,
-grygorii
