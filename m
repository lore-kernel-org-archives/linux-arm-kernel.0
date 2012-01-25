From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:30:00 +0000
Subject: [PATCH 00/33] Restore SA11x0 MCP/UCB drivers to a working state
Message-ID: <20120125143000.GF1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 06:04:56PM +0000, Russell King - ARM Linux wrote:
> Samuel,
> 
> The following patch set restores the SA11x0 MCP and UCB1x00 drivers back
> to a working state, as tested on the Assabet.
> 
> The first two patches are the revert I requested.  The others fix a
> problem with the UCB1x00's use of genirq (it returns from its interrupt
> handler with IRQs enabled, which causes genirq to barf), and delete the
> SA11x0 specific DMA definitions and SA11x0 specific DMA header file
> from the driver.  That is in preparation for me removing the existing
> SA11x0 private DMA backend in favour of a DMA engine implementation.
> 
> As the DMA changes have dependencies in my tree (on which other changes
> then depend on) I can't see this being sanely split from my tree, so
> I'll request acks for these changes.
> 
> I'll plan to send the first three patches to Linus as part of my next
> 'fixes' push if you agree.

I've not heard anything back from anyone, so I'm going to assume that's
silent approval.

However, I've taken some time to replace some of the parts of the patches
which have had to be reverted, which are fully tested on my Assabet, and
to augment the patches to bring the driver up to speed with things like
genirq, sparse IRQ, mutexes rather than semaphores, etc.

So, in this replacement set, the first seven patches are bug fixes of
various kinds:

Revert "ARM: sa1100: Refactor mcp-sa11x0 to use platform resources."
Revert "ARM: sa11x0: Implement autoloading of codec and codec pdata for
MFD: mcp-core: fix complaints from the genirq layer
MFD: mcp-core: fix mcp_priv() to be more type safe
MFD: ucb1x00-core: fix missing restore of io output data on resume
MFD: ucb1x00-core: fix gpiolib direction_output handling
MFD: ucb1x00-ts: fix resume failure

these I believe need to go in for -rc.  My plan is to send them when I
sent the rest of the ARM fixes, either tonight or tomorrow night.

Following this is what I consider to be development on top of what was
in v3.2, and the work which Jochen produced:

MFD: mcp-core: sanitize host creation/removal
MFD: mcp-sa11x0: remove DMA initializers and variables
MFD: mcp-sa11x0: move setup of PPC unit out of mcp-sa11x0.c
MFD: mcp-sa11x0: add .owner initializer
MFD: mcp-sa11x0: convert mcp-sa11x0 to use platform resources
MFD: mcp-sa11x0: convert to use dev_pm_ops
MFD: mcp-sa11x0: use _noirq resume methods
MFD: mcp/ucb1x00: separate ucb1x00 driver data from the MCP data
MFD: ucb1x00-ts: provide input layer with device parent
MFD: ucb1x00-core: get rid of mach/hardware.h include
MFD: ucb1x00-core: add handling for ucb1x00 reset
MFD: ucb1x00-core: add .owner initializer and module alias
MFD: ucb1x00-core: use mutexes instead of semaphores
MFD: ucb1x00-core: clean up device handling in probe
MFD: ucb1x00-core: add owner and dev initializers to gpio structure
MFD: ucb1x00-core: scan drivers in same order they're registered
MFD: ucb1x00-core: add missing ucb1x00_enable()/ucb1x00_disable()
MFD: ucb1x00-core: disable mcp clock when bus is not required
MFD: mcp-sa11x0: complain if mcp clock is left enabled
MFD: ucb1x00-core: convert to use dev_pm_ops
MFD: mcp-core: remove legacy driver suspend/resume methods
MFD: ucb1x00: convert to use genirq
MFD: ucb1x00-core: add wakeup support
ARM: sa11x0: add assabet ucb1x00 platform data
MFD: ucb1x00-assabet: add support for UCB1x00 GPIO switches
MFD: mcp-sa11x0/assabet: move assabet reset handling out of mcp-sa11x0.c

This is purposely ordered - eg, things like converting this to genirq
requires the PM stuff to be fixed first to ensure that the IRQ registers
are accessible when genirq wants to resume from system suspend.

I've kept the core changes first, and the platform changes (for the
Assabet) as the final three patches.

The work which was taken from Jochen's original patches is:

1. Move the PPC initialization out of the driver.  I put it in a common
   function so we don't have individual platforms implementing the same
   bit of code multiple times.

2. Adding .owner initializers to MCP driver structures.

3. Using platform resources for SA11x0 MCP interface base address.

4. Using separate driver_data to pass platform specifics to the UCB1x00
   driver, rather than embedding them in the MCP data structure.

There's further work to be done on this driver, namely:

1. Fixing its use of a class device.  This was originally done because it
   seemed to make sense back in the early days of the driver model.  I
   don't think it makes that much sense, and it gets in the way of proper
   wakeup support.

2. Wakeup support - provided the UCB codec is connected to a wakeup capable
   upstream IRQ, and the power is not removed from the codec during suspend
   modes, the UCB is perfectly capable of doing wakeup.  I have a small
   patch on top of this which allows the touchscreen to do exactly that.
   The Assabet buttons can also wake the system up but I've not tested that.
   There's no reason they can't other than just not setting the relevant
   flag in the gpio_keys data structure.

3. Module auto-loading - this doesn't make sense when genirq requires the
   core UCB1x00 module to be built-in to have access to the various IRQ
   functions.  It's probably unsafe on multiprocessor or preempt systems
   to have IRQ code unload once IRQ decoding handlers have been registered.

Diffstat:

 arch/arm/mach-sa1100/assabet.c          |   28 +-
 arch/arm/mach-sa1100/cerf.c             |   12 +-
 arch/arm/mach-sa1100/collie.c           |   15 +-
 arch/arm/mach-sa1100/generic.c          |   14 +-
 arch/arm/mach-sa1100/generic.h          |    1 +
 arch/arm/mach-sa1100/include/mach/mcp.h |    2 -
 arch/arm/mach-sa1100/lart.c             |   11 +-
 arch/arm/mach-sa1100/shannon.c          |   12 +-
 arch/arm/mach-sa1100/simpad.c           |   16 +-
 drivers/mfd/Kconfig                     |    5 +-
 drivers/mfd/mcp-core.c                  |  106 ++-----
 drivers/mfd/mcp-sa11x0.c                |  265 +++++++++---------
 drivers/mfd/ucb1x00-assabet.c           |   46 +++-
 drivers/mfd/ucb1x00-core.c              |  484 ++++++++++++++++---------------
 drivers/mfd/ucb1x00-ts.c                |   73 +++---
 include/linux/mfd/mcp.h                 |   22 +-
 include/linux/mfd/ucb1x00.h             |   41 ++--
 include/linux/mod_devicetable.h         |   11 -
 scripts/mod/file2alias.c                |   10 -
 19 files changed, 547 insertions(+), 627 deletions(-)
