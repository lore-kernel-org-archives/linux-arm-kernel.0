From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Nov 2014 20:44:30 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <5473A0F3.6080405@codeaurora.org>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
Message-ID: <20141125204430.GN7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 01:19:47PM -0800, Stephen Boyd wrote:
> On 11/24/2014 10:16 AM, Mark Brown wrote:

> > A bit, but I'm afraid I'm still at a loss as to what the problems and
> > debate are here.  Why is this more complex than the Linux part of the
> > system just saying what it wants at any given time?  It sounds like that
> > has some sort of performance issue?

I'm still quite confused here...

> Yes, communicating with the RPM is not that fast. The sleep set could be
> updated hundreds of times before we go idle and actually switch from the
> active set to sleep set. One optimization is to buffer the sleep set
> requests and send them right before we switch to the sleep set. This
> saves on the messaging overhead for sleep sets that don't matter when
> we're active by moving the overhead to the idle/suspend path. The hope
> is to consolidate multiple sleep set requests into one request.

Right, that's one of the obvious ones.  Though I am a bit mystified as
to why you're needing to change these settings so often that it's a
problem - most hardware can do this but generally the configuration when
idle is fairly constant so it's irrelevant for performance how often we
set these things, a lot of the time it's going to boil down to I2C
writes so we're talking really infrequent here.  What's different about
these systems that means that this stuff needs constant tweaking?

> I think the problem that Bjorn is trying to come up with a solution for
> is how to represent the sleep set and active set in the kernel clock and
> regulator frameworks. You can think of each RPM resource as a regulator
> supply. Each one of those resources has an active and sleep set. In the
> downstream vendor kernels we make two regulators for an RPM resource.
> One regulator for the active set and one regulator for the active +
> sleep set. We call these 'active only' and 'active + sleep' regulators

That seems like it's a big abstraction problem.

> respectively. The RPM regulator driver aggregates the active set for
> both the regulators via a max() operation and sends that as a request to
> the RPM. The sleep set is the same as the active set for the 'active +
> sleep' regulator, so we just send whatever the value is that was sent
> down via the regulator APIs on the 'active + sleep' regulator. The only
> driver that really cares about the active only regulators is the CPU
> clock driver. Otherwise drivers are using the active + sleep regulators
> because their devices don't stop running when the CPU goes to idle/suspend.

Hang on a minute.  What you're saying seems to be that this isn't really
about suspend but actually about the normal operating configuration?
That makes it a bit more understandable why one would change the
settings a lot, I think what I'm hearing here is that the runtime state
changes a lot for some reason and the system needs the suspend state to
track this?

I can't help but think that this all sounds like the RPM isn't mapping
very well onto practical systems and needs revisiting in future
versions...  for example with what I'm parsing out of the above an
active+sleep set command or otherwise having the two modes tied together
for some regulators would make the whole problem go away.

> Maybe another solution would be to push the problem into the regulator
> core and educate it about the two different sets. RPM resources would
> map one-to-one with a regulator and the sleep set and active sets would
> be selectable via the regulator_get() API or some other consumer mapping
> method. This would allow consumers to request whatever set they care
> about and consolidate the aggregation logic that's duplicated at the
> consumer level and the driver level into the core.

I think any duplication that's going on sounds like a consequence of
the way this is currently implemented.  I think based on what I *think*
you're saying the RPM driver probably ought to be hiding this and adding
a property which makes the active and sleep sets track each other with
normal suspend mode control otherwise.  That could potentially be done
in the core, though the tracking would be substantial surgery.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/1821dd83/attachment.sig>
