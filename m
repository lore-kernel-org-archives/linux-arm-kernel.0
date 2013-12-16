From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 16 Dec 2013 15:55:54 -0500
Subject: [PATCH 1/3] clocksource: timer-keystone: introduce clocksource
 driver for Keystone
In-Reply-To: <20131216204037.GS21983@codeaurora.org>
References: <1386784830-15863-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386784830-15863-2-git-send-email-ivan.khoronzhuk@ti.com>
 <52AA65EA.20902@codeaurora.org> <52AEF560.9010603@ti.com>
 <20131216204037.GS21983@codeaurora.org>
Message-ID: <52AF68DA.9000104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 December 2013 03:40 PM, Stephen Boyd wrote:
> On 12/16, ivan.khoronzhuk wrote:
>> On 12/13/2013 03:42 AM, Stephen Boyd wrote:
>>> On 12/11/13 10:00, Ivan Khoronzhuk wrote:
>>>> +
>>>> +static inline u32 keystone_timer_readl(unsigned long rg)
>>>> +{
>>>> +	return readl(timer.base + rg);
>>>> +}
>>>> +
>>>> +static inline void keystone_timer_writel(u32 val, unsigned long rg)
>>>> +{
>>>> +	writel(val, timer.base + rg);
>>>> +}
>>>
>>> It's probably better to use the relaxed variants here to avoid any
>>> memory barriers that aren't necessary.
>>>
>>
>> Yes, but the code has places where I cannot use relaxed variants.
>>
>> From timer user guide:
>> "Writes from the configuration bus to the timer registers are not allowed
>> when the timer is active, except for stopping or resetting the timers.
>> Registers that are protected by hardware include CNTLO, CNTHI, PRDLO,
>> PRDHI, TGCR (except the TIMLORS and TIMHIRS bits), and TCR (except the
>> ENAMODE bits)."
>>
>> According to this I have to add keystone readl/write relaxed functions
>> and use mixed calls of writel/writel_relaxed functions.
>>
>> For instance, for keystone_timer_config() which is used by
>> keystone_set_next_event(), I will do following:
>> -----
>> tcr = keystone_timer_readl_relaxed(TCR);
>>
>> /* disable timer */
>> tcr &= ~(TCR_ENAMODE_MASK);
>> keystone_timer_writel_relaxed(tcr, TCR);
>> ...
>> /* reset counter to zero, set new period */
>> *** here I have to be sure the timer is disabled ***
>> keystone_timer_writel(0, TIM12);
>> keystone_timer_writel_relaxed(0, TIM34);
>> keystone_timer_writel_relaxed(period & 0xffffffff, PRD12);
>> keystone_timer_writel_relaxed(period >> 32, PRD34);
>>
>> /* enable timer */
>> *** here I have to be sure that TIM and PRD registers are written ***
>> keystone_timer_writel(tcr, TCR);
>> ---
>>
>> The same for keystone_timer_init().
>>
>> Will it be better?
> 
> Why not just put the explicit memory barriers where you need them
> and always use the relaxed variants in the mmio wrappers? That
> way you're always sure the memory barriers are there and that
> they're properly documented.
> 
I agree with Stephen.

Regards,
Santosh
