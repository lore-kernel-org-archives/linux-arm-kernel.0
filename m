From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 27 Nov 2014 11:42:41 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141127190233.GF7712@sirena.org.uk>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <20141126233447.GD2872@sonymobile.com>
 <20141127190233.GF7712@sirena.org.uk>
Message-ID: <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 11:02 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Nov 26, 2014 at 03:34:47PM -0800, Bjorn Andersson wrote:
>
>> Problem 1:
>> Regulators are shared between CPU PLLs and other peripherals and when we take
>> the cpu to idle we need a way to let go of the CPU PLL "vote" on the regulator.
>
>> In the case of the CPU being the only consumer I think we've come down to the
>> problems being:
>> * we're in atomic context
>
> That shouldn't be an issue, we can do something like what we've got for
> regmap and allow regulators to replace their mutexes with spinlocks
> (users and drivers will need to be careful they don't do expensive
> things, plus we wamy want to look at optimizing the core, but that's
> true anyway).
>

If I understand Stephen correctly, this is basically what would happen
when we go to suspend (take the CPUs off the individual PLLs and
releasing the regulators), but for going in and out of _idle_ this is
too costly and we want to utilise the hardware assist for this.

>> * we don't want to waste the time of making sending out the request
>> * we have hardware support for this and we want to use it(?)
>
> I'm still hazy on what that actually means.  I thought the CPU case was
> one of the big ones where you *did* want to act on the configuration
> changes?
>

By utilising the hardware support for switching between active and
sleep state (and having the cpu only affecting the active state) we
can do this asynchronously, while being in wfi.

>> In the case of us having other active consumers (e.g. GPU, display or some
>> peripherals) the voltage range or operating mode specified by the cpufreq
>> driver might be suboptimal when we remove the cpu.
>
> I don't understand.  Why is the other consumer asking for something it
> doesn't need itself?
>

I don't have the actual numbers, but we have a situation that looks like this:
gpu driver does regulator_set_voltage(.5V, 1V);
cpufreq driver does regulator_set_voltage(1V,1V);

The regulator framework will make the regulator tick at 1V

Upon going to sleep the cpuidle driver will, through the hardware
support, make the regulator tick at .5V. Before returning the cpu from
idle the hardware will make the regulator tick at 1V again.

[..]

>> > I think any duplication that's going on sounds like a consequence of
>> > the way this is currently implemented.  I think based on what I *think*
>> > you're saying the RPM driver probably ought to be hiding this and adding
>> > a property which makes the active and sleep sets track each other with
>> > normal suspend mode control otherwise.  That could potentially be done
>> > in the core, though the tracking would be substantial surgery.
>
>> I think we should start off by hiding this in the driver, if others come
>> forward needing something similar we can look at how to integrate parts of it
>> into the core.
>
> If you're hiding it in the driver make sure it's *hidden* in the driver
> - exporting duplicate regulators doesn't sound like hiding to me.
>

This is the problem at hand, we have not found any way to actually
hide this in the driver as the two modes depend on the consumer and
not the aggregated values we get out of the regulator framework.

Or rather, my proposal would do that, but that will not be able to
handle the case when there's different voltages in the two states. It
would only take care of the enable/disable case.


The exposure of multiple regulators moves the problem to the
devicetree, making sure to map the consumers to the right
state/regulator. But it should only be the cpu (in its various forms)
that ever consume the active only regulator.

Regards,
Bjorn
