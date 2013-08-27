From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 Aug 2013 16:19:58 +0200
Subject: [RFC v1 0/5] ARM: Initial support for Marvell Armada 1500
In-Reply-To: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130827161958.5e71890d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Fri, 16 Aug 2013 21:41:33 +0200, Sebastian Hesselbarth wrote:
> This is a RFC adding initial support for the Marvell Armada 1500
> (88DE3100) found on various consumer devices (Chromecast, GoogleTV).
> 
> Actually, it is a two-fold RFC also raising discussions on mach-mvebu
> cleanup roadmap to allow other SoCs to hop into it. While mach-mvebu
> originally was created to add support for Armada 370/XP and merge
> existing Marvell Orion familiy into it, I am not so sure about
> Armada 1500 fits that well (the mbus has gone!).

After talking a bit with engineers within Marvell that work on this
SoC, I'm inclined to think that using mach-mvebu for this family of SoC
is not a good idea.

The reasons are:

 * This family of SoC is architecturally completely different from the
   family of Orion SoC: they use completely different hardware blocks
   (i.e none of the plat-orion stuff would apply, and none of the
   Orion device drivers would be useful), they don't use the MBus
   mechanism, etc. They are really a different family of SoC, almost as
   if they were coming from a different SoC company.

 * The SMP and power management code, as well as all the "glue"
   platform code that typically sits in mach-<foo> is going to be
   substantially, if not completely different from the one in
   mach-mvebu. I already believe doing all the "glue" platform code in
   mach-mvebu for all of Kirkwood, Dove, 370/XP, Orion5x and MV78xx0 is
   going to be a challenge, so I'd suggest to not add to this challenge
   a completely separate family of SOCs.

The codename used for those Armada 1500 SOCs is "Berlin", so a name
like mach-berlin, or mach-mvberlin (if we want to keep 'mv' to identify
the founder) seems like a good name.

Also, to help us understand the organization of the family of SOCs, I
asked a few informations to Marvell, and here is what I could collect:

"""
BGxname		CPU core	codename	L2 cache controller	internal name
BG2		PJ4B		Armada1500	Tauros3			MV88DE3100
BG2-CT		Cortex-A9	N/A		PL310			N/A
BG3		Cortex-A15	N/A		CA15 integrated		N/A
"""

As was told that the Armada X or MV88DEx names are not used during
development, and what Marvell is really using are the BGxx names.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
