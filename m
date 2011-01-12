From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 11 Jan 2011 19:25:01 -0800
Subject: Locking in the clk API
In-Reply-To: <201101112235.43061.jeremy.kerr@canonical.com>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<201101111830.18597.jeremy.kerr@canonical.com>	<20110111121816.GB774@linux-sh.org>
	<201101112235.43061.jeremy.kerr@canonical.com>
Message-ID: <4D2D1F0D.5040208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2011 06:35 AM, Jeremy Kerr wrote:
> Hi Paul,
>
>> Again, you are approaching it from the angle that an atomic clock is a
>> special requirement rather than the default behaviour.
>
> I'm not considering it a special requirement, but it's still a requirement
> (that the called function does not sleep).
>
> The problem with the inverse logic (clk_enable/clk_enable_sleepable) is that
> now you've made the caller need to know what kind of clock it has, or might
> have one day.

I think it's just a matter of how you interpret the name of the API in 
English. It doesn't make the decision making of the developer any easier.

Just having a _atomic suffix doesn't mean the driver developer doesn't 
need to know what type of clock it is. They are still making the 
assumption that the enable/disable for that clock can be done atomically 
-- namely an "atomic clock".

Similarly, when a driver developer calls the _sleepable APIs in their 
code, for all practical purposes, they are making an assumption that the 
enable/disable for that clock *needs to* (not may) sleep.

>   * For clk_enable/clk_enable_atomic, the decision is: is this call in an
>     atomic context?
>
>   * For clk_enable/clk_enable_sleepable, the decision is: might the clock code
>     have given us a sleeping clock?

Having said the above, I'm slightly leaning towards 
clk_enable/disable_atomic since it lines up with the 
.suspend/.suspend_noirq functions in pm_ops.

Also, since it's good to reduce the amount of work that needs to be done 
atomically, I think it would be good to make a developer explicitly 
state they need _atomic functions and make them think about if they 
really need to do that.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
