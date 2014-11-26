From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Nov 2014 17:02:52 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141125204430.GN7712@sirena.org.uk>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk> <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk> <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
Message-ID: <547526BC.1090202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2014 12:44 PM, Mark Brown wrote:
> On Mon, Nov 24, 2014 at 01:19:47PM -0800, Stephen Boyd wrote:
>> On 11/24/2014 10:16 AM, Mark Brown wrote:
>>> A bit, but I'm afraid I'm still at a loss as to what the problems and
>>> debate are here.  Why is this more complex than the Linux part of the
>>> system just saying what it wants at any given time?  It sounds like that
>>> has some sort of performance issue?
> I'm still quite confused here...

Hm... hopefully it's not getting worse.

>
>> Yes, communicating with the RPM is not that fast. The sleep set could be
>> updated hundreds of times before we go idle and actually switch from the
>> active set to sleep set. One optimization is to buffer the sleep set
>> requests and send them right before we switch to the sleep set. This
>> saves on the messaging overhead for sleep sets that don't matter when
>> we're active by moving the overhead to the idle/suspend path. The hope
>> is to consolidate multiple sleep set requests into one request.
> Right, that's one of the obvious ones.  Though I am a bit mystified as
> to why you're needing to change these settings so often that it's a
> problem - most hardware can do this but generally the configuration when
> idle is fairly constant so it's irrelevant for performance how often we
> set these things, a lot of the time it's going to boil down to I2C
> writes so we're talking really infrequent here.  What's different about
> these systems that means that this stuff needs constant tweaking?

Yes I don't think we're constantly changing the regulators because it 
does boil down to I2C writes or something similar, but we could be 
modifying other resources that the RPM controls more often. For example, 
the RPM controls some clock frequencies that eventually end up being 
some mmio writes. We change these frequencies quite often in response to 
CPU frequency scaling or other DCVS algorithms.

>> I think the problem that Bjorn is trying to come up with a solution for
>> is how to represent the sleep set and active set in the kernel clock and
>> regulator frameworks. You can think of each RPM resource as a regulator
>> supply. Each one of those resources has an active and sleep set. In the
>> downstream vendor kernels we make two regulators for an RPM resource.
>> One regulator for the active set and one regulator for the active +
>> sleep set. We call these 'active only' and 'active + sleep' regulators
> That seems like it's a big abstraction problem.
>
>> respectively. The RPM regulator driver aggregates the active set for
>> both the regulators via a max() operation and sends that as a request to
>> the RPM. The sleep set is the same as the active set for the 'active +
>> sleep' regulator, so we just send whatever the value is that was sent
>> down via the regulator APIs on the 'active + sleep' regulator. The only
>> driver that really cares about the active only regulators is the CPU
>> clock driver. Otherwise drivers are using the active + sleep regulators
>> because their devices don't stop running when the CPU goes to idle/suspend.
> Hang on a minute.  What you're saying seems to be that this isn't really
> about suspend but actually about the normal operating configuration?
> That makes it a bit more understandable why one would change the
> settings a lot, I think what I'm hearing here is that the runtime state
> changes a lot for some reason and the system needs the suspend state to
> track this?

It also matters for idle. Both suspend and idle can cause an RPM 
notification and switch to the sleep set.

>
> I can't help but think that this all sounds like the RPM isn't mapping
> very well onto practical systems and needs revisiting in future
> versions...  for example with what I'm parsing out of the above an
> active+sleep set command or otherwise having the two modes tied together
> for some regulators would make the whole problem go away.

We create the 'active only' regulators for consumers that actually need 
them. From the set of regulators on a board only a couple need this 
treatment. I don't see how tying the two states together via an 
active+sleep set command would make this problem go away for the cases I 
already described before, i.e. CPU wants some voltage and other IO 
devices want another voltage and the CPU doesn't care what the voltage 
is when the CPU is in idle or suspend. Having a combination active + 
sleep set command would be nice. The RPM already sort of supports this 
by allowing you to only modify the active set. If you never modify the 
sleep set, then the RPM just applies whatever is in the active set to 
the sleep set. We can probably go through and figure out what resources 
could get away with only using the active set so we can cut down on 
sleep set requests that are always the same between active and sleep set.

>> Maybe another solution would be to push the problem into the regulator
>> core and educate it about the two different sets. RPM resources would
>> map one-to-one with a regulator and the sleep set and active sets would
>> be selectable via the regulator_get() API or some other consumer mapping
>> method. This would allow consumers to request whatever set they care
>> about and consolidate the aggregation logic that's duplicated at the
>> consumer level and the driver level into the core.
> I think any duplication that's going on sounds like a consequence of
> the way this is currently implemented.  I think based on what I *think*
> you're saying the RPM driver probably ought to be hiding this and adding
> a property which makes the active and sleep sets track each other with
> normal suspend mode control otherwise.  That could potentially be done
> in the core, though the tracking would be substantial surgery.

Sorry I don't follow this part. It's about more than suspend, we also 
care about idle. I agree that pushing the concept of active vs. sleep 
into the framework is substantial.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
