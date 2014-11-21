From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Nov 2014 15:43:54 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141121232738.GP3815@sirena.org.uk>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
Message-ID: <546FCE3A.1000005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 03:27 PM, Mark Brown wrote:
> On Fri, Nov 21, 2014 at 03:10:44PM -0800, Stephen Boyd wrote:
>> On 11/10/2014 02:52 PM, Bjorn Andersson wrote:
> I don't seem to have been CCed on earlier messages here, or perhaps the
> lack of obvious relevance (like mention of regulators) caused me not to
> read the mails so I'm missing a *lot* of context.

This mail has been lingering in my inbox for weeks just haven't gotten
around to replying.

This sleep set/active set stuff has to do with more than just
regulators. It applies to any resource that the RPM provides, but
regulators are a primary use case so you're on Cc and it would be great
if you fully understood the regulator aspect here.

>
>
>> So the CPU really wants to only be voting for the HFPLL regulator
>> supplies in the active set. This way, if we're not using the HFPLLs
>> (i.e. the CPUs are all running off the global PLL), then we can disable
>> the regulator in the active set (RPM code only caches sleep set so we
>> won't be doing unnecessary flushes in the idle/suspend path). The clock
>> driver will make sure to turn off the HFPLLs before we go into a sleep
>> state that would trigger a switch from active to sleep set (commonly
>> referred to as RPM notification). It very well could be that there are
>> other consumers of the same regulator, but that doesn't matter to the
>> CPU clock driver because it only cares about the active set. Now you may
>> ask why can't the CPU clock driver disable the regulator when the HFPLL
>> is disabled? We don't do that in this case because a) it causes more RPM
>> communication overhead and b) we will be in atomic context when the
>> HFPLL is disabled during idle/suspend and the regulator APIs are
>> sleeping calls. In the non-idle/suspend path we will disable the regulator.
> I'm afraid the above is making very little sense to me.  What is
> "voting" and how is it different to "enabling", "notification" or
> "flushing"?

The regulators are shared between multiple "masters" in the SoC. So the
CPUs that are running linux only "vote" on attributes of regulators and
then another processor that isn't running linux (called RPM) aggregates
the request from Linux along with other "masters" like wifi, modem, etc.
and then changes something for that regulator like voltage,
enable/disable, etc. We also have some hardware next to our CPUs that
notifies the RPM when we transition into or out of idle/suspend (it's
called an SPM). This is the notification part. Flushing has to do with
batching up multiple RPM sleep set requests and sending them before we
enter idle/suspend.

>
>> Also the active/sleep sets are about more than just on/off state. We may
>> have a situation where the active set voltage (or some other attribute
>> like current, mode, etc.) is different than the sleep set voltage. For
> In a regulator API context if we are talking about suspend it's expected
> that all properties may vary in suspend.
>
>> example, the CPU is supplied by a digital logic regulator that is shared
>> with other digital logic in the SoC (GPU, wifi, etc.). The CPU may
>> require some high voltage, but the GPU only needs some lower voltage.
>> The suspend/idle code relies on the fact that the GPU is voting on the
>> active+sleep regulator while the CPU is voting on the active only
>> regulator so that the RPM can automatically switch between high voltage
>> and low voltage when the CPU notifies the RPM that it's gone idle (or
>> the CPU wakes up).
> Again I'm not following this at all, sorry.

Hopefully it's clear now. If not I can clarify further.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
