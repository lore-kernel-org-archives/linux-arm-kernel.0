From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 12 May 2014 14:04:46 +0200
Subject: [PATCH v13 0/2] ARM: sunxi: Add driver for SD/MMC hosts found on
 sunxi SoCs
Message-ID: <1399896288-5826-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is lucky number v13 of the sunxi-mmc patch-set David Lanzend?rfer and I
have been working on, with the __clk_get_hw call moved from sunxi-mmc.c
to clk-sunxi.c where it belongs.

Mike, the first patch in this series modifies clk_sunxi_mmc_phase_control to
take a struct clk * as argument rather then a struct clk_hw *, and should
go upstream through the clk tree. Feel free to squash this into the patch
adding the clk_sunxi_mmc_phase_control function if you prefer.

The second patch in this series is the patch adding the actual mmc driver and
should go in through the mmc tree.

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

Changes since v10:
-Dropped all dts and clk patches, as they are all accepted now
-Cleanup some somewhat weird names (leftovers from the android code):
 s/mci_readl/mmc_readl/
 s/mci_writel/mmc_write/
 s/smc_host/host/
-Switched to mmc_regulator_get_supply API and added fixed regulator nodes to
 all board files (introducing new dts patches)
-Got rid of duplicate ios info
-Stop checking card-detect before each request
-Drop usleep after changing the clock rate
-Drop incomplete / wrong voltage switching support
-Drop the large comment with values copy/pasted from the spec
-Move enable/disable clk + reset + irq calls from power up / down to
 probe / remove
-Make sunxi_mmc_clk_set_rate / sunxi_mmc_oclk_onoff return an error
-Use a threaded interrupt handler for sending an explicit stop on data errors
-Fix sunxi_mmc_send_manual_stop to properly stop ongoing SD_IO_RW_EXTENDED cmds

Changes since v11:
-Instead of adding a reg_vmmc0 regulator add a fixed reg_vcc3v3 regulator, as
 we may need it in other places too
-Also add a vmmc-supply entry to thr non mmc0 nodes on the 2 boards which have
 multiple sdcard slots.

Changes since v12:
-Drop all dts patches, as they are all merged for going upstream
-Add a patch modifying clk_sunxi_mmc_phase_control to take a struct clk * as
 argument rather then a struct clk_hw *
-Modify the patch adding the actual sunxi-mmc driver for the
 clk_sunxi_mmc_phase_control API change

Regards,

Hans
