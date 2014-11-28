From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Nov 2014 20:16:13 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <20141126233447.GD2872@sonymobile.com>
 <20141127190233.GF7712@sirena.org.uk>
 <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
Message-ID: <20141128201613.GB7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 11:42:41AM -0800, Bjorn Andersson wrote:
> On Thu, Nov 27, 2014 at 11:02 AM, Mark Brown <broonie@kernel.org> wrote:

> >> * we don't want to waste the time of making sending out the request
> >> * we have hardware support for this and we want to use it(?)

> > I'm still hazy on what that actually means.  I thought the CPU case was
> > one of the big ones where you *did* want to act on the configuration
> > changes?

> By utilising the hardware support for switching between active and
> sleep state (and having the cpu only affecting the active state) we
> can do this asynchronously, while being in wfi.

Hrm, right.  This is starting to make sense.  So what we're saying here
is roughly that you want to use a separate suspend-like mode (the extra
set of registers for the low power mode mode) but are entering it
without actually suspending the whole system?

> >> In the case of us having other active consumers (e.g. GPU, display or some
> >> peripherals) the voltage range or operating mode specified by the cpufreq
> >> driver might be suboptimal when we remove the cpu.

> > I don't understand.  Why is the other consumer asking for something it
> > doesn't need itself?

> I don't have the actual numbers, but we have a situation that looks like this:
> gpu driver does regulator_set_voltage(.5V, 1V);
> cpufreq driver does regulator_set_voltage(1V,1V);

> The regulator framework will make the regulator tick at 1V

> Upon going to sleep the cpuidle driver will, through the hardware
> support, make the regulator tick at .5V. Before returning the cpu from
> idle the hardware will make the regulator tick at 1V again.

So the regulator framework should be fine if the CPU regulator
constraint was disabled while the CPU consumer was disabled (modulo the
performance issue)?

> > If you're hiding it in the driver make sure it's *hidden* in the driver
> > - exporting duplicate regulators doesn't sound like hiding to me.

> This is the problem at hand, we have not found any way to actually
> hide this in the driver as the two modes depend on the consumer and
> not the aggregated values we get out of the regulator framework.

> Or rather, my proposal would do that, but that will not be able to
> handle the case when there's different voltages in the two states. It
> would only take care of the enable/disable case.

So, I think something along the lines of suspend mode ought to be able
to handle this.  What we need is a way of accelerating the entry and
exit, right?

> The exposure of multiple regulators moves the problem to the
> devicetree, making sure to map the consumers to the right
> state/regulator. But it should only be the cpu (in its various forms)
> that ever consume the active only regulator.

He said hopefully...  :)

I think I now have a reasonable picture of what's going on but wanted to
confirm that what I'm saying above makes sense.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/8704411b/attachment.sig>
