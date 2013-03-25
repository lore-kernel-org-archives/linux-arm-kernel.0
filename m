From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Mon, 25 Mar 2013 16:44:11 +0530
Subject: [PATCH] clk: tegra: Don't enable PLLs during early boot
In-Reply-To: <20130325101542.GB18519@tbergstrom-lnx.Nvidia.com>
References: <1363953308-28828-1-git-send-email-pdeschrijver@nvidia.com>
 <514C7D3B.40602@wwwdotorg.org>
 <20130325101542.GB18519@tbergstrom-lnx.Nvidia.com>
Message-ID: <51503183.2010609@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013 03:45 PM, Peter De Schrijver wrote:
> On Fri, Mar 22, 2013 at 04:48:11PM +0100, Stephen Warren wrote:
>> On 03/22/2013 05:54 AM, Peter De Schrijver wrote:
>>> The PLL code relies on udelay() which is not available when CCF is
>>> initialized. Hence we can't enable any PLL during this phase.
>>>
>>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>
>>> --
>>>
>>> Stephen,
>>>
>>> Can you confirm this is ok for the audio drivers?
>>>
>>> We used to be lucky that this has worked up to now, but I will introduce some
>>> changes to the pll lock check code which cause this to fail due to the
>>> slight differences in timing.
>> No, this won't work for the audio drivers; they assume the clock is
>> enabled when they start.
>>
>> This assumption was made long ago. I know drivers are supposed to assume
>> that clocks are disabled when they're probed, but historically that
>> wasn't always the case, so if the audio drivers assumed that, and then
>> did clk_enable() as the first thing, they got a warning due to the
>> enabling an already enabled clock and/or later attempts to disable the
> That should be ok. You can enable a clock more than once.
>
>> clocks wouldn't actually disable them. Perhaps this has changed now, but
>> either way, audio driver changes would be needed to support this change.
>>
> But indeed, the clock won't be disabled then when the driver does
> clk_disable(). The reference count will just be decremented. That's however
> not a functional problem, just not optimal from a power consumption point of
> view. So we could change the drivers first and keep the clocks disabled at
> boottime in a second phase.
>
>> Perhaps this is due to initializing the Tegra clock driver in the
>> machine descriptor's init_irq function, rather than in the init_machine
>> function? Can this be moved?
> Maybe. But we need the clockframework before the timers are initialized...
> So I have to check the dependencies.

I have moved the initialization after slab allocator is initialized and 
before timer initialization.
This is later that it used to happen with our legacy framework or which 
happens in our downstream kernel.

Isn't this problem observed in downstream kernel?

May be we can split the clock initialization and move clock init from 
table to some later stage.

> Cheers,
>
> Peter.
