From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 26 Apr 2012 02:36:37 -0700 (PDT)
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120426084201.GF17184@pengutronix.de>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <4F98EB10.2000505@codeaurora.org>
 <20120426084201.GF17184@pengutronix.de>
Message-ID: <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, April 26, 2012 1:42 am, Sascha Hauer wrote:
> On Wed, Apr 25, 2012 at 11:28:32PM -0700, Saravana Kannan wrote:
>>
>> >diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
>> >index 6e58f11..8e97491 100644
>> >--- a/drivers/clk/clk-mux.c
>> >+++ b/drivers/clk/clk-mux.c
>> >@@ -95,6 +95,7 @@ struct clk *clk_register_mux(struct device *dev,
>> const char *name,
>> >  {
>>
>> I would really like to remove these functions. At least until we add
>> device tree support where each clock is listed in device tree.
>>
>> At present, these functions seem to be abused more than actually
>> being used appropriately.
>
> I think this goes in my direction. Still exactly this abuse how you call
> it makes me relatively independent of for example the changes you
> introduce with your patch. Had I static initializers I would now have
> to start a rebase orgy.

In the other email you say you have to change. Here you say, you don't
have to change. Hopefully, you didn't have to change much -- I was aiming
for that. If there was agreement about removing these functions, I was
planning on helping move the current users after this patch merged.

I think in the long run this will result in less changes for you and more
readable code. If clk_register() adds another optional param, you can't
get around that without having to write more wrapper functions or changing
any existing ones you might have. But with this struct, the common clock
code can be written in a way so that the a value of 0 for the new param
defaults to the behavior that was there before the param was added.

Something to think about: With these wrapper calls, one would do a lot of
kalloc and copying of small items when one knows at compile time what the
clocks are going to be.

Anyway, I understand that some people see value in this. That's why I'm
bringing it up for discussion instead of just doing it in my patch.

-Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
