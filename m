From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Nov 2014 13:19:47 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141124181614.GT7712@sirena.org.uk>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk> <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
Message-ID: <5473A0F3.6080405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 10:16 AM, Mark Brown wrote:
> On Fri, Nov 21, 2014 at 03:43:54PM -0800, Stephen Boyd wrote:
>> On 11/21/2014 03:27 PM, Mark Brown wrote:
>>> I'm afraid the above is making very little sense to me.  What is
>>> "voting" and how is it different to "enabling", "notification" or
>>> "flushing"?
>> The regulators are shared between multiple "masters" in the SoC. So the
>> CPUs that are running linux only "vote" on attributes of regulators and
>> then another processor that isn't running linux (called RPM) aggregates
>> the request from Linux along with other "masters" like wifi, modem, etc.
>> and then changes something for that regulator like voltage,
>> enable/disable, etc. We also have some hardware next to our CPUs that
>> notifies the RPM when we transition into or out of idle/suspend (it's
>> called an SPM). This is the notification part. Flushing has to do with
>> batching up multiple RPM sleep set requests and sending them before we
>> enter idle/suspend.
> ...
>
>> Hopefully it's clear now. If not I can clarify further.
> A bit, but I'm afraid I'm still at a loss as to what the problems and
> debate are here.  Why is this more complex than the Linux part of the
> system just saying what it wants at any given time?  It sounds like that
> has some sort of performance issue?

Yes, communicating with the RPM is not that fast. The sleep set could be
updated hundreds of times before we go idle and actually switch from the
active set to sleep set. One optimization is to buffer the sleep set
requests and send them right before we switch to the sleep set. This
saves on the messaging overhead for sleep sets that don't matter when
we're active by moving the overhead to the idle/suspend path. The hope
is to consolidate multiple sleep set requests into one request.

I think the problem that Bjorn is trying to come up with a solution for
is how to represent the sleep set and active set in the kernel clock and
regulator frameworks. You can think of each RPM resource as a regulator
supply. Each one of those resources has an active and sleep set. In the
downstream vendor kernels we make two regulators for an RPM resource.
One regulator for the active set and one regulator for the active +
sleep set. We call these 'active only' and 'active + sleep' regulators
respectively. The RPM regulator driver aggregates the active set for
both the regulators via a max() operation and sends that as a request to
the RPM. The sleep set is the same as the active set for the 'active +
sleep' regulator, so we just send whatever the value is that was sent
down via the regulator APIs on the 'active + sleep' regulator. The only
driver that really cares about the active only regulators is the CPU
clock driver. Otherwise drivers are using the active + sleep regulators
because their devices don't stop running when the CPU goes to idle/suspend.

Maybe another solution would be to push the problem into the regulator
core and educate it about the two different sets. RPM resources would
map one-to-one with a regulator and the sleep set and active sets would
be selectable via the regulator_get() API or some other consumer mapping
method. This would allow consumers to request whatever set they care
about and consolidate the aggregation logic that's duplicated at the
consumer level and the driver level into the core.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
