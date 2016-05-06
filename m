From: dianders@chromium.org (Doug Anderson)
Date: Fri, 6 May 2016 11:00:02 -0700
Subject: [PATCH v7 8/9] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <572C64B5.6080607@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372609-6535-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=VhMJiowNWm+0=jzzK0vajg1=3PutaWbzhGPN_BU2+19w@mail.gmail.com>
 <572C64B5.6080607@rock-chips.com>
Message-ID: <CAD=FV=XOOAbKxqJsxGU4pXbNJtbq_Q4Pj2=9P48NCze5NTJyrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, May 6, 2016 at 2:32 AM, David.Wu <david.wu@rock-chips.com> wrote:
>> Also (optional): once you do that, there becomes much less of a reason
>> to store "t_calc" in "struct rk3x_i2c".  Already you're never using
>> the "div_low" and "div_high" that you store in the "struct rk3x_i2c".
>> Of course, to do that you've got to change other places not to clobber
>> these bits in REG_CON.
>>
>
> So, I only just need to store tuning value in the "struct rk3x_i2c", but not
> to store the "div_low" and "div_high"?

I was suggesting not adding anything to what's stored in "struct
rk3x_i2c" (AKA don't add t_calc there).  Just set the value directly
in the register here then change all other bits of code to respect it.

That is:

In rk3x_i2c_start(), write:

  u32 val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;

In rk3x_i2c_xfer(), write:
  val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK
  val |= REG_CON_EN | REG_CON_STOP, REG_CON;
  i2c_writel(i2c, val);


You could get fancy and add a new "i2c_update_bits", but that might be overkill.


> The patches we have already used in our projects, they are verified by the
> basic tests. I would ask them to do more tests. Because we didn't change the
> clock rate now, it was a fixed value when clk inited, so we could not find
> the bug here.

OK.  Presumably a rk3066 w/ DVS enabled would be a good test?  Reading
the description of commit 249051f49907 ("i2c: rk3x: handle dynamic
clock rate changes correctly"), I see:

    The i2c input clock can change dynamically, e.g. on the RK3066 where
    pclk_i2c0 and pclk_i2c1 are connected to the armclk, which changes
    rate on cpu frequency scaling.


>> If you take that advice, you can get rid of all of the "if
>> (i2c->pclk)" statements in your code.
>>
>
> It would make i2c->clk to be enabled and prepared twice when uses
> rk3x_i2c_v0_calc_timings for old hardware. But if do the opposite
> disabled and unprepated twice, that is okay.

Right.  The same clock will get an enable / prepare count of "2"
(instead of two different clocks getting a count of "1).  ...but
nothing should be hurt by that.

-Doug
