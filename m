From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 14 Apr 2011 12:29:52 -0700
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <20110414120904.GH1611@n2100.arm.linux.org.uk>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
	<1302776705.28876.113.camel@pasglop>
	<20110414103200.GF1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140751220.24613@xanadu.home>
	<20110414120904.GH1611@n2100.arm.linux.org.uk>
Message-ID: <4DA74B30.8090200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2011 05:09 AM, Russell King - ARM Linux wrote:
> On Thu, Apr 14, 2011 at 07:59:58AM -0400, Nicolas Pitre wrote:
>> On Thu, 14 Apr 2011, Russell King - ARM Linux wrote:
>>
>>> On Thu, Apr 14, 2011 at 08:25:05PM +1000, Benjamin Herrenschmidt wrote:
>>>> On Thu, 2011-04-14 at 11:00 +0100, Russell King - ARM Linux wrote:
>>>>>
>>>>> I will take it, but at the moment I'm rather unhappy about the response
>>>>> from the community to Linus' complaint.
>>>>>
>>>>> If existing platform maintainers can show that moving over to this will
>>>>> result in a net reduction of code under arch/arm, then that will be good.
>>>>> What I don't want to see at the moment is arch/arm increasing in size as
>>>>> a result of any change.  We desperately need to see a reduction for the
>>>>> next merge window.
>>>>
>>>> It's a chicken and egg... platform maintainers wait for you to take it
>>>> and you wait for them to take it :-)
>>>>
>>>> It seems to me that this fits well into the category of "better common
>>>> abstractions" that was discussed in the thread initiated by Linus as one
>>>> of the ways to improve on the "clutter"...
>>>
>>> That depends - sometimes creating generic stuff results in a net increase
>>> in the overall size, and that's something that Linus also complained about.
>>>
>>> According to linux-next, where we are at the moment with arch/arm is a
>>> net increase of 6000 lines since the close of the last merge window,
>>> and arch/arm is responsible for almost 75% of arch/ changes.  It looks
>>> very much like the same situation which Linus complained about.
>>
>> Quoting Linus:
>>
>> | Umm. The whole "number of lines of code" thing has become a total red
>> | herring.
>> |
>> | THAT IS NOT WHY I STARTED TO COMPLAIN!
>> |
>> | The reason I point out the number of lines of code is because it's one
>> | of the more obvious _symptoms_ of the problem.
>>
>> So we need to work on infrastructure, and the clock API is exactly that.
>> Obviously adding it will increase the number of lines of code initially,
>> but eventually this will help _reduce_ them, and more importantly it
>> will allow for the reduction of mindless duplication of code that was
>> identified as being the actual problem causing maintenance pain.
>
> Adding it without anyone using it doesn't solve anything.  We need
> people to commit to producing patches to use it for the next merge
> window.

Russell,

In your first reply to Jeremy you said this:
"I will take it, but at the moment I'm rather unhappy about the response
from the community to Linus' complaint."

So, if you are going to pull in his patches for the next merge, you can 
ignore this most of this email.

Talking for MSM, I'm waiting for some kind of certainty that these APIs 
will not be changed again before I rework our clock code to it. Even if 
I decide to move to this new framework without that certainty, it's 
going to be hard to convince driver teams to start using this new API if 
it's not already accepted upstream. At which point we would be back to 
square one -- "we need to see drivers (clock consumers) use these new 
APIs/rework before we pull it in".

Long story short, it's exactly the chicken and egg problem Nicolas was 
talking about and we need to break the egg :-)

Also, Jeremy's changes are more than just consolidation. They add 
clk_prepare/clk_unprepare APIs and those would be quite beneficial to 
quite a few machs/archs.

> And if you think its not about lines of code - grab the current linux-next
> tree and look at the diff between v2.6.39-rc1 and master for arch/arm, and
> then tell me whether using LOC is unreasonable given the patch content.

I'm sure lines of code is important, but saying we won't add any 
architectural improvements because it adds LOC seems backwards. If we go 
by that policy, the end result would be a freeze of the kernel.

Btw, what's your position on device tree for ARM? Device tree should 
help out a lot with clock data taking up too many LOCs.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
