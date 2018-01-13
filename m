From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Jan 2018 14:13:57 +0000
Subject: Headless chicken mode over recent exploits
Message-ID: <20180113141357.GA17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I would like to bring to people's attention that there seems to be a
lot of "headless chicken mode" going on with the current set of issues.
I guess vendors have to be seen to be doing _something_ even if what
they're doing has no technical reasoning what so ever.

I've recently had the following pointed out to me:

  "To provide additional protection, the update for CVE-2017-13218
   included in this bulletin reduces access to high-precision timers,
   which helps limits side channel attacks (such as CVE-2017-5715,
   CVE-2017-5753, and CVE-2017-5754) of all known variants of ARM
   processors."

CVE-2017-13218 reads:

  "Access to CNTVCT_EL0 could be used for side channel attacks. This
   could lead to local information disclosure with no additional
   execution privileges needed. User interaction is not needed for
   exploitation.
   Product: Android. Versions: Android kernel. Android ID: A-68266545."

I'm worried about this.

If the processor that you're trying to exploit is SMP, then this kind
of mitigation does nothing to mitigate the attack - all you then need is
to spawn a separate thread that spends all its time incrementing a local
variable.  You then have something that is almost a cycle counter.

I have a working implementation of this exact kind of time source which
several people have over the last week independently verified allows
programs such as "spectre.c" to still read the "The Magic Words are
Squeamish Ossifrage." string, thereby proving that the side-channel
remains very much usable with no help from any hardware timer.

However, the same is still possible with two processes with a shared
mapping, so the need for multiple threads is not necessary - just two
or more CPUs.

So my conclusion is the above CVE is basically misleading - it does
nothing to mitigate against these attacks, and I worry that it will
lead people to conclude (incorrectly) that disabling access to the
ARM architected timer is sufficient to stop the attacks.  It isn't,
and so its pointless to do so.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
