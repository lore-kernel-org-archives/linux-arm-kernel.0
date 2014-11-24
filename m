From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Nov 2014 13:19:51 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <CAJAp7OiLwMQEYFr9xdLg=S=cAPtN+hKZq3j5iSe0oL_Qz3URwg@mail.gmail.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>	<546FC674.1070005@codeaurora.org>
 <CAJAp7OiLwMQEYFr9xdLg=S=cAPtN+hKZq3j5iSe0oL_Qz3URwg@mail.gmail.com>
Message-ID: <5473A0F7.10308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 09:02 AM, Bjorn Andersson wrote:
> On Fri, Nov 21, 2014 at 3:10 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> Hi Bjorn,
>>
> Hi Stephen,
>
> Thanks for taking the time to look at my proposal.
>
> [..]
>
>> So the CPU really wants to only be voting for the HFPLL regulator
>> supplies in the active set. This way, if we're not using the HFPLLs
>> (i.e. the CPUs are all running off the global PLL), then we can disable
>> the regulator in the active set (RPM code only caches sleep set so we
>> won't be doing unnecessary flushes in the idle/suspend path). The clock
> In the codeaurora tree the flushing is handled by a call from the Qcom PM
> driver straight into the regulator/resource driver that have a private list of
> all regulators that it goes through and pushes out requests (while in atomic
> context).
>
> I'm not sure how to model this in a sane way...
>
>> driver will make sure to turn off the HFPLLs before we go into a sleep
>> state that would trigger a switch from active to sleep set (commonly
>> referred to as RPM notification). It very well could be that there are
>> other consumers of the same regulator, but that doesn't matter to the
>> CPU clock driver because it only cares about the active set. Now you may
> Okay, so CPUFREQ or a system suspend can explicitly call regulator_disable() on
> our shared regulator and in CPUIDLE we will just depend on the sleep state?

Yes.

>> ask why can't the CPU clock driver disable the regulator when the HFPLL
>> is disabled? We don't do that in this case because a) it causes more RPM
>> communication overhead and b) we will be in atomic context when the
>> HFPLL is disabled during idle/suspend and the regulator APIs are
>> sleeping calls. In the non-idle/suspend path we will disable the regulator.
>>
>> Also the active/sleep sets are about more than just on/off state. We may
>> have a situation where the active set voltage (or some other attribute
>> like current, mode, etc.) is different than the sleep set voltage. For
> You're using the word "may" here and the code clearly would let you do this,
> the part I've been struggeling with is to backtrack the consumers to figure out
> if this is actually done.

s/may//

We have this case for the example I gave, digital logic. On msm8960 it's
S3, where the CPU clock driver requests some active only voltage to
power the CPU itself whereas the peripheral clock driver requests an
active and sleep set voltage for some peripheral like uart or i2c that
will be active even when the CPU is idle or suspended.

>
>> example, the CPU is supplied by a digital logic regulator that is shared
>> with other digital logic in the SoC (GPU, wifi, etc.). The CPU may
>> require some high voltage, but the GPU only needs some lower voltage.
>> The suspend/idle code relies on the fact that the GPU is voting on the
>> active+sleep regulator while the CPU is voting on the active only
>> regulator so that the RPM can automatically switch between high voltage
>> and low voltage when the CPU notifies the RPM that it's gone idle (or
>> the CPU wakes up).
> Okay, so when we're hitting CPUIDLE we need to lower the voltage on the
> regulator, should I assume that this then must be raised before the CPU starts
> executing again?

Yes the RPM will raise the voltage when it transitions us from sleep set
to active set.

>
>
> So what it boils down to is, like the codeaurora code shows, our regulator
> driver must be able to set properties on active only or both states depending
> on which regulator consumer makes the request.
>
> For the reference; the codeaurora code models this as "resources" with 2 set of
> properties, multiple regulators are then tied to the same resource, poking the
> individual sets based on properties of the regulator (active or both). So in
> essense we get multiple regulator instances per regulator hardware.
>
>
> The problem with this model is that it's circumventing the fact that the
> regulator framework doesn't support our use cases - and I don't like this.
> I think we need to sit down and discuss this more in detail, most likely with
> Mark.

What exactly are we circumventing? I can only guess that we're talking
about the aggregation logic?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
