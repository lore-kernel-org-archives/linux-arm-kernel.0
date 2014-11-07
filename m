From: dianders@chromium.org (Doug Anderson)
Date: Fri, 7 Nov 2014 14:52:38 -0800
Subject: [PATCH] clk: Propagate prepare and enable when reparenting orphans
In-Reply-To: <20141107185844.GR4042@n2100.arm.linux.org.uk>
References: <1415386312-23741-1-git-send-email-dianders@chromium.org>
 <20141107185844.GR4042@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=WhWqMB=-ErD-59-z=y7OCZx4r7REkr3DpyYR=76SEJ6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, Nov 7, 2014 at 10:58 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 07, 2014 at 10:51:52AM -0800, Doug Anderson wrote:
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 4896ae9..a3d3d58 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -1650,6 +1650,17 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
>>       clk_reparent(clk, new_parent);
>>       __clk_recalc_accuracies(clk);
>>       __clk_recalc_rates(clk, POST_RATE_CHANGE);
>> +
>> +     if (clk->prepare_count) {
>> +             unsigned long flags;
>> +
>> +             __clk_prepare(new_parent);
>> +
>> +             flags = clk_enable_lock();
>> +             if (clk->enable_count)
>> +                     __clk_enable(new_parent);
>> +             clk_enable_unlock(flags);
>> +     }
>
> I really don't understand why this isn't already done - I said this was
> necessary a /long/ time ago.
>
> However, the above isn't sufficient.  Think about the old parent - this
> should be disabled and unprepared if it was prepared and enabled by the
> child.

You may be referring of a different bug than I am addressing.  I can
think about the old parent, but it always a tear to my eyes since
these clocks are orphans and had no old parents (unless you count the
matron at the orphanage, but I doubt she was either prepared or
enabled).  ;)

Ah, but I see!  There are other users of this function that are not
part of "clk.c".  Doh!  Since this was a "__" function with no
documentation I assumed it was "static", but I see that it is not.  I
see two callers that are not part of the orphan code.

I'll happily move this code down so it's only called by the orphan
code and not touch the two callers of __clk_reparent(), assuming that
they don't need to deal with this scenario.


NOTE: As far as I can tell, the standard exposed API call is
clk_set_parent().  From reading comments that does move the prepared /
enabled state, but I haven't confirmed that functionality.

-Doug
