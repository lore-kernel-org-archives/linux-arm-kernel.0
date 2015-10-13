From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Oct 2015 10:35:15 -0600
Subject: [PATCH 37/37] ARM: dts: tegra20-ventana: Fix regulator enable
 GPIO polarity
In-Reply-To: <9351580.BEfKjdvstm@avalon>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1444684386-17094-38-git-send-email-laurent.pinchart@ideasonboard.com>
 <561C2773.5090408@wwwdotorg.org> <9351580.BEfKjdvstm@avalon>
Message-ID: <561D32C3.6010907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 04:24 PM, Laurent Pinchart wrote:
> Hi Stephen,
>
> On Monday 12 October 2015 15:34:43 Stephen Warren wrote:
>> On 10/12/2015 03:13 PM, Laurent Pinchart wrote:
>>> The enable GPIO is active low,
>>
>> It'd be good to mention a justification for that statement in the
>> patches, since the cover letter isn't going to be checked in.
>>
>>> but is flagged as active high in the gpio
>>> property. As the gpio property flags are currently unused by the driver
>>> this doesn't cause any issue for now, but will break later if the driver
>>> starts making use of the flags. Fix it.
>>
>> IIRC the history here was that for some bizarre reason not all GPIO
>> bindings contained an active-high/low flag and there was resistance to
>> extending them in a backwards compatible way. So the regulator binding
>> needed the separate property to represent this. For bindings that did
>> have the flag, we had to set the GPIO flag to active-high, so that if
>> anything started honoring the GPIO flags (e.g. I thikn the gpiod API
>> does today, but the legacy GPIO API doesn't), we wouldn't apply both
>> "active low indicators", and end up driving an active-high signal, and
>> breaking things.
>>
>> So while this change is logically correct when read in isolation (and
>> for Harmony, Seaboard, and Ventana I verified that these regulators do
>> use an active-low GPIO), I worry that making it makes mistakes likely
>> later. How would we mitigate that?
>
> That's a very good point. Is the resistance to move to the standard GPIO
> active low/high flags still present, or is it now only history ?

This was a few years back, so I don't remember the details; it might 
have been as simple as "some bindings don't already have GPIO flags, and 
I'd rather get GPIO regulators implemented first before thinking about 
fixing that" or it could have been "some bindings don't already have 
GPIO flags, and there's ${some reason} why it's not possible to solve 
that in a backwards-compatible fashion" (recalling that DT bindings must 
evolve in a backwards-compatible fashion since they're an ABI). 
Unfortunately, you'd have to read through the mailing list posts related 
to the patches that defined the GPIO regulator bindings or added the 
nodes to DT.

> In other
> words, could we aim for using GPIO flags as the primary method to specify
> polarities, and fall back to the custom properties for backward compatibility
> (and possibly for GPIO controllers that don't support the flags) ?

I don't think we can switch to using GPIO flags, without changing the 
compatible values for the relevant DT nodes.

For one, we'd need some way of actively marking the nodes to say whether 
they are written to expect that the GPIO flags or the other properties 
be used. It's not possible in all cases to determine this automatically. 
For example, if enable-active-high it's fairly clear we should honor 
this flag, yet if it's missing does that mean the GPIO is active-low or 
simply that the node was written to expect that the GPIO flags be used 
instead?

Also, old DTs must work with new kernels (and preferably also, new DTs 
must work with old kernels). If the GPIO flags are wrong in current DTs, 
then we can't use them. Of course, there's an argument that the 
backwards-compatibility constraint doesn't apply to buggy DTs, just to 
correctly written DTs. However, if we deliberately chose to make all 
regulator GPIO flags ACTIVE_HIGH, then the current DTs aren't buggy.
