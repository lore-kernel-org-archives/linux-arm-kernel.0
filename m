From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 27 Nov 2014 10:43:23 +0000
Subject: [PATCH] arm: cacheflush: get rid of restarting block
In-Reply-To: <20141127100306.GA20649@arm.com>
References: <1416928737-29723-1-git-send-email-vladimir.murzin@arm.com>
 <005b01d009f6$f3c6a0f0$db53e2d0$@min@lge.com>
 <20141127100306.GA20649@arm.com>
Message-ID: <5477004B.5000100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/14 10:03, Will Deacon wrote:
> On Thu, Nov 27, 2014 at 04:02:24AM +0000, Chanho Min wrote:
>>> -----Original Message-----
>>> From: Vladimir Murzin [mailto:vladimir.murzin at arm.com]
>>> Sent: Wednesday, November 26, 2014 12:19 AM
>>> To: linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk
>>> Cc: chanho.min at lge.com; will.deacon at arm.com; stable at vger.kernel.org
>>> Subject: [PATCH] arm: cacheflush: get rid of restarting block
>>>
>>> We cannot restart cacheflush safely if a process provides user-defined
>>> signal handler and signal is pending. In this case -EINTR is returned
>>> and it is expected that process re-invokes syscall. However, there are
>>> a few problems with that:
>>>  * looks like nobody bothers checking return value from cacheflush
>>>  * but if it did, we don't provide the restart address for that, so the
>>>    process has to use the same range again
>>>  * ...and again, what might lead to looping forever
>>>
>>> So, remove cacheflush restarting code and terminate cache flushing
>>> as early as fatal signal is pending.
>>>
>>> Cc: stable at vger.kernel.org # 3.12+
>>> Reported-by: Chanho Min <chanho.min@lge.com>
>>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>> ---
>>> Hi,
>>>
>>> There is my proposal for the problem reported in [1]. Since that
>>> thread has not been progressing much, I'm addressing the problem in
>>> separate patch.
>>>
>>> Comments?
>> Thanks, We hope this to be applied.
>
> Ok, good. In which case, can you put it into the patch system please,
> Vladimir?

Already in patch system as 8226/1.

Vladimir

>
> Will
>
>
>


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
