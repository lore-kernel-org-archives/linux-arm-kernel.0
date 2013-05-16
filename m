From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 15 May 2013 21:17:03 -0700
Subject: [PATCH] clk: Fix race condition between clk_set_parent and
 clk_enable()
In-Reply-To: <CAPDyKFpZ6-O-zSyBVgGGFL4W+d=-k-qaXimUS12fgC=9TkUNVA@mail.gmail.com>
References: <1367383328-25700-1-git-send-email-skannan@codeaurora.org>
 <CAPDyKFpZ6-O-zSyBVgGGFL4W+d=-k-qaXimUS12fgC=9TkUNVA@mail.gmail.com>
Message-ID: <51945DBF.60308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2013 12:24 PM, Ulf Hansson wrote:
> On 1 May 2013 06:42, Saravana Kannan <skannan@codeaurora.org> wrote:

<snip>

>> -       /* migrate prepare */
>> -       if (clk->prepare_count)
>> +       /*
>> +        * Migrate prepare state between parents and prevent race with
>> +        * clk_enable().
>> +        *
>> +        * If the clock is not prepared, then a race with
>> +        * clk_enable/disable() is impossible since we already have the
>> +        * prepare lock (future calls to clk_enable() need to be preceded by
>> +        * a clk_prepare()).
>> +        *
>> +        * If the clock is prepared, migrate the prepared state to the new
>> +        * parent and also protect against a race with clk_enable() by
>> +        * forcing the clock and the new parent on.  This ensures that all
>> +        * future calls to clk_enable() are practically NOPs with respect to
>> +        * hardware and software states.
>> +        */
>
> Maybe an additional note about that since CLK_SET_PARENT_GATE is a
> prerequisite for doing migration of "prepare", we also interpreted
> this flags as it is acceptable to enable the clock(s) in this context.

Done. Sent v2 patch.

<snip>

>
> Looks good! Thanks for having another round to fixup this kind of
> tricky code. :-)

Thanks :-)

> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>

Thanks again.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
