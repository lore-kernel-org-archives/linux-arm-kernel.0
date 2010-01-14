From: linux@bohmer.net (Remy Bohmer)
Date: Thu, 14 Jan 2010 20:31:30 +0100
Subject: [PATCH] Fix soft lockup in at91 udc driver
In-Reply-To: <4B4E55C9.6090703@bluewatersys.com>
References: <4990882D.3050302@bluewatersys.com>
	<4999C24F.9050906@bluewatersys.com>
	<3efb10971001131500i1ee520d1l983a04787c0a4c6c@mail.gmail.com>
	<4B4E55C9.6090703@bluewatersys.com>
Message-ID: <3efb10971001141131r79e7b2cfk254c364d61753cae@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

2010/1/14 Ryan Mallon <ryan@bluewatersys.com>:
> Remy Bohmer wrote:
>> Hi Ryan,
>>
>> 2009/2/16 Ryan Mallon <ryan@bluewatersys.com>:
>>> Ryan Mallon wrote:
>>>> The udc registers are only writeable if the udc clocks are enabled, but
>>>> udc interrupts can still occur. This can lead to a situation where an
>>>> interrupt is perpetually received when the clocks are disabled and is
>>>> never cleared or masked, which causes a lockup. The following patch
>>>> ensures that the clocks are enabled while handling an interrupt:
>>> Any comments on this patch? Has anybody else had problems with the AT91
>>> UDC driver causing soft lockups?
>>
>> Although this patch is now almost a year old, we first encountered
>> this type of bug just a few weeks ago.
>> The problem description you mention fits the problem we see. We also
>> noticed that the clocks were disabled in the case our lockup occurs.
>
> Awesome, thanks. The patch certainly fixed the problem on our board
> (from memory I originally wrote this for our 2.6.20 kernel), but the
> patch does seem valid even if the occurrence of the problem is rare. I
> never bothered following up on it, because nobody else was reporting
> problems.
>
> If you could test and give me a Tested-by or Acked-by, then I'll rebase
> and repost the patch.

Well, this patch works and solves the problem we have seen for now.
So, that is the good news.
Looking deeper into this patch we have some doubts if this is the best
way to solve the problem, since it could be racy if interrupt handlers
run in thread context as on preempt-rt. The code is fluttered with
local_irq_disable/enable and the peripheral clock is sometimes
enabled/disabled without any locking. So that should be replaced by a
more decent locking mechanism. I will look into this soon.

But anyway, it applies without any problem to 2.6.31 since the code
has not been changed for ages...

Thus, for mainline only I do not see a functional problem with this
patch, for preempt-rt the driver code in general might need some
improvements.
So, if you want to push it further upstream:
Tested-by: Remy Bohmer <linux@bohmer.net>

Kind regards,

Remy
