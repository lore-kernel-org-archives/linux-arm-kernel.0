From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 15 May 2012 13:09:00 -0700
Subject: [PATCH] clk: Fix race conditions between clk_set_parent() and
 clk_enable()
In-Reply-To: <20120515200040.GP30400@pengutronix.de>
References: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
 <20120515194245.GO30400@pengutronix.de> <4FB2B3AA.3010903@codeaurora.org>
 <20120515200040.GP30400@pengutronix.de>
Message-ID: <4FB2B7DC.4070706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2012 01:00 PM, Sascha Hauer wrote:
> On Tue, May 15, 2012 at 12:51:06PM -0700, Saravana Kannan wrote:
>>>>   	ret = clk->ops->set_parent(clk->hw, i);
>>>
>>> You call ->set_parent while holding a spinlock. This won't work with i2c
>>> clocks.
>>
>> I did account for that. I explained it in the commit text. Please
>> let me know if any part of that is not clear or is not correct.
>>
>
> I missed this part in the commit log. I have no idea whether we can live
> with this limitation though.
>
> Sascha
>

It's not really an artificial limitation of the patch. This has to be 
enforced if the clock is to be managed correctly while allowing 
.set_parent to NOT be atomic.

There is no way to guarantee that the enable/disable is properly 
propagated to the parent clock if we can't guarantee mutual exclusion 
between changing parents and calling enable/disable.

Since we can't do mutual exclusion be using spinlock (since .set_parent 
is NOT atomic for these clocks), then only other way of ensuring mutual 
exclusion is to force an unprepare and then mutually exclude a prepare 
while changing the parent. This by association (can't enable unprepared 
clock) mutually excludes the changing of parent and calling enable/disable.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
