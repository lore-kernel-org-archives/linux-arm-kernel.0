From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 20 Mar 2012 13:14:51 -0700
Subject: [PATCH 2/2] clk: Move init fields from clk to clk_hw
In-Reply-To: <20120320181441.GO3852@pengutronix.de>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <1332214706-675-2-git-send-email-skannan@codeaurora.org>
 <20120320072018.GC32469@S2101-09.ap.freescale.net>
 <cbd6490459b9fd68875fec4a7c7de073.squirrel@www.codeaurora.org>
 <20120320094031.GI3852@pengutronix.de>
 <e22898bc8b69e85f1e6390d7d858f85c.squirrel@www.codeaurora.org>
 <20120320181441.GO3852@pengutronix.de>
Message-ID: <4F68E53B.7040800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2012 11:14 AM, Sascha Hauer wrote:
> On Tue, Mar 20, 2012 at 03:17:10AM -0700, Saravana Kannan wrote:
>>
>> On Tue, March 20, 2012 2:40 am, Sascha Hauer wrote:
>>> On Tue, Mar 20, 2012 at 12:54:55AM -0700, Saravana Kannan wrote:
>>>>
>>> I am using these functions and don't need a static array, I just call
>>> the functions with the desired parameters.
>>
>> Sure, then let's leave it in. Curious, where do you get the desired
>> parameters from? Is it static date in code or is it from DT? You somehow
>> probe it?
>
> It's not from DT. See this thread:
>
> http://www.spinics.net/lists/arm-kernel/msg165839.html

Ah, I see. That's a lot of functions calls. I think it would be much 
more efficient if you just have an array and loop over it. With my 
patch, you can just call a single register function for all these clocks.

>>
>>> Overall the clock framework was written in a way that we have to expose
>>> as little information about the internally used structs as necessary. It
>>> seems your patches are pulling in the opposite direction now.
>>
>> I'm not exposing anything that you don't already pass from the platform
>> driver. Also, you realize that this is very similar to what you suggested
>> with clk_initializer right? If there is a strong push, we can make a copy
>> of these inside the struct clk, but for these few init fields I don't see
>> a point (see earlier email).
>
> The difference is that a struct clk_initializer is only used to
> initialize a clock and not actively used by the clock framework. But as
> you already mentioned using a copy inside the clock framework has the
> same effect.

My opinion on this is to follow a wait and watch approach on the "flags" 
field. I really can't think of a safe way anyone can misuse it. If 
people start doing that, we can just do the copy and let them deal with 
their broken code. Until that happens, I don't want to waste time/space 
by copying it. The rest of the fields aren't actively used by the common 
clock code after init.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
