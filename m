From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 20 Mar 2012 16:53:56 -0700
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <efca11f1b68186dbf1771c09fe3a2f0a.squirrel@www.codeaurora.org>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <20120320140220.GE32469@S2101-09.ap.freescale.net>
 <efca11f1b68186dbf1771c09fe3a2f0a.squirrel@www.codeaurora.org>
Message-ID: <CAJOA=zNmgSQfYAUZ-vqqTk0w3s3eKz3tjVOpyDgO35Q_Ogkz0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 10:46 AM, Saravana Kannan
<skannan@codeaurora.org> wrote:
> On Tue, March 20, 2012 7:02 am, Shawn Guo wrote:
>> On Thu, Mar 15, 2012 at 11:11:19PM -0700, Mike Turquette wrote:
>> ...
>>> +struct clk_ops {
>>> + ? ?int ? ? ? ? ? ? (*prepare)(struct clk_hw *hw);
>>> + ? ?void ? ? ? ? ? ?(*unprepare)(struct clk_hw *hw);
>>> + ? ?int ? ? ? ? ? ? (*enable)(struct clk_hw *hw);
>>> + ? ?void ? ? ? ? ? ?(*disable)(struct clk_hw *hw);
>>> + ? ?int ? ? ? ? ? ? (*is_enabled)(struct clk_hw *hw);
>>> + ? ?unsigned long ? (*recalc_rate)(struct clk_hw *hw,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long parent_rate);
>>
>> I believe I have heard people love the interface with parent_rate
>> passed in. ?I love that too. ?But I would like to ask the same thing
>> on .round_rate and .set_rate as well for the same reason why we have
>> it for .recalc_rate.
>
> In my case, for most clocks, set rate involves reparenting. So, what does
> passing parent_rate for these even mean? Passing parent_rate seems more
> apt for recalc_rate since it's called when the parent rate changes -- so,
> the actual parent itself is not expected to change.

>From my conversations with folks across many platforms, I think that
the way your clock tree expects to change rates is the exception, not
the rule.  As such you should just ignore the parent_rate parameter as
it useless to you.

> I could ignore the parameter, but just wondering how many of the others
> see value in this. And if we do add this parameter, it shouldn't be made
> mandatory for the platform driver to use it (due to other assumptions the
> clock framework might make).

>From my rough census of folks that actually need .set_rate support, I
think that everyone except MSM could benefit from this.  Your concept
of clk_set_rate is everyone else's clk_set_parent.

Ignoring the new parameter should cause you no harm.  It does make me
wonder if it would be a good idea to pass in the parent rate for
.set_parent, which is analogous to .set_rate in many ways.

Regards,
Mike

> -Saravana
