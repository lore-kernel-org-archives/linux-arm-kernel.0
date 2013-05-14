From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 14 May 2013 14:03:04 -0700
Subject: [PATCH] clk: Fix race condition between clk_set_parent and
 clk_enable()
In-Reply-To: <20130514185417.10068.5717@quantum>
References: <1367383328-25700-1-git-send-email-skannan@codeaurora.org>
 <20130514185417.10068.5717@quantum>
Message-ID: <5192A688.3040007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2013 11:54 AM, Mike Turquette wrote:
> Quoting Saravana Kannan (2013-04-30 21:42:08)
>> Without this patch, the following race conditions are possible.
>>
>> Race condition 1:
>> * clk-A has two parents - clk-X and clk-Y.
>> * All three are disabled and clk-X is current parent.
>> * Thread A: clk_set_parent(clk-A, clk-Y).
>> * Thread A: <snip execution flow>
>> * Thread A: Grabs enable lock.
>> * Thread A: Sees enable count of clk-A is 0, so doesn't enable clk-Y.
>> * Thread A: Updates clk-A SW parent to clk-Y
>> * Thread A: Releases enable lock.
>> * Thread B: clk_enable(clk-A).
>> * Thread B: clk_enable() enables clk-Y, then enabled clk-A and returns.
>>
>> clk-A is now enabled in software, but not clocking in hardware since the
>> hardware parent is still clk-X.
>>
>> The only way to avoid race conditions between clk_set_parent() and
>> clk_enable/disable() is to ensure that clk_enable/disable() calls don't
>> require changes to hardware enable state between changes to software clock
>> topology and hardware clock topology.
>>
>> There are options to achieve the above:
>> 1. Grab the enable lock before changing software/hardware topology and
>>     release it afterwards.
>> 2. Keep the clock enabled for the duration of software/hardware topology
>>     change so that any additional enable/disable calls don't try to change
>>     the hardware state. Once the topology change is complete, the clock can
>>     be put back in its original enable state.
>>
>> Option (1) is not an acceptable solution since the set_parent() ops might
>> need to sleep.
>>
>> Therefore, this patch implements option (2).
>>
>> This patch doesn't violate any API semantics. clk_disable() doesn't
>> guarantee that the clock is actually disabled. So, no clients of a clock
>> can assume that a clock is disabled after their last call to clk_disable().
>> So, enabling the clock during a parent change is not a violation of any API
>> semantics.
>>
>> This also has the nice side effect of simplifying the error handling code.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>
> I've taken this patch into clk-next for testing.  The code itself looks
> fine.

Thanks Mike. I'll send it out again with some typo/grammar corrections.

> The only thing that remains to be seen is if any platforms have a
> problem with disabled clocks getting turned on during a reparent
> operation.

I would think that would be a general issue with the clock APIs since 
disable doesn't guarantee a disable (since it's ref counted).

Also, those clocks could be marked as CLK_SET_PARENT_GATE if it's a real 
issue.

> On platforms that I have worked on this is OK, but I suppose there could
> be some platform out there where a clock is prepared and disabled, and
> briefly enabling the clock during the reparent operation somehow puts
> the hardware in a bad state.

I can't think of any either, but as I mentioned, we have 
CLK_SET_PARENT_GATE for that.

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
