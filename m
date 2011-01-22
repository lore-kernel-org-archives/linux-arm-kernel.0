From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 21 Jan 2011 17:35:42 -0800
Subject: Locking in the clk API
In-Reply-To: <AANLkTimT+vfg9p4GSnn1jGW9r_gVom7xEUzMVJDscPg2@mail.gmail.com>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111031552.GJ3760@linux-sh.org>
	<4D3862DB.5000708@fluff.org>	<20110120185617.GI6335@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>	<AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>	<4D3907BD.4040900@codeaurora.org>	<AANLkTik53zyXytvuAd5zK0_zExfQT3FmOgTr8BexmGeT@mail.gmail.com>	<alpine.LFD.2.00.1101211618170.8580@xanadu.home>	<20110121220238.GE23151@n2100.arm.linux.org.uk>
	<AANLkTimT+vfg9p4GSnn1jGW9r_gVom7xEUzMVJDscPg2@mail.gmail.com>
Message-ID: <4D3A346E.9070709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2011 02:28 PM, Colin Cross wrote:
> On Fri, Jan 21, 2011 at 2:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> On Fri, Jan 21, 2011 at 04:53:44PM -0500, Nicolas Pitre wrote:
>>> So I think that the API must be augmented with more methods, such as:
>>>
>>> clk_slow_enable():
>>>    - may sleep
>>>    - may be a no-op if the clk_fast_enable() is supported
>>>
>>> clk_fast_enable():
>>>    - may not sleep, used in atomic context
>>>    - may be a no-op if controlling the clock takes time, in which case
>>>      clk_slow_enable() must have set the clock up entirely
>>>
>>> ... and similar for clk_slow_disable() and clk_fast_disable().
>>
>> Isn't this along the same lines as my clk_prepare() vs clk_enable()
>> suggestion?
>>
>> I suggested that clk_prepare() be callable only from non-atomic contexts,
>> and do whatever's required to ensure that the clock is available.  That
>> may end up enabling the clock as a result.
>>
>> clk_enable() callable from atomic contexts, and turns the clock on if
>> the hardware supports such an operation.
>>
>> So, if you have something like:
>>
>> Xtal--->PLL--->Routing/Masking--->Device
>>
>> clk = clk_get() returns the clock for the device.
>>
>> clk_prepare(clk) would walk up the clock tree, selecting the routing and
>> preparing each clock.  Clocks prior to _and_ including the PLL would need
>> to be enabled.
>>
>> clk_enable(clk) would walk up the tree if the clock isn't already enabled,
>> calling clk_enable() on the parent clock.  As we require prepared clocks
>> to already be enabled, this automatically stops at the PLL.
>>
>> To encourage correct usage, we just need to make sure that clk_prepare()
>> has a might_sleep() thing, and clk_enable() throws a fit if it's used
>> on a clk without prepare being used first.  The second point is not easy
>> to do in a foolproof manner though, but doing _something_ is better than
>> nothing.
>
> I like this proposal, and I prefer the clk_prepare naming over
> clk_slow_enable - too many people would call clk_slow_enable instead
> of, and not as well as, clk_fast_enable.
>
> On Tegra, I currently use the ugly conditional mutex or spinlock
> method to deal with voltage scaling based on clock frequency.

Colin,

MSM is in a similar situation, so thought I should bring this up to you 
attention -- do you have no use case for changing the rate in atomic 
context? If you do, the clk_prepare/unprepare() approach won't work.

Do you have no such requirement?

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
