From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Nov 2014 23:27:38 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <546FC674.1070005@codeaurora.org>
References: <546FC674.1070005@codeaurora.org>
Message-ID: <20141121232738.GP3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 03:10:44PM -0800, Stephen Boyd wrote:
> On 11/10/2014 02:52 PM, Bjorn Andersson wrote:

I don't seem to have been CCed on earlier messages here, or perhaps the
lack of obvious relevance (like mention of regulators) caused me not to
read the mails so I'm missing a *lot* of context.

> > Further more, these resources are shared
> > with peripherals in the system; e.g. LDO12 on PM8941 is used to clock the CPU
> > and WiFi/BT PLLs as well as providing power to the display in our devices. So
> > the suspend functionality in the regulator framework doesn't cut it.

> Furthermore, we can trigger a transition to the sleep set during idle
> paths so suspend definitely won't cut it.

Honestly I'm not really sure what support the above is talking about...
the regulator API has support for setting the configuration the
regulator has when we are in suspend but it doesn't have any real
support for entering or leaving such a mode which appears to be what is
being discussed.

> So the CPU really wants to only be voting for the HFPLL regulator
> supplies in the active set. This way, if we're not using the HFPLLs
> (i.e. the CPUs are all running off the global PLL), then we can disable
> the regulator in the active set (RPM code only caches sleep set so we
> won't be doing unnecessary flushes in the idle/suspend path). The clock
> driver will make sure to turn off the HFPLLs before we go into a sleep
> state that would trigger a switch from active to sleep set (commonly
> referred to as RPM notification). It very well could be that there are
> other consumers of the same regulator, but that doesn't matter to the
> CPU clock driver because it only cares about the active set. Now you may
> ask why can't the CPU clock driver disable the regulator when the HFPLL
> is disabled? We don't do that in this case because a) it causes more RPM
> communication overhead and b) we will be in atomic context when the
> HFPLL is disabled during idle/suspend and the regulator APIs are
> sleeping calls. In the non-idle/suspend path we will disable the regulator.

I'm afraid the above is making very little sense to me.  What is
"voting" and how is it different to "enabling", "notification" or
"flushing"?

> Also the active/sleep sets are about more than just on/off state. We may
> have a situation where the active set voltage (or some other attribute
> like current, mode, etc.) is different than the sleep set voltage. For

In a regulator API context if we are talking about suspend it's expected
that all properties may vary in suspend.

> example, the CPU is supplied by a digital logic regulator that is shared
> with other digital logic in the SoC (GPU, wifi, etc.). The CPU may
> require some high voltage, but the GPU only needs some lower voltage.
> The suspend/idle code relies on the fact that the GPU is voting on the
> active+sleep regulator while the CPU is voting on the active only
> regulator so that the RPM can automatically switch between high voltage
> and low voltage when the CPU notifies the RPM that it's gone idle (or
> the CPU wakes up).

Again I'm not following this at all, sorry.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/baed5af0/attachment.sig>
