From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 15 Feb 2011 00:33:25 -0800 (PST)
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <201102151526.54280.jeremy.kerr@canonical.com>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<201102151041.40655.jeremy.kerr@canonical.com>
	<4D5A100F.9000809@codeaurora.org>
	<201102151526.54280.jeremy.kerr@canonical.com>
Message-ID: <9c19ea8f4feb750f9f17486226099cd0.squirrel@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

Sorry, if the formatting is weird. Using webmail client

On Mon, February 14, 2011 11:26 pm, Jeremy Kerr wrote:
>> > We
>> > may even want to disallow set_rate (and set_parent) when prepare_count
>> is
>> > non- zero.
>>
>> This is definitely not right.
>
> Why is that? Consider two devices using one clock; one does some
> initialisation based on the return value of clk_get_rate(), the other
> calls
> clk_set_rate() some time later. Now the first device is incorrectly
> initialised.

The case you describe is certainly something I consider as incorrect and
agree with you in that we should try to prevent it. But

(prepare_count != 0) != (two devices using one clock).

For one, prepare_count == 1 would be a normal case when a clock is enabled
and the MSM drivers certainly want to be able to set the rate when the
clock is enabled.

But (prepare_count > 1 || enable_count > 1) doesn't mean more than one
device/device driver using the clock either. A simple example would be a
driver wrapping all it's register accesses with a clk_enable/clk_disable
and not having to worry about if a clock is enabled during register access
when it has multiple execution paths (threads, interrupt handler, timers,
etc) that access registers. The driver would just do the enable/disable
around register accesses and let the clock code's ref counting dealing
with making sure a clock is never turned off when it's needed. In these
case both the prepare_count (less likely, but likely) and enable_count can
greater than 1.

Long story short, I support your desire to prevent one driver from
changing the rate from underneath another driver, but the condition you
chose to figure that out is not accurate.

> Regardless, this is definitely something to flag for a later discussion.
> I'm
> happy to return to that, but we should focus on one issue at a time here.

Sure, this discussion of set rate with count is non-zero can be reserved
for later. But I think the discussion of grabbing the lock during
set_parent should be discussed in the context of this patch.

Waiting to see how others feel about this.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
