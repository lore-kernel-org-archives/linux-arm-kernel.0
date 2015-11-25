From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 23:19:28 +0000
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151125191600.GM11384@lunn.ch>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151125160937.GJ14338@lunn.ch>
 <20151125183728.GO8644@n2100.arm.linux.org.uk>
 <20151125191600.GM11384@lunn.ch>
Message-ID: <20151125231928.GS8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 08:16:00PM +0100, Andrew Lunn wrote:
> So looking at this list, could you maybe post the following, if they
> don't have dependencies. Going from only the subject, most look simple
> and should not be too much effort to get mainlined.

It's really not that simple.  Remember what base this tree is: it is
Rabeeh's kernel tree from 3.4 times, with _each_ mainline release
merged into it and a patch set of 250+ patches rebased forwards.
A lot of these patches do not easily apply to mainline kernels.

> > orion clock build fix

Adding linux/clk.h to plat-orion/clock.c to solve some build errors,
file does not exist in mainline.

> > ARM: dove: more clock cleanups

Adding linux/clkdev.h to clk-si5351.c to fix build errors caused by
4.3 changes breaking previous tweaks to make it work in non-DT setups.
Not applicable to mainline without previous tweaks.

> > ARM: dove: cubox: add DT booting support

Adds to the non-DT cubox board file a DT descriptor to pick up on
the existing cubox compatible, and to hook into the "old style"
initialisation to allow etnaviv/armada-drm/vmeta/bmm to work.

> > ARM: dove: move hwmon initialisation into PMU driver

Only applicable if you have the hwmon driver.

> > ARM: l2c: tauros2: fix OF-enabled non-DT boot

A possible fix for mainline if we're keeping non-DT tauros2 support around.

> > ARM: mvebu: allow mvebu/dove to be enabled

Possibly not applicable with Arnd's work.

> > ARM: cubox: fix flash type

Not applicable because mainline has no non-DT cubox board file.

> > ARM: dove: remove cubox_extclk device
> > ARM: dove: clock improvements
> > ARM: dove: fix dove clock support to recalculate the actual rates
> > ARM: dove: cleanup dove clock support
> > ARM: dove: fix clock name
> > ARM: dove: no need for empty clock enable/disable methods
> > ARM: dove: remove unused clock declarations
> > ARM: dove: fix 'addr' types in dove clock.c

All the above are cleaning up the "missing bits" of the clock tree for
the GPU/CPU/vmeta clocks - the stuff that's clocked off the main 2GHz
PLL.  No support in mainline for this, and would need to be converted to
a CCF driver.

> > HWMON: dove: fix use if S_IRWXUGO in dove hwmon driver
> > HWMON: move dove hwmon module to drivers/hwmon and add MODULE_ALIAS
> > HWMON: dove: fix mask writes
> > HWMON: dove: move current_mode and warning_flag into dovetemp_data
> > HWMON: dove: push dovetemp_data down into functions
> > HWMON: dove: move timer to dovetherm_data structure
> > HWMON: dove: add driver private data
> > HWMON: dove: use module_platform_driver in dove hwmon driver
> > HWMON: dove: fix monitoring printks

hwmon is something that needs to be dealt with, but is nowhere near
mainline ready.

> > Revert "Allow ioremap_nocache on PJ4 processor that is in Dove."

Not applicable to mainline; it's reverting a patch in Rabeeh's tree.

> > ARM: dove: convert legacy dove to PMU support

This one got dropped due to conflicts.  It's now rebased on 4.3 (which
is the earliest final kernel release it could be based upon, as the
PMU code and conflicting changes were merged in the 4.3 merge window),
I can finally think about resending it.

> > dt-bindings: add Marvell PMU documentation

Was sent in March and July, and obviously if it's still in my git tree,
it never ended up being merged, and needs investigation as to what
happened, and why it hasn't been merged along with the code.

> > of: Add vendor prefix for Vivante Corporation

Part of the etnaviv patch set.

So, out of all those matches, maybe one or two patches can be sent
immediately.  That still leaves me with about a hundred patches
which are reliant on the non-DT dove code.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
