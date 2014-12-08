From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 8 Dec 2014 12:55:03 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141208193935.GD11764@sirena.org.uk>
References: <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <20141126233447.GD2872@sonymobile.com>
 <20141127190233.GF7712@sirena.org.uk>
 <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
 <20141128201613.GB7712@sirena.org.uk>
 <5480CEEF.7000906@codeaurora.org>
 <20141208180635.GB3268@sonymobile.com>
 <20141208193935.GD11764@sirena.org.uk>
Message-ID: <20141208205502.GC3268@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 08 Dec 11:39 PST 2014, Mark Brown wrote:

> On Mon, Dec 08, 2014 at 10:06:36AM -0800, Bjorn Andersson wrote:
> > On Thu 04 Dec 13:15 PST 2014, Stephen Boyd wrote:
> > > On 11/28/2014 12:16 PM, Mark Brown wrote:
> 
> > > > I think I now have a reasonable picture of what's going on but wanted to
> > > > confirm that what I'm saying above makes sense.
> 
> > > That's good. Is there any conclusion here? I'm still thinking that
> > > having multiple regulators for the same physical supply is the right
> > > thing to do.
> 
> I'm still not finding it easy to find this tasteful.
> 
> > As I said, the only other idea I've come up with will not cut it for the
> > regulators that need more than enable/disable support when going to sleep.
> 
> > Even if we came up with some model of exposing something similar to the suspend
> > state, we would still need to expose it in a way that we can specify which
> > (active/sleep/both) state in the consumer. Hence in practice we end up with
> > exposing multiple regulators in one way or another.
> 
> Now I'm confused again.  I thought entry and exit was all done
> separately so it was just about saying what should happen if the device
> were to idle?
> 

But how do you actually expose that control to the consumers?

> > I can't help thinking that this would be a problem with the static suspend
> > settings as well; i.e. what is the static suspend state for a regulator that
> > powers a WiFi chip? For me the answer would often be "it's enabled iff the WiFi
> > consumer asks for it" - but maybe it's not supposed to be used for "dynamic"
> > regulators.
> 
> That's what should happen, we just don't currently really support doing
> this configuration dynamically (practically speaking I suspect anyone
> who cares just doesn't have a suspend mode for affected regulators at
> the minute).

What would such configuration look like?

In the suspend case you could introduce an api for setting parameters of the
suspend state, but that means that the individual drivers needs to be written
with awareness of the system state. Our proposal is to use the same api, but
with a different regulator*, but how should that acquired (and expressed in dt).


In our case, as most things change the both state (or active only if no
both/sleep), the standard regulator api would have to affect the both state.
Would we then have a separate api to modify the active state?

Regards,
Bjorn
