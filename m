From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Dec 2013 14:35:47 +0000
Subject: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
In-Reply-To: <pull-1386643347-596413>
References: <pull-1386643347-596413>
Message-ID: <20131210143547.GA32243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 06:42:27PM -0800, Tony Lindgren wrote:
> We can now finally make mach-omap2 to boot with device tree only and get
> rid of over 20k lines of platform init code that way.
> 
> Most basic devices already work using device tree based initialization
> and the remaining devices can be initialized using platform data
> with pdata-quirks.c.
> 
> So for most missing boards it's just a question of adding a .dts file
> that should be fairly similar to one of the existing .dts files as
> we've tried to cover all basic omap3 board types.
> 
> For people getting started updating their board files to for device
> tree, there are some basic instructions in commit 8dc8b3ddf5d7
> (ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
> DT only for booting).
> 
> Please also note that there are also some related fixes making their way
> into the mainline kernel that are needed for some use cases:
> 
> PM off-idle for omap3 and wake-up events need the following two patches:

While this is good, what seems to be happening is a complete switch
from one method of booting to a different method of booting with no
compatibility inbetween.  We're going from only supporting the ATAG
booting protocol for these platforms in v3.12 to only supporting the
DT booting protocol in v3.13.  There's no forward or backwards
compatibility - it's one or the other.

This is bad: this is the kind of "flag day" change which Linus hates -
and I hate it because it means I need to update my build test system
at the same time that arm-soc merges this stuff.

This is utterly crap - it's crap not only from the point of view of the
user perspective, but also from the development methodology point of
view.
