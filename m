From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 04 Dec 2014 13:15:27 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141128201613.GB7712@sirena.org.uk>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk> <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk> <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk> <20141126233447.GD2872@sonymobile.com>
 <20141127190233.GF7712@sirena.org.uk>
 <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
 <20141128201613.GB7712@sirena.org.uk>
Message-ID: <5480CEEF.7000906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2014 12:16 PM, Mark Brown wrote:
> On Thu, Nov 27, 2014 at 11:42:41AM -0800, Bjorn Andersson wrote:
>> On Thu, Nov 27, 2014 at 11:02 AM, Mark Brown <broonie@kernel.org> wrote:
>>>> * we don't want to waste the time of making sending out the request
>>>> * we have hardware support for this and we want to use it(?)
>>> I'm still hazy on what that actually means.  I thought the CPU case was
>>> one of the big ones where you *did* want to act on the configuration
>>> changes?
>> By utilising the hardware support for switching between active and
>> sleep state (and having the cpu only affecting the active state) we
>> can do this asynchronously, while being in wfi.
> Hrm, right.  This is starting to make sense.  So what we're saying here
> is roughly that you want to use a separate suspend-like mode (the extra
> set of registers for the low power mode mode) but are entering it
> without actually suspending the whole system?

For the idle path, yes. We also want to do the same sort of thing on the
system suspend path.

>
>>>> In the case of us having other active consumers (e.g. GPU, display or some
>>>> peripherals) the voltage range or operating mode specified by the cpufreq
>>>> driver might be suboptimal when we remove the cpu.
>>> I don't understand.  Why is the other consumer asking for something it
>>> doesn't need itself?
>> I don't have the actual numbers, but we have a situation that looks like this:
>> gpu driver does regulator_set_voltage(.5V, 1V);
>> cpufreq driver does regulator_set_voltage(1V,1V);
>> The regulator framework will make the regulator tick at 1V
>> Upon going to sleep the cpuidle driver will, through the hardware
>> support, make the regulator tick at .5V. Before returning the cpu from
>> idle the hardware will make the regulator tick at 1V again.
> So the regulator framework should be fine if the CPU regulator
> constraint was disabled while the CPU consumer was disabled (modulo the
> performance issue)?

The CPU regulator consumer won't be disabled through any software
mechanism. It will stay enabled in software and when we execute wfi the
hardware will drop that consumers request because it was only requesting
in the active set.

>
>>> If you're hiding it in the driver make sure it's *hidden* in the driver
>>> - exporting duplicate regulators doesn't sound like hiding to me.
>> This is the problem at hand, we have not found any way to actually
>> hide this in the driver as the two modes depend on the consumer and
>> not the aggregated values we get out of the regulator framework.
>> Or rather, my proposal would do that, but that will not be able to
>> handle the case when there's different voltages in the two states. It
>> would only take care of the enable/disable case.
> So, I think something along the lines of suspend mode ought to be able
> to handle this.  What we need is a way of accelerating the entry and
> exit, right?
>
>> The exposure of multiple regulators moves the problem to the
>> devicetree, making sure to map the consumers to the right
>> state/regulator. But it should only be the cpu (in its various forms)
>> that ever consume the active only regulator.
> He said hopefully...  :)
>
> I think I now have a reasonable picture of what's going on but wanted to
> confirm that what I'm saying above makes sense.

That's good. Is there any conclusion here? I'm still thinking that
having multiple regulators for the same physical supply is the right
thing to do.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
