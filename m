From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 31 Mar 2012 11:19:54 +0100
Subject: [PATCH v6 1/5] Extcon (external connector): import Android's
 switch class and modify.
In-Reply-To: <CACSP8SjhOZcXZa2hCNsH8zS+hm8X-i9uNm50UH=_VwOV=BJGmA@mail.gmail.com>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-2-git-send-email-myungjoo.ham@samsung.com>
 <20120309124119.GV3273@opensource.wolfsonmicro.com>
 <CACSP8ShU5tu=9N53PtYMLyFVFMS9whNRhMvu7nu8rBoPuVCy+Q@mail.gmail.com>
 <20120330100742.GB21950@opensource.wolfsonmicro.com>
 <CACSP8SjhOZcXZa2hCNsH8zS+hm8X-i9uNm50UH=_VwOV=BJGmA@mail.gmail.com>
Message-ID: <20120331101953.GA3163@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 10:29:27AM -0700, Erik Gilling wrote:

> I'm also not in favor of having functionality conditionally compiled
> based on CONFIG_ANDROID.  If fact, going through the patch stack
> there's much more that changes the ABI from the switch driver than
> just the name.  Android asumes that there is a single "switch" for
> each logical entity (called cable types in extcon) each with a binary
> state (0,1).  Here things have changed to have a single extcon
> instance that can have a bitmask of states which are sent as strings
> in the uevent.

The binary status thing isn't true for the original Android switch API,
at least not in all cases - for headsets it's a tristate indicating if
there's nothing, a headphone or headset plugged in.  This does wind up
being a bitmask because the numbers are 0, 1 and 2 but it isn't really
clear to me if this is intentional or just an effect of counting.

> As it stands, this patch does not solve the cases where we use switch
> today and we'll probably continue to carry the switch driver in the
> common android tree.  If, instead, we got rid of the idea of multiple
> states and mutual exclusivity and relied on the driver that uses
> extcon to have multiple instances for each logical entity and deal
> with mutual exclusion itself, we'd have a driver that would be pretty
> easy to support in android.

What's the advantage in not having information about mutual exclusion in
the core, and why would a userspace that isn't interested in this care?  
It seems like this could be used by userspace to do interesting things,
and I rather suspect you'll find some vendors have added features along
those lines in their Android devices.  For example, having different
configurations for desk docks and car docks even if both end up
connecting the same things up.

Even if the userspace ABI doesn't expose the information it seems
sensible to factor out the code for handling this into the core so
there's less work to do in individual drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120331/426a6350/attachment.sig>
