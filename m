From: shweta.gulati@ti.com (Gulati, Shweta)
Date: Thu, 21 Apr 2011 19:02:43 +0530
Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
In-Reply-To: <alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
Message-ID: <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 21, 2011 at 1:25 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Wed, 20 Apr 2011, Shweta Gulati wrote:
>
>> From: Gulati, Shweta <shweta.gulati@ti.com>
>>
>> Core Clk Tree shows incorrect Clk rates at OPP50, as
>> in commit e07f469d284ca3d1f5dcf5438c22982be98bc071
>> calling of 'recalc' in API clk_set_rate is unintentionally
>> removed,
>
> That's intentional. ?struct clk.set_rate functions need to set the struct
> clk.rate before returning. ?If they don't do that, it's a bug in the
> struct clk's .set_rate function.
Yes, but in current code clk_set_rate of dpll3_m2 -
'omap3_core_dpll_m2_set_rate'
doesn't update clk.rate, I will submit patch fixing that bug and will
make sure that
set_rate of all clocks should update clk.rate
>
>> because of which clock's tree rates get goofed up when DVFS happens.
>
> Clearly this isn't on the mainline kernel...
If you check for OPP50, the core clocks would show wrong rates.

Thanks for reviewing.
>
>> This Patch adds recalc API back.
>>
>> Tested on OMAP3630 SDP Board.
>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Paul Wamsley <paul@pwsan.com>
>> ---
>> ?arch/arm/plat-omap/clock.c | ? ?5 ++++-
>> ?1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
>> index c9122dd..5a0d06b 100644
>> --- a/arch/arm/plat-omap/clock.c
>> +++ b/arch/arm/plat-omap/clock.c
>> @@ -130,8 +130,11 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>>
>> ? ? ? spin_lock_irqsave(&clockfw_lock, flags);
>> ? ? ? ret = arch_clock->clk_set_rate(clk, rate);
>> - ? ? if (ret == 0)
>> + ? ? if (ret == 0) {
>> + ? ? ? ? ? ? if (clk->recalc)
>> + ? ? ? ? ? ? ? ? ? ? clk->rate = clk->recalc(clk);
>> ? ? ? ? ? ? ? propagate_rate(clk);
>> + ? ? }
>> ? ? ? spin_unlock_irqrestore(&clockfw_lock, flags);
>>
>> ? ? ? return ret;
>> --
>> 1.7.0.4
>>
>
>
> - Paul
>



-- 
Thanks,
Regards,
Shweta
