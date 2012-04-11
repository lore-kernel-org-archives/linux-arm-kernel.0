From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 11 Apr 2012 10:59:06 -0700
Subject: [PATCH 2/2] clk: Move init fields from clk to clk_hw
In-Reply-To: <4F7E4752.4020007@codeaurora.org>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <1332214706-675-2-git-send-email-skannan@codeaurora.org>
 <20120320072018.GC32469@S2101-09.ap.freescale.net>
 <cbd6490459b9fd68875fec4a7c7de073.squirrel@www.codeaurora.org>
 <20120320094031.GI3852@pengutronix.de>
 <20120320141811.GF32469@S2101-09.ap.freescale.net>
 <20120320181050.GN3852@pengutronix.de> <4F68E34A.70207@codeaurora.org>
 <20120320231242.GP3852@pengutronix.de>
 <CAJOA=zOGTW7OqACWgJQW6HSPLVev+apdNhv4vNXjHTcp=7N+uQ@mail.gmail.com>
 <4F694484.1030706@codeaurora.org> <4F714397.6080608@codeaurora.org>
 <CAJOA=zOq=kYfZUEnnQT_D4w=Kpp5n7R=k9oOCrxF59P5W-nw-w@mail.gmail.com>
 <4F7E4752.4020007@codeaurora.org>
Message-ID: <CAJOA=zMEN_im3-T+_uXB_mTu842o_fRkr9-7h=X18fKBoH46aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 6:30 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 03/27/2012 11:49 AM, Turquette, Mike wrote:
>>
>> On Mon, Mar 26, 2012 at 9:35 PM, Saravana Kannan<skannan@codeaurora.org>
>> ?wrote:
>>>
>>> Mike,
>>>
>>> (*nudge*) (*nudge*)
>>
>>
>> Hi Saravana,
>>
>> I spent some time mulling over the ideas this weekend and I agree that
>> we have 3 types of data, so having the three structs makes some sense.
>> ?I'm checking this patch out more earnestly today.
>
>
> (*nudge*) (*nudge*) again :-)
>
> Sorry to keep nudging you on this often. The longer we wait for this, the
> more churn it will cause later on. That's why I'm being persistent on this.
> Also, once this goes in, I can start working on upstreaming MSM clock
> support.

Sorry for the long wait Saravana.  I've been swamped the past few days.

I thought about splitting this interface further (basically making the
statically initialized stuff visible to code that includes
clk-provider.h) and it seems like the benefits outweight the negative
stuff.

However I want to advance the cause of __initdata clock initializers,
so I think the final version of this change should have the core
perform a copy of the initializer data into struct clk_hw.  It's been
a while since I looked at Sascha's clk_initalizer patches but I think
that it is essentially the same idea.

TL;DR: I think a combination of your change to expose the
not-so-private parts of struct clk into struct clk_hw are OK and have
real benefits for the clk-provider.h code.  However we need to
implement it such that all the statically initialized data can be
__initdata.

My only concern with this series is that platform clock code will
access struct clk_hw members without the appropriate lock held (namely
prepare_lock).  I'm a bit worried that there might be a case where
some clock code access clk_hw->name when clk_hw has somehow been
destroyed/altered (e.g. if clk_put every finally gets implemented...).
 Besides clk_put are there any real instances where this might happen?

I'll be pushing my fixes branch out to the list soon.  Do you want to
rebase this change on top of it taking into account the __initdata
bits?

Regards,
Mike
