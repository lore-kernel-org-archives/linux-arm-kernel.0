From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 08 Jan 2014 08:33:52 -0800
Subject: [PATCH] clk: clk-divider: fix divisor > 255 bug
In-Reply-To: <52CA807E.8020100@imgtec.com>
References: <1387190498-15392-1-git-send-email-james.hogan@imgtec.com>
 <20140103041556.12054.53966@quantum> <52CA807E.8020100@imgtec.com>
Message-ID: <20140108163352.27803.86084@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting James Hogan (2014-01-06 02:07:58)
> On 03/01/14 04:15, Mike Turquette wrote:
> > Quoting James Hogan (2013-12-16 02:41:38)
> >> Commit 6d9252bd9a4bb (clk: Add support for power of two type dividers)
> >> merged in v3.6 added the _get_val function to convert a divisor value to
> >> a register field value depending on the flags. However it used the type
> >> u8 for the div field, causing divisors larger than 255 to be masked
> >> and the resultant clock rate to be too high.
> >>
> >> E.g. in my case an 11bit divider was supposed to divide 24.576 MHz down
> >> to 32.768KHz. The divisor was correctly calculated as 750 (0x2ee). This
> >> was masked to 238 (0xee) resulting in a frequency of 103.26KHz.
> >>
> >> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > 
> > Taken into clk-next. Thanks for the fix!
> 
> Thanks Mike, is there any chance of getting this into v3.13, or is it
> too late?

I had applied it to clk-next but I just moved it over to my -fixes
branch. Will send later today.

Regards,
Mike

> 
> Cheers
> James
> 
> >> Cc: Rajendra Nayak <rnayak@ti.com>
> >> Cc: Mike Turquette <mturquette@linaro.org>
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: stable at vger.kernel.org
> >> ---
> >> Since this bug was introduced in 3.6, it probably should by applied to
> >> stable 3.10 and 3.12.
> >> ---
> >>  drivers/clk/clk-divider.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> >> index 8d3009e44fba..5543b7df8e16 100644
> >> --- a/drivers/clk/clk-divider.c
> >> +++ b/drivers/clk/clk-divider.c
> >> @@ -87,7 +87,7 @@ static unsigned int _get_table_val(const struct clk_div_table *table,
> >>         return 0;
> >>  }
> >>  
> >> -static unsigned int _get_val(struct clk_divider *divider, u8 div)
> >> +static unsigned int _get_val(struct clk_divider *divider, unsigned int div)
> >>  {
> >>         if (divider->flags & CLK_DIVIDER_ONE_BASED)
> >>                 return div;
> >> -- 
> >> 1.8.1.2
> >>
> >>
> 
