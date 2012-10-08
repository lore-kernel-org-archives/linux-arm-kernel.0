From: robherring2@gmail.com (Rob Herring)
Date: Mon, 08 Oct 2012 07:56:25 -0500
Subject: [PATCH] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <506DE1F4.9090309@codeaurora.org>
References: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
 <506D899C.6010705@gmail.com> <506DE1F4.9090309@codeaurora.org>
Message-ID: <5072CD79.7060005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2012 02:22 PM, Stephen Boyd wrote:
> On 10/04/12 06:05, Rob Herring wrote:
>> On 10/04/2012 03:50 AM, Stephen Boyd wrote:
>>> The TWD and SCU configs are selected by default as long as
>>> SCORPIONMP is false and/or MCT is false. Implementing the logic
>>> this way certainly saves lines in the Kconfig but it precludes
>>> those machines which select SCORPIONMP or MCT from participating
>>> in the single zImage effort because when those machines are
>>> combined with other SMP capable machines the TWD and SCU are no
>>> longer selected.
>>>
>>> Push the select out to the machine entries so that we can compile
>>> these machines together and still select the appropriate configs.
>> I think this is the wrong direction as I'd like to see the platform
>> selects shrink. I believe the local timers are run-time enabled now, so
>> can't we just drop the condition and always select TWD and SCU for
>> multi-platform?
> 
> That sounds fine for multi-platform but it penalizes the "optimized"
> images made for a particular device that doesn't want any extra code
> than is necessary. Isn't this why we have the Kconfig language?
> 

Yes, but neither of those are very much code. There has to be some
threshold.

>>
>> Or perhaps we need a CortexA9 config symbol that selects V7, GIC, TWD,
>> SCU, SMP, PL310, errata, etc. rather than duplicating those for every
>> platform.
>>
>>
> 
> This sounds like a good consolidation of lines that can be done in
> parallel to this patch. Care to send a patch on top?

So I would just go and delete most of the lines you are adding? Sounds
like churn to me. We should do this first if we are going to.

Also, your patch is not going to apply once Russell's alphabetizing of
selects patch goes in. I'm not sure if that is this merge window or next.

Rob
