From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Mar 2018 23:13:09 +0000
Subject: [PATCH 3/5] ARM: trusted_foundations: do not use naked function
In-Reply-To: <20180320230206.25289-4-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-4-stefan@agner.ch>
Message-ID: <20180320231309.GJ2743@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 12:02:04AM +0100, Stefan Agner wrote:
> As documented in GCC naked functions should only use Basic asm
> syntax. The Extended asm or mixture of Basic asm and "C" code is
> not guaranteed. Currently this works because it was hard coded
> to follow and check GCC behavior for arguments and register
> placement.

Those checks have nothing to do with that at all.  The whole point of
__asmeq() is to catch situations where you use register variables,
specifying which register you want them in, and GCC then ends up
passing them to assembly code in some other random register(s).

This was found with older GCCs, and the problem was fixed.  It has
nothing to do with naked functions per se.

In fact, as you're introducing further register variables, these
checks become more important to have than they were with the
previous code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
