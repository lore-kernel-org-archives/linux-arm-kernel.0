From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  8 Jan 2014 16:06:25 +0100
Subject: [PATCH v5 0/4] Fix i2c bus hang on A0 version of the Armada XP SoCs
Message-ID: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here come the 5th version of the series fixing the i2c bus hang on A0
version of the Armada XP SoCs. It occurred on the early release of the
OpenBlocks AX3-4 boards. Indeed the first variants of Armada XP SoCs
(A0 stepping) have issues related to the i2c controller which prevent
to use the offload mechanism and lead to a kernel hang during boot.

The main change are the use of marvell,mv78230-a0-i2c and that the
function mvebu_get_soc_id() is now local to mach-mvebu.

The first patch add a mean to detect the SoCs version at run-time and
the second one use this feature in the driver.

The 3 first patches should be applied on 3.13-rc and on stable kernel
3.12 as it fixes a regression introduce by the commit 930ab3d403ae
"i2c: mv64xxx: Add I2C Transaction Generator support".

The first patch could be latter be extend to also be used with dove,
kirkwood, orion5x and mv78x00 when there will be merged in mvebu and
even expose the SoC ID and revision to userspace.

Jason, do you still agree to take the series once Wolfram have given
his acked-by?

Thanks,

Gregory

Changelog:
v4 -> v5:

- use the marvell,mv78230-a0-i2c compatible string instead of the
  offload-broken property.

- move the mvebu-soc-id.h file into mach-mvebu

- no more export the mvebu_get_soc_id() function

- enable the quirk only on machines that we know may be affected, i.e.
OpenBlocks AX3-4.

v3 -> v4:

- checked the offload-broken property instead of calling the
  mvebu_get_soc_id() function in the mv64xxx_of_config() function.

- added the second patch to manage the quirk and update the device
  node with the offload-broken if needed.

- removed the acked-by from Wolfram as the code have change in the 3rd
  patch

In mvebu-soc-id.c:
 - used EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL

 - used core_initcall instead of arch_initcall to be called earlier
   enough.

v2 -> v3:

- fixed typo in the comments added in i2c-mv64xxx.c

- used pr_fmt instead of %s __func__ in all the pr_* functions

- added a check on the pointer returned by of_get_next_child()

- added a return immediately after the 1st check to be able to get rid
  of indenting the entire function code inside the if { ... } block.

v1 -> v2:

- Changed the way to test the return of the function mvebu_get_soc_id
  in order to make it clearer.

- Removed the superfluous parentheses

- Added Wolfram's acked-by on the 2nd patch

Gregory CLEMENT (4):
  ARM: mvebu: Add support to get the ID and the revision of a SoC
  ARM: mvebu: Add quirk for i2c for the OpenBlocks AX3-4 board
  i2c: mv64xxx: Fix bus hang on A0 version of the Armada XP SoCs
  i2c: mv64xxx: Document the newly introduced Armada XP A0 compatible

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |   2 +-
 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  32 ++++++
 arch/arm/mach-mvebu/mvebu-soc-id.c                 | 119 +++++++++++++++++++++
 arch/arm/mach-mvebu/mvebu-soc-id.h                 |  32 ++++++
 drivers/i2c/busses/i2c-mv64xxx.c                   |   8 ++
 6 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/mvebu-soc-id.c
 create mode 100644 arch/arm/mach-mvebu/mvebu-soc-id.h

-- 
1.8.1.2
