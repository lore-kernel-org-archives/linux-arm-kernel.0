From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 19:02:33 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141126233447.GD2872@sonymobile.com>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <20141126233447.GD2872@sonymobile.com>
Message-ID: <20141127190233.GF7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 03:34:47PM -0800, Bjorn Andersson wrote:

> Problem 1:
> Regulators are shared between CPU PLLs and other peripherals and when we take
> the cpu to idle we need a way to let go of the CPU PLL "vote" on the regulator.

> In the case of the CPU being the only consumer I think we've come down to the
> problems being:
> * we're in atomic context

That shouldn't be an issue, we can do something like what we've got for
regmap and allow regulators to replace their mutexes with spinlocks
(users and drivers will need to be careful they don't do expensive
things, plus we wamy want to look at optimizing the core, but that's
true anyway).

> * we don't want to waste the time of making sending out the request
> * we have hardware support for this and we want to use it(?)

I'm still hazy on what that actually means.  I thought the CPU case was
one of the big ones where you *did* want to act on the configuration
changes?

> In the case of us having other active consumers (e.g. GPU, display or some
> peripherals) the voltage range or operating mode specified by the cpufreq
> driver might be suboptimal when we remove the cpu.

I don't understand.  Why is the other consumer asking for something it
doesn't need itself?

> Problem 2:
> As we're implementing a solution for problem 1 we end up with a set of writes
> to the sleep state that are superfluous. The codeaurora solution for this is to
> buffer any writes to the sleep state and right before putting the cpu into idle
> state there's a direct call going, that flushes the buffered writes.

> This is "only" and optimization and I think the tricky parts are how to
> actually trigger the flush from the cpuidle driver and how to handle the smd
> communication in a sane way.

That seems like a very obvious thing to do.

> > I think any duplication that's going on sounds like a consequence of
> > the way this is currently implemented.  I think based on what I *think*
> > you're saying the RPM driver probably ought to be hiding this and adding
> > a property which makes the active and sleep sets track each other with
> > normal suspend mode control otherwise.  That could potentially be done
> > in the core, though the tracking would be substantial surgery.

> I think we should start off by hiding this in the driver, if others come
> forward needing something similar we can look at how to integrate parts of it
> into the core.

If you're hiding it in the driver make sure it's *hidden* in the driver
- exporting duplicate regulators doesn't sound like hiding to me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/afd860fd/attachment.sig>
