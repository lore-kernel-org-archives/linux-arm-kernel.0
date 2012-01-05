From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 5 Jan 2012 12:04:44 -0800
Subject: [PATCH v4 2/6] Documentation: common clk API
In-Reply-To: <20120105143105.GA2865@matterhorn1>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
 <1323834838-2206-3-git-send-email-mturquette@linaro.org>
 <20120105143105.GA2865@matterhorn1>
Message-ID: <CAJOA=zMEPW1vX_+KVexoLh0r4kO+vZ4zJQhsgDxwuu_7edFTgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 6:31 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> Tiny, tiny typo...
>
> On 11 Dec 13, Mike Turquette wrote:
>
>> +clk_set_rate deserves a special mention because it is more complex than
>> +the other operations. ?There are three key concepts to the common
>> +clk_set_rate implementation:
>> +
>> +1) recursively traversing up the clk tree and changing clk rates, one
>> +parent at a time, if each clk allows it
>> +2) failing to change rate if the clk is enabled and must only change
>> +rates while disabled
>> +3) using clk rate change notifiers to allow devices to handle dynamic
>> +rate changes for clks which do support changing rates while enabled
>> +
>> +For the simple, non-recursive case the call graph looks like:
>> +
>> +clk_set_rate(clk, rate);
>> + ? ? __clk_set_rate(clk, rate);
>> + ? ? ? ? ? ? clk->round_rate(clk, rate *parent_rate);
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?^^^^^^^^
>
> need a comma here? The next sentence kept me busy for 5 mins.

Thanks, will fix in next submission (along with general rework of
messy documentation).

Mike

>
>> + ? ? ? ? ? ? clk->set_rate(clk, rate);
>> +
>> +You might be wondering what that third paramater in .round_rate is. ?If
>> +a clk supports the CLK_PARENT_SET_RATE flag then that enables it's
>> +hardware-specific .round_rate function to provide a new rate that the
>> +parent should transition to. ?For example, imagine a rate-adjustable clk
>> +A that is the parent of clk B, which has a fixed divider of 2.
