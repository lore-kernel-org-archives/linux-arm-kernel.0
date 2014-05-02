From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  2 May 2014 17:57:14 +0200
Subject: [PATCH v10 00/15] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
Message-ID: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v10 of the sunxi-mmc patch-set David Lanzend?rfer and I have been
working on, this has some minor changes since v9, the plan for upstreaming is
still the same:

The first 2 patches are depenencies which should go in through the clk tree,
Mike can you pick these 2 up please ?  :

"clk: sunxi: factors: automatic reparenting support"
Is uncontroversial and has been favorably reviewed by various people.

"clk: sunxi: Implement MMC phase control"
Is somewhat more controversial as there has been lots of discussion about
adding a generic phase control method to the clk framework. The problem is
that there has been a lot of talk about such a generic phase control method
but not a single patch. Therefor I would like to move forwards with using
a platform specific method for now. I hereby promise that once we've a generic
method I'll write patches to convert the sunxi code to that method.

The third patch is the patch adding the actual mmc driver and should go in
through the mmc tree.

All the other patches are devicetree patches hooking things up, and should
go upstream through Maxime's sunxi-dt tree.

Changes since v1:
-Using mmc_of_parse instead of diy dt parsing
-Adding nodes for all mmc controller to the dtsi files,
 including sofar unused controllers
-Using generic GPIO slot library for WP/CD
-Adding additional MMC device nodes into DTSI files

Changes since v2:
-Add missing Signed-off-by tags
-Stop using __raw_readl / __raw_writel so that barriers are properly used
-Adding missing new lines
-Adding missing patch for automatic reparenting of clocks

Changes since v3:
-Move clk_enable / disable into host_init / exit (Hans)
-Fix hang on boot caused by irq storm (Hans)

Changes since v4:
-moving sunxi-mci.{c/h} to sunxi-mmc.{c/h}
-removing camel cases from the defines in  sunxi-mmc.h
-moving defines out of the struct definition
 since this is bad coding style
-adding documentation for the device tree binding
Changes since v5:
-adding host initialization for when the sdio irq is enabled
 (just to make sure having a defined state at all time)
-add mmc support fixup: set pullup on cd pins
-fixup: Don't set MMC_CAP_NEEDS_POLL /  MMC_CAP_4_BIT_DATA

Changes since v6:
-fixing copyright info in sunxi-mmc.*
-s/__SUNXI_MCI_H__/__SUNXI_MMC_H__/g
-s/SDXC_RESPONSE_/SDXC_RESP_/g
-s/define/definitions <- Comment from Priit Laes

Changes since v7:
-Merge sunxi-mmc.h into sunxi-mmc.c
-Various style fixes / cleanups based on Maxime's review
-sun6i support
-Fix a race condition in interrupt / tasklet interaction
-Split the dts patches into 3 per platform:
 1) Add mmc nodes to the dtsi
 2) Add mmc pinmux to the dtsi
 3) Add mmc nodes to the various board files
-Moved setting of bus-width and cd gpio polarity from .dtsi to the board-files
-Added sun6i dts patches

Changes since v8:
-Don't claim MMC_CAP_SDIO_IRQ by default, sdio-irq support appears to not
 always be reliable. Can be re-added to the caps on a per board basis
 through dts
-Added EXPORT_SYMBOL(clk_sunxi_mmc_phase_control)
-Moved bus-width and cd-inverted dts attributes for sun6i from dtsi to dts
-Squashed patches adding sun6i-a31-m9.dts and mmc support for m9 together
-Added a patch enabling the sdio wifi on the cubietruck in dts

Changes since v9:
-Drop the sun5i and sun6i dts pinmux patches as those have already been
 accepted
-Rename the mmc clock for the controller from "mod" to "mmc" so as
 to not confuse it with a regular mod0 clock
-Rename pinmux for the reference design card-detect pin from cd_pin_a to
 cd_pin_reference_design

Regards,

Hans
