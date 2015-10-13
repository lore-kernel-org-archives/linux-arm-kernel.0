From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 13 Oct 2015 11:34:05 +0800
Subject: [PATCH 1/3] clk: add flag for clocks that need to be enabled
 on rate changes
In-Reply-To: <37059102.QWiKhRxp8v@diego>
References: <1929669.AsgMSusdJb@phil> <20151008215840.GJ26883@codeaurora.org>
 <13378907.1JCOSf8QGs@diego> <37059102.QWiKhRxp8v@diego>
Message-ID: <561C7BAD.7020401@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2015?10?13? 00:03, Heiko St?bner wrote:
> Am Sonntag, 11. Oktober 2015, 12:41:09 schrieb Heiko St?bner:
>> Hi Stephen,
>>
>> Am Donnerstag, 8. Oktober 2015, 14:58:40 schrieb Stephen Boyd:
>>> On 10/02, Heiko St?bner wrote:
>>>> Hi,
>>>>
>>>> any comment on these 3 patches?
>>> Dong has a similar problem, but those patches conflate this with
>>> enabling parent clocks during clk_disable_unused() which makes no
>>> sense to me. So I'm ok with the requirement that we turn clocks
>>> on to change rates, but I wonder if in this case we need to turn
>>> on the clock that's changing rates itself, or if we just need to
>>> turn on the parent and/or future parent of the clock during the
>>> rate switch. Care to elaborate on that?
>> As you can see in the follow-up patches, the fractional dividers on Rockchip
>> SoCs are quite strange in that they even need to have their _downstream_
>> mux point to them to actually accept rate changes.
>>
>> The register value always reflects the value set by the system, but hardware
>> really only accepts it if the clock is enabled and even the downstream mux
>> selects the fractional divider as parent (they call it a auto-gating
>> feature).
>>
>> So in the worst (and current) case, you end up with the register showing the
>> right value, but the hardware can use completely different dividers from
>> the previous setting.
>>
>> That strange behaviour got quite deeply investigated between Rockchip and
>> Google engineers who stumbled upon this in the first place, so I'm
>> reasonably sure this is the right solution for that clock type :-) .
> Xing Zheng now also independently stumbled upon this issue with his rk3036
> work. And came to the same conclusion that the gate must be enabled as well as
> the downstream mux be set to the fractional divider for it to actually accept
> a new setting.
Yes, I discussed such problems with Heiko about the question:
The RK3036 i2s frac(CRU_SEL7_CON) set value is invalid when I playback a 
48KHz music:
/ # io -4 0x20000060
20000060: 01003057
read register is 0x01003057, but the result of frac divider on the basis 
of default 0x0bb8ea60(numerator=3000, denominator=60000, ratio=20), so 
the out of mclk remains 594/20=29.7MHz

I tracked the logs:
[ 49.770322] clk_fd_set_rate: 91, name: i2s_frac, rate = 12288000, 
parent_rate = 594000000
[ 49.778524] clk_fd_set_rate: 107, name: i2s_frac, val = 0x01003057
[ 49.784714] clk_fd_recalc_rate: 29, name: i2s_frac, parent_rate = 594000000
[ 49.791707] clk_fd_recalc_rate: 47, name: i2s_frac, val = 0x01003057, m 
= 256, n = 12375
[ 49.799836] clk_mux_set_parent: 81, name: i2s_pre
It seem like set i2s_frac_div then set mux is i2s_pre. I think we should 
select the correct mux and open clock gate, then set the i2s_frac_div, 
and I tried to do it, setting i2s_frac_div is vaild and mclk is 
12.288MHz. Therefore, I think that select parent mux and enable gate 
should before child node set value.

Thanks. :)
