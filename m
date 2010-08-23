From: robherring2@gmail.com (Rob Herring)
Date: Sun, 22 Aug 2010 20:14:54 -0500
Subject: RFC: A better clock rounding API?
In-Reply-To: <4C6EFB47.70607@codeaurora.org>
References: <4C6B7213.3030808@codeaurora.org>
	<AANLkTik1cES4GP4hRf=B5BLrEN35B3p7rFz+tcsHDtHf@mail.gmail.com>
	<4C6EFB47.70607@codeaurora.org>
Message-ID: <AANLkTinxjg3x3oosMJLXg470gkNFo8nZqDBSrKOz6YUm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Saravana,

On Fri, Aug 20, 2010 at 5:01 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> Rob,
>
>> This is still ambiguous. If there are multiple valid frequencies in
>> the range, is the preferred rate returned the lowest rate or highest
>> rate in the range? For something like an SD bus clock you would want
>> the maximum rate within the range. For something like a LCD pixel
>> clock or CMOS sensor input clock, you typically only need to be
>> greater than a certain minimum freq and for power reasons you want it
>> to be closest to the minimum.
>
> Thanks for the feed back. This ambiguity is what my alternate proposal
> handles. To repeat the 2nd option:
>
> long clk_find_rate(struct clk *clk,
> ? ? ? ? ? ? ? ? ? ? ? ?unsigned long start_rate,
> ? ? ? ? ? ? ? ? ? ? ? ?long end_rate);
>
> With the above API, the clock driver tries to find a freq between start_rate
> and end_rate, but starts the search from "start_rate".
>
> So, if you prefer lower freqs, you call it as:
> clk_find_rate(clk, 100000, 150000);
>
> and if you prefer higher freqs, you call it as:
> clk_find_rate(clk, 150000, 100000);
>
> That should take care of your concerns, right?
>
> -Saravana

Okay, that does address my concern, but I think that the use of the
function is not completely obvious without explanation and subject to
coding mistakes. Also, considering clk_round_rate would still be
ambiguous and with efforts to unify struct clk, perhaps it makes more
sense to fix all users and implementations of clk_round_rate rather
than add a new function which will duplicate some portion of
clk_round_rate implementations.

Rob
