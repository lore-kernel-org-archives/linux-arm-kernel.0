From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 12 Aug 2015 10:39:09 +0800
Subject: [PATCH 5/7] clk: atlas7: fix the clock tree for bluetooth stuff
In-Reply-To: <20150812000229.GB26614@codeaurora.org>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
 <1438064845-17894-6-git-send-email-21cnbao@gmail.com>
 <55B7FD22.10609@codeaurora.org>
 <CAGsJ_4wg1+5KrwTJRzE-iaSTvgvgFrM6cDyUTL16gx6Hk+tdPw@mail.gmail.com>
 <55C2BBED.4050608@codeaurora.org>
 <CAGsJ_4y=TC1LXC1CPB=c1bfY7ZR0ktMD+hVuUZWxXXpyRR9zEw@mail.gmail.com>
 <20150812000229.GB26614@codeaurora.org>
Message-ID: <CAGsJ_4x3L=p1tR7bg=d8WwLe_2ojZgCw4aiuN5quM7YtP150tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-12 8:02 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 08/10, Barry Song wrote:
>> 2015-08-06 9:44 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
>> >
>> > This actually points out a big problem we have right now in Linux, which is
>> > the lack of proper power management for the type of bus topology you see in
>> > embedded systems. Some of the genpd work going on may also be another
>> > solution to this problem, where we could group multiple devices into generic
>> > power domains that know to turn on 2 or 3 of the clocks. For example, the
>> > DMAC, USP, and UART device could all be in the APB power domain so that the
>> > a7ca_io_clk is enabled whenever one of those devices is active. And there
>> > could be another power domain for the NOC that encompasses all devices that
>> > are sitting on that NOC.
>> >
>>
>> Stephen, this should be a possible option, i will talk with HW guys to
>> figure out the relationship of power domain, and check whether we
>> handle this issue by the power domain solution.
>>
>> btw, would you apply other patches in this series at first? we can
>> hold on this one to find a final solution.
>>
>
> Yes. I'll apply the rest to clk-next.

Stephen, thanks a lot. i think more about the power domain solution.
we can re-look at the attached diagram(btm.png) again.

usp3 requires btm_io_clk and uart6_io_clk;
uart6_io requires btm_io_clk and dmac4_io_clk;
dmac4_io requires btm_io_clk and a7ca_io_clk;
a7ca_io requires btm_io_clk and btm_noc_clk;

if we put these things in a power domain, it seems we can enable these
clocks together or disable them together. but it seems we can't
describe the dependency how.

for example, if someone wants to use usp3, it means all clocks should
be enabled.
but if someone only wants to use a7ca_io, it means only btm_io_clk and
btm_noc_clk should be enabled, others should be disabled.
and if someone wants to use dmac4_io, then btm_io_clk , btm_noc_clk
and a7ca_io_clk should be enabled, others should be disabled.

it is difficult to find any power domain things can really resolve the
right dependency of the clock except that we can do such a power
domain as diagram pd.png. but the problem is this is the powerdomain
design in the real hardware.

it turns out the current patch really resolves all problems except
that it is not a right description to clock tree. but it does build a
good dependency map for the relationship of the clocks.

-barry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: btm.PNG
Type: image/png
Size: 5993 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/0795135e/attachment.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pd.png
Type: image/png
Size: 4527 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/0795135e/attachment-0001.png>
