From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 14 May 2012 17:10:22 -0700
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <20120514110812.GY20304@tbergstrom-lnx.Nvidia.com>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com> <4FA7ECAA.1040104@wwwdotorg.org>
 <CAJOA=zNKDFPOQ9-0EuEy=dtq=g-CKFBq94enTuoB7wVPskbkMg@mail.gmail.com>
 <CAAXpJNsJiT7s87p6jS5bdi-83n4bwSaagdSK0w3SbrVz+k+O0g@mail.gmail.com>
 <CAJOA=zP4iEZ+CFfCjT1rgU6shOt_PUf2BRB76NEQCoUPZJ9hVg@mail.gmail.com>
 <4FA9BD41.2090701@codeaurora.org>
 <20120509103606.GY20304@tbergstrom-lnx.Nvidia.com>
 <4FADD1EA.8090606@codeaurora.org> <4FAF392E.7050205@wwwdotorg.org>
 <20120514110812.GY20304@tbergstrom-lnx.Nvidia.com>
Message-ID: <4FB19EEE.90803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2012 04:08 AM, Peter De Schrijver wrote:
> On Sun, May 13, 2012 at 06:31:42AM +0200, Stephen Warren wrote:
>> On 05/11/2012 08:58 PM, Saravana Kannan wrote:
>>> On 05/09/2012 03:36 AM, Peter De Schrijver wrote:
>>>> On Wed, May 09, 2012 at 02:41:37AM +0200, Saravana Kannan wrote:
>>>>> On 05/08/2012 10:15 AM, Turquette, Mike wrote:
>>>>>> On Mon, May 7, 2012 at 10:07 PM, zhoujie wu<zhoujiewu@gmail.com>
>>>>>> wrote:
>>>>>>> Hi Mike,
>>>>>>> Could you please explain more details about how to implement a
>>>>>>> re-parenting operation as part of it's .set_rate implementation?
>>>>>>
>>>>>> Sure.
>>>>>>
>>>>>>> As far as I know, we can not call clk_set_parent in .set_rate function
>>>>>>> directly, since clk_set_rate and clk_set_parent are using the same
>>>>>>> prepare_lock.
>>>>>>
>>>>>> That is correct.
>>>>>>
>>>>>>> Any other interface can be used to implement it?
>>>>>>
>>>>>> You have two options available to you.
>>>>>>
>>>>>> 1) __clk_reparent can be used from your .set_rate callback today to
>>>>>> reflect changes made to the tree topology.  OMAP uses this in our PLL
>>>>>> .set_rate implementation: depending on the re-lock frequency the PLL
>>>>>> may switch parents dynamically.  __clk_reparent does the
>>>>>> framework-level cleanup needed for this (that function is also used
>>>>>> when populating the clock tree with new clock nodes).
>>>>>>
>>>>>> 2) __clk_set_parent could be made non-static if you needed this (I've
>>>>>> been meaning to talk to Saravana about this since I think MSM needs
>>>>>> something like this).
>>>>>
>>>>> Thanks!
>>>>>
>>>>> I don't think I need (2). But I don't think I can use (1) as is either.
>>>>> I can use (1) with some additional code in my set rate op.
>>>>>
>>>>> While set rate is in progress, both the parents might need to stay
>>>>> enabled for a short duration. So, in my internal set rate, I need to
>>>>> check if my clock is prepared/enabled and call prepare/enable on the
>>>>> "old parent", call __clk_reparent (which will reduce the ref count for
>>>>> the old parents and increase it for the new parents), finish the
>>>>> reparent in HW and then unprepare/disable the old parent if I have
>>>>> prepared/enabled them earlier.
>>>>>
>>>>> It might be beneficial to provide something like a
>>>>> __clk_reparent_start(new_parent, *scratch_pointer) and
>>>>> __clk_reparent_finish(*scratch_pointer) if it will be useful for more
>>>>> than just MSM. Based on this email, I would guess that Tegra would want
>>>>> something similar too.
>>>>>
>>>>
>>>> We also need to reparent clocks using a pll if we want to change the
>>>> PLLs rate
>>>> while the users are active.
>>>
>>> Peter,
>>>
>>> Is this reparent permanent (as in, stays reparented when you return from
>>> clk_set_rate()) or is it a reparenting for just a short duration inside
>>> the set_rate ops?
>>
>> I've seen both cases, and indeed the case sometimes depends on the
>> target rate of the clock.
>>
>> For example, when the CPU clock changes, we basically do the following
>> within set_rate:
>>
>> * Set CPU clock parent to some "backup" PLL
>> * Change the CPU PLL to the desired rate
>> * Set CPU clock parent to the CPU PLL
>>
>> However, the lowest CPU clock rate we support is actually the rate that
>> the backup PLL runs at, so if we're targeting that rate, the CPU clock
>> set_rate /just/ does:
>>
>> * Set CPU clock parent to some "backup" PLL
>>
>> and leaves it there, until a different CPU clock rate is requested, at
>> which time the CPU clock will be re-parented back to the CPU PLL.
>
> The backup PLL and rate are statically defined however. It's not chosen at
> runtime.

Yeah, this is pretty much what MSM has been doing for a while for our 
CPU clocks too. But in MSM we made the decision of not to control the 
CPU clocks through the clock APIs. It makes your life so much more 
easier. Really, the CPU clocks are very different from the rest of the 
clocks -- the set rate operation of the clock needs the clock to be 
running. We also never disable the CPU clock we are running on. Just 
that it might not be as useful as it might appear. It was especially 
hard when we didn't have clk_prepare/_unprepare().

Anyway, not saying this is the only way to proceed or using the clock 
APIs to control the CPU clock is wrong. Just some food for thought.

Anyway, getting back to the point of this thread, you might look at the 
other email I sent out on Friday [1]. Sorry I forgot to cc you on that. 
I have a list of people I copy paste when sending clock patches. I can 
add you to that list if you want (or remove anyone who is annoyed by it).

If you are doing the parent management inside the .set_rate ops, I 
believe you will have a race condition with the current clock framework. 
We need to update the clock framework to provide more APIs to implement 
this correctly. I was confused by some code and pinged Mike about it. 
Now that I understand what the code was trying to do, I think I might be 
able to clean it up a bit and then fix up set rate support.

Thanks,
Saravana

[1] http://thread.gmane.org/gmane.linux.ports.arm.msm/2655

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
