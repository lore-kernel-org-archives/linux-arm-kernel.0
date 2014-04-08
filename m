From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Wed, 9 Apr 2014 01:33:06 +0200
Subject: [PATCH] Route keyboard LEDs through the generic LEDs layer.
In-Reply-To: <20140408083940.GA22855@core.coreip.homeip.net>
References: <20140331122323.GC6044@type.bordeaux.inria.fr>
 <20140407021015.GA8518@core.coreip.homeip.net>
 <20140407075423.GZ7179@type.wlan.youpi.perso.aquilenet.fr>
 <20140408083940.GA22855@core.coreip.homeip.net>
Message-ID: <20140408233306.GJ27820@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Dmitry Torokhov, le Tue 08 Apr 2014 01:39:40 -0700, a ?crit :
> It is not about the VT, I am talking about pure input core. If I
> repurpose CapsLock LED for my WiFi indicator I do not want to go into
> other programs and teach them that they should stay away from trying to
> control this LED.

Err, but even without talking about repurposing Capslock LED for WiFi...
How is managed the conflict between the normal capslock behavior and
other programs' action on the underlying input device?  I don't think
this patch does not introduce the problem.

Now you may answer "well, if it could fix the problem along the way it'd
be good".  I'd like to answer "well, this is not my shit" :)

But still, the problem is interesting, and I don't know how to deal
properly with it. More precisely, I don't think we *want* to deal with
it.  Currently, what happens is that there is no priority between what
the VT keyboard events produce and what applications produce, so things
happily mix with strange results as soon as a user tries to combine
both. My concern is:

How to decide which one to prioritize?

Is it just because console-setup happens to repurpose the capslock LED
key that applications should suddenly not have capslock LED control
at all?  That's contradictory with the use case you have given.  That
leads me into believing that we should not try to push a hard rule, and
just let the user manage what accesses it.  We could indeed make the VT
always take priority, but then that would probably break some existing
applications.  Then, is "repurposing a keyboard LED" enough of an action
to be able to decide that applications modifying that LED should be just
ignored?  I doubt it.

> I understand the desire, however I still wonder if we should be
> extending legacy VT given that David wants to move it all to userspace.

I believe I have heard about moving the console implementation to
userland for more that a decide.  Will that really happen any time?
In the meanwhile, we have broken capslock keys on e.g. all Debian and
Ubuntu systems for a couple of years already (because they have adopted
console-setup), and some ARM systems don't have keyboard LEDs at all
without a patched kernel.

Samuel
