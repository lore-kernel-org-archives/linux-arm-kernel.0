From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Wed, 28 May 2014 13:07:46 +0200
Subject: [PATCH v3 01/11] clk: composite: support determine_rate using
 rate_ops->round_rate + mux_ops->set_parent
In-Reply-To: <27477814.I92OqiDuKt@phil>
References: <1621067.VASjIdzoSl@phil> <17737873.r3cte6TEQ5@phil>
 <5383085C.1060804@free-electrons.com> <27477814.I92OqiDuKt@phil>
Message-ID: <5385C382.4080208@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 05/26/2014 12:27 PM, Heiko St?bner wrote:
> Am Montag, 26. Mai 2014, 11:24:44 schrieb Boris BREZILLON:
>> Hello Heiko,
>>
>> On 23/05/2014 21:33, Heiko St?bner wrote:
>>> From: Boris BREZILLON <b.brezillon@overkiz.com>
>>>
>>> In case the rate_hw does not implement determine_rate, but only round_rate
>>> we fallback to best_parent selection if mux_hw is present and support
>>> reparenting.
>>>
>>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>>>
>>> This also fixes a rate calculation problem when using the standard div and
>>> mux ops, as in this case currently only the mux->determine_rate is used
>>> in the composite rate calculation.
>>> [fixed the output to actually return a rate instead of the diff]
>> Sorry for the delay and thanks for fixing this.
>>
>> Anyway, when I first proposed this patch, Emilio (added in Cc) told me
>> this should not be automatically done by the composite clk driver, and
>> the driver should instead provide the determine_rate function.
> Just to point out, as I'm not sure if it comes across correctly from my
> description above, it looks like the composite behaviour is currently broken
> when using the standard mux and div ops for it.
>
> As only mux_ops provides a determine rate callback, it will always only run
> 	mux_ops->determine_rate
> thus returning the parent rate as the target rate.

YesI saw this regression for me later, i had planned to propose a correction
this patch is therefore highly welcome.
Thanks !

> So when the parents are 600 and 891 MHz and you want 75MHz [which the divider
> can provide], the clock would always be set to 600MHz, which may be way out of
> spec - as seen on my rk3188 clock tree.
>
>
> When looking at the other composite users, only st/clkgen-mux.c uses the same
> pattern with both the standard mux and div operations. I've added Gabriel,
> maybe he can check what happens on his arch, when an affected clock is changed.

I tested this use case with the patch, the good parent is selected (600 
Mhz) and make the
division to have 75 Mhz.

But if CLK_SET_RATE_PARENT is set, it will take the 981 Mhz clock and 
recalculate the parent rate
(because the diff rate is equal or a little better than the 600 Mhz clock)

Which is a shame, all child clocks are affected.

It was the best choice to choose other parent
and do just a division (not recalculate the parent rate)

Best Regards

Gabriel.




>
>> Mike, any opinion on this patch ?
>>
>> Best Regards,
>>
>> Boris
>>
