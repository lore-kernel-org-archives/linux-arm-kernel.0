From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 May 2014 12:31:04 -0400
Subject: [PATCHv2 1/4] of: make of_update_property() usable earlier in
 the boot process
In-Reply-To: <20140513175404.319d067d@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399975839-5311-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqLNnLjeo2tM=z5bcn4DJD_5-uFRGkk6wAWnvGZyo9Y7pg@mail.gmail.com>
 <20140513163026.18a0fa61@free-electrons.com>
 <20140513153006.GC27822@titan.lakedaemon.net>
 <20140513175404.319d067d@free-electrons.com>
Message-ID: <20140513163104.GE27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 05:54:04PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 13 May 2014 11:30:06 -0400, Jason Cooper wrote:
> 
> > > Well, I guess it's a per-maintainer choice:
> > > 
> > > git log | grep "^Fixes:"
> > > 
> > >     Fixes: 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add thermal quirk for the Armada 375 DB board')
> > 
> > Well, just because the maintainer is an idiot and didn't catch it isn't
> > an excuse to continue the behavior. ;-)
> 
> Yes, no problem :)
> 
> > >     Fixes: 54397d85349f ("ARM: kirkwood: Relocate PCIe device tree nodes")
> > >     Fixes: a7d4f81821f7 ('ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board')
> > >     Fixes: b484ff42df47 ('ARM: mvebu: Add support for NOR flash device on Armada XP-DB board')
> > >     Fixes: c971ff185f64 ("leds: leds-pwm: Defer led_pwm_set() if PWM can sleep")
> > >     Fixes: abccd00f8af2 ('btrfs: Fix 32/64-bit problem with BTRFS_SET_RECEIVED_SUBVOL ioctl')
> > >     Fixes: ee1e0994ab1bd (regulator: s5m8767: Use GPIO for controlling Buck9/eMMC)
> > >     Fixes: 652ed95d5fa6 (cpufreq: introduce cpufreq_generic_get() routine)
> > > 
> > > Somewhat inconsistent :-)
> > 
> > Yeah, I can go either way on the single quotes/double quotes.  The
> > 12-character hash definitely increases readability, though.
> 
> I must say I never understood the logic here. We used to use 8 digit
> hashes, and then we had collisions. So it means that if we look at the
> Git history now, some of these 8 digit hashes no longer uniquely
> identify a commit.

iirc, it was 7, and when git saw a collision, it stepped out to eight.
eg during a git log --oneline.

> To fix this up, we moved to use 12 digit hashes. But that's just
> pushing the problem a bit further away, no? There will be some
> collision at some point, and therefore in the future 652ed95d5fa6 may
> no longer be a unique identifier for the "cpufreq: introduce
> cpufreq_generic_get() routine" commit, and therefore people reading the
> Git history 3 or 5 years from now will see non-unique identifiers in
> 'Fixes:' fields.

This is where the logic is flawed.  Hypothetically, 5 years later,
652ed95d5fa6 is no longer unique, but the patch subject line *is* unique
among the set that matches 652ed95d5fa6.

> To me, it would make a lot more sense to use full hashes. I don't
> really see how it decreases readability, and it's the most future proof
> solution we have (knowing that of course, collisions are still
> theoretically possible).

If there were a full sha1 collision between two different, legitimate
patches, they would still have different subject lines.  Since the Fixes
tag works in the event of either sort of collision (12, full), may as
well use 12.

Not to mention, since there are no collisions yet, you can be reasonably
certain that of the two commits matching 652ed95d5fa6, it's the one
that came before the commit containing the Fixes tag. :)

thx,

Jason.
