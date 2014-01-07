From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  7 Jan 2014 17:35:01 +0100
Subject: [PATCH v4 0/3] Fix i2c bus hang on A0 version of the Armada XP SoCs
Message-ID: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Eventually the 3rd version was not the last of the series fixing the
i2c bus hang on A0 version of the Armada XP SoCs. It occurred on the
early release of the OpenBlocks AX3-4 boards. Indeed the first
variants of Armada XP SoCs (A0 stepping) have issues related to the
i2c controller which prevent to use the offload mechanism and lead to
a kernel hang during boot.

I have also just realized that I didn't put i2c list and maintainer
with my 3rd version, it was a mistake and not done in purpose.

On Arnd request I moved the arch specific code outside the i2c
driver. This is now handle by the patch 2 and it create the
appropriate flag if needed.

The first patch add a mean to detect the SoCs version at run-time and
the second one use this feature in the driver.

Wolfram, I removed your acked-by on the 3rd patch as the code was
changed, could you check that you agree with it and it is the case
give your acked-by ?

These 3 patches should be applied on 3.13-rc and on stable kernel 3.12
as it fixes a regression introduce by the commit 930ab3d403ae "i2c:
mv64xxx: Add I2C Transaction Generator support".

The first patch could be latter be extend to also be used with dove,
kirkwood, orion5x and mv78x00 when there will be merged in mvebu.

Thanks,

Gregory

Changelog:
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

Gregory CLEMENT (3):
  ARM: mvebu: Add support to get the ID and the revision of a SoC
  ARM: mvebu: Add quirk for i2c
  i2c: mv64xxx: Fix bus hang on A0 version of the Armada XP SoCs

 arch/arm/mach-mvebu/Makefile        |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.c |  24 ++++++++
 arch/arm/mach-mvebu/mvebu-soc-id.c  | 120 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mv64xxx.c    |   4 +-
 include/linux/mvebu-soc-id.h        |  32 ++++++++++
 5 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/mvebu-soc-id.c
 create mode 100644 include/linux/mvebu-soc-id.h

-- 
1.8.1.2
