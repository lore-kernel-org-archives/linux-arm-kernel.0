From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 16 Dec 2015 11:32:17 +0100
Subject: [PATCH] clocksource/drivers/pistachio: Fix wrong calculated
 clocksource read value
In-Reply-To: <20151216093340.GD8644@n2100.arm.linux.org.uk>
References: <1448466169-5230-1-git-send-email-jszhang@marvell.com>
 <56707F32.3030405@linaro.org> <20151216151125.1e91b4f4@xhacker>
 <20151216152807.23491eee@xhacker> <20151216153609.0f09f941@xhacker>
 <56712D33.5080009@linaro.org> <20151216093340.GD8644@n2100.arm.linux.org.uk>
Message-ID: <56713DB1.9070301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2015 10:33 AM, Russell King - ARM Linux wrote:
> On Wed, Dec 16, 2015 at 10:21:55AM +0100, Daniel Lezcano wrote:
>> On 12/16/2015 08:36 AM, Jisheng Zhang wrote:
>>> And in fact, clocksource_mmio_readw_down() also has similar issue, but it masks
>>> with c->mask before return, the c->mask is less than 32 bit (because the
>>> clocksource_mmio_init think number of valid bits > 32 or < 16 is invalid.)
>>> the higher 32 bits are masked off, so we never saw such issue. But we'd better
>>> to fix that, what's your opinion?
>>
>> I think we should have a look to this portion closely.
>
> There is no need to return more bits than are specified.  If you have
> a N-bit counter, then the high (64-N)-bits can be any value, because:
>
> static inline cycle_t clocksource_delta(cycle_t now, cycle_t last, cycle_t mask)
> {
>          return (now - last) & mask;
> }
>
> where 'now' is the current value returned from the clock source read
> function, 'last' is a previously returned value, and 'mask' is the
> bit mask.  This has the effect of ignoring the high order bits.

I think this approach is perfectly sane. When I said we should look at 
this portion closely, I meant we should double check the bitwise-nor 
order regarding the explicit cast. The clocksource's mask makes sense 
and must stay untouched.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
