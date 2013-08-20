From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Aug 2013 13:52:47 -0600
Subject: [RFC 02/17] ARM: call clk_of_init from time_init
In-Reply-To: <5213C7E1.4070401@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <52138F56.6030008@wwwdotorg.org> <5213C7E1.4070401@gmail.com>
Message-ID: <5213C90F.9010407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 01:47 PM, Sebastian Hesselbarth wrote:
> On 08/20/2013 05:46 PM, Stephen Warren wrote:
>> On 08/19/2013 08:04 PM, Sebastian Hesselbarth wrote:
>>> Most DT ARM machs require common clock providers initialized before
>>> timers.
>>> Currently, arch/arm machs use .init_time to call clk_of_init right
>>> before
>>> clocksource_of_init. This prevents to remove that hook and use the
>>> default
>>> hook instead. clk_of_init now checks for multiple calls to it, so add
>>> the call to ARM arch time_init by default.
>>
>> Some SoCs call this function in .init_irq() rather than .init_time().
>> Perhaps we adjust this patch to do that instead. That way, we can
>> presumably get rid of patch 1/17 since we can eliminate any duplicate
>> calls, and adjust patch 14/17 (Tegra board file) to remove its custom
>> call to of_clock_init(NULL)?
> 
> Currently as of -next from yesterday, only tegra is requiring clocks
> that early, while others are fine with them close to timers. I really
> have no strong opinion on that. That decision should rather be made
> by those with a far more complete insight of the consequences than I
> have.

Perhaps if Tegra is a special-case, it shouldn't rely on the generic
init_time() callback, and hence you could still eliminate patch 1/17?
