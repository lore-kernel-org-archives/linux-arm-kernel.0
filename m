From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 26 Nov 2014 15:34:47 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141125204430.GN7712@sirena.org.uk>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
Message-ID: <20141126233447.GD2872@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 25 Nov 12:44 PST 2014, Mark Brown wrote:

> On Mon, Nov 24, 2014 at 01:19:47PM -0800, Stephen Boyd wrote:
> > On 11/24/2014 10:16 AM, Mark Brown wrote:

[..]

> > respectively. The RPM regulator driver aggregates the active set for
> > both the regulators via a max() operation and sends that as a request to
> > the RPM. The sleep set is the same as the active set for the 'active +
> > sleep' regulator, so we just send whatever the value is that was sent
> > down via the regulator APIs on the 'active + sleep' regulator. The only
> > driver that really cares about the active only regulators is the CPU
> > clock driver. Otherwise drivers are using the active + sleep regulators
> > because their devices don't stop running when the CPU goes to idle/suspend.
> 
> Hang on a minute.  What you're saying seems to be that this isn't really
> about suspend but actually about the normal operating configuration?
> That makes it a bit more understandable why one would change the
> settings a lot, I think what I'm hearing here is that the runtime state
> changes a lot for some reason and the system needs the suspend state to
> track this?
> 

I think it's important that we clarify that we have 2 (somewhat) diffrent
problem on the table here:

Problem 1:
Regulators are shared between CPU PLLs and other peripherals and when we take
the cpu to idle we need a way to let go of the CPU PLL "vote" on the regulator.

In the case of the CPU being the only consumer I think we've come down to the
problems being:
* we're in atomic context
* we don't want to waste the time of making sending out the request
* we have hardware support for this and we want to use it(?)

In the case of us having other active consumers (e.g. GPU, display or some
peripherals) the voltage range or operating mode specified by the cpufreq
driver might be suboptimal when we remove the cpu.

I assume we don't want to handle this explicitly due to the same reasons as
above(?)


Problem 2:
As we're implementing a solution for problem 1 we end up with a set of writes
to the sleep state that are superfluous. The codeaurora solution for this is to
buffer any writes to the sleep state and right before putting the cpu into idle
state there's a direct call going, that flushes the buffered writes.

This is "only" and optimization and I think the tricky parts are how to
actually trigger the flush from the cpuidle driver and how to handle the smd
communication in a sane way.

> I can't help but think that this all sounds like the RPM isn't mapping
> very well onto practical systems and needs revisiting in future
> versions...  for example with what I'm parsing out of the above an
> active+sleep set command or otherwise having the two modes tied together
> for some regulators would make the whole problem go away.
> 

As Stephen answered for regulators that only have the "both state" only one
write is needed.

And if I read the docs correctly there are 4 regulators that needs this special
handling and 29 that works just as you normally would expect.

> > Maybe another solution would be to push the problem into the regulator
> > core and educate it about the two different sets. RPM resources would
> > map one-to-one with a regulator and the sleep set and active sets would
> > be selectable via the regulator_get() API or some other consumer mapping
> > method. This would allow consumers to request whatever set they care
> > about and consolidate the aggregation logic that's duplicated at the
> > consumer level and the driver level into the core.
> 
> I think any duplication that's going on sounds like a consequence of
> the way this is currently implemented.  I think based on what I *think*
> you're saying the RPM driver probably ought to be hiding this and adding
> a property which makes the active and sleep sets track each other with
> normal suspend mode control otherwise.  That could potentially be done
> in the core, though the tracking would be substantial surgery.

I think we should start off by hiding this in the driver, if others come
forward needing something similar we can look at how to integrate parts of it
into the core.

Regards,
Bjorn
