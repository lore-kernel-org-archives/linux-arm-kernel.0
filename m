From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 18 Oct 2016 17:31:40 +0800
Subject: [PATCH v5 00/23] Support qcom's HSIC USB and rewrite USB2 HS
 support
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018093139.GB6294@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 06:56:13PM -0700, Stephen Boyd wrote:
> The state of USB ChipIdea support on Qualcomm's platforms is not great.
> The DT description of these devices requires up to three different nodes
> for what amounts to be the same hardware block, when there should really
> only be one. Furthermore, the "phy" driver that is in mainline (phy-msm-usb.c)
> duplicates the OTG state machine and touches the ci controller wrapper
> registers when it should really be focused on the phy and the ULPI accesses
> needed to get the phy working. There's also a slimmed down phy driver for
> the msm8916 platform, but really the phy hardware is the same as other MSMs,
> so we have two drivers doing pretty much the same thing. This leads to a
> situtaion where we have the chipidea core driver, the "phy" driver, and
> sometimes the ehci-msm.c driver operating the same device all at the same
> time with very little coordination. This just isn't very safe and is
> confusing from a driver perspective when trying to figure out who does what.
> Finally, there isn't any HSIC support on platforms like apq8074 so we
> should add that.
> 
> This patch series updates the ChipIdea driver and the MSM wrapper
> (ci_hdrc_msm.c) to properly handle the PHY and wrapper bits at the right
> times in the right places. To get there, we update the ChipIdea core to
> have support for the ULPI phy bus introduced by Heikki. Along the way
> we fix bugs with the extcon handling for peripheral and OTG mode controllers
> and move the parts of phy-usb-msm.c that are touching the CI controller
> wrapper into the wrapper driver (ci_hdrc_msm.c). Finally we add support
> for the HSIC phy based on the ULPI bus and rewrite the HS phy driver
> (phy-usb-msm.c) as a standard ULPI phy driver.
> 
> Once this series is accepted, we should be able to delete the phy-usb-msm.c,
> phy-qcom-8x16-usb.c, and ehci-msm.c drivers from the tree and use the ULPI
> based phy driver (which also lives in drivers/phy/ instead of drivers/usb/phy/)
> and the chipidea host core instead.
> 
> I've also sent separate patches for other minor pieces to make this
> all work. The full tree can be found here[2], hacks and all to get
> things working. I've tested this on the db410c, apq8074 dragonboard,
> and ifc6410 with configfs gadgets and otg cables.
> 
> Patches based on v4.8-rc1
> 
> Changes from v4:
>  * Picked up Acks from Rob
>  * Updated HS phy init sequence DT property to restrict it to offsets

I remembered that you got all my acks for chipidea patches, right? I did
not check for this series.

Besides, the patch "gpu: Remove depends on RESET_CONTROLLER when not a
provider" [1]  still not be accepted, I need this patch to be merged
first, then apply your chipidea part, otherwise, there is a building
warning.

[1] https://patchwork.kernel.org/patch/9322583/

Peter

> 
> Changes from v3:
>  * Picked up Acks from Peter
>  * Updated extcon consolidation patch per Peter's comments
>  * Folded in simplification from Heikki for ULPI DT matching
> 
> Changes from v2:
>  * Added SoC specific compatibles in phy bindings
>  * Dropped AVVIS patch for OTG statemachine
>  * New patch to consolidate extcon handlers
>  * Picked up Acks from Peter
>  * Rebased onto v4.8-rc1
>  * Reworked ULPI OF code to look at vid == 0 instead of pid == 0
>  * Dropped ULPI bindings for vid and pid overrides
> 
> Changes from v1:
>  * Reworked ULPI device probing to keep using vendor/product ids that
>    come from DT if needed and falls back to OF style match when product id
>    is 0
>  * PHY init later patch was rejected so that moved to a quirk flag and
>    the msm wrapper started managing the phy on/off
>  * Updated clk requirements for HSIC phy in binding doc
>  * Added optional clk in wrapper for "housekeeping" found on older qcom
>    platforms
>  * Bug fix to OTGSC polling function
>  * Changed runtime PM patch to set as active instead of get/put
> 
> TODO:
>  * DMA fails on arm64 so we need something like [1] or [3] to make it work.
>  * The db410c needs a driver to toggle the onboard switch to connect
>    the usb hub instead of micro port when the usb cable is disconnected.
>    I've sent a patch set for this[4], which needs some further
>    discussion/development.
>  * apq8064 platforms need a vbus regulator to really use otg and I haven't
>    tried out the RPM based regulators yet
>  * The HSIC phy on the apq8074 dragonboard is connected to a usb4604
>    device which requires the i2c driver to probe and send an i2c
>    sequence before the HSIC controller enumerates or HSIC doesn't work.
>    Right now I have a hack to force the controller to probe defer
>    once so that usb4604 probes first. This needs a more proper solution
>    like having the DT describe a linkage between the controller and
>    the usb device so we can enforce probe ordering.
>  * There are problems around the OTG switch still, due to how we handle
>    extcon events that I'm working through
> 
> [1] https://lkml.org/lkml/2016/2/22/7
> [2] https://git.linaro.org/people/stephen.boyd/linux.git/shortlog/refs/heads/usb-hsic-8074
> [3] https://patchwork.kernel.org/patch/9319527/
> [4] https://lkml.kernel.org/r/20160914014246.31847-1-stephen.boyd at linaro.org
> 
> Stephen Boyd (23):
>   of: device: Support loading a module with OF based modalias
>   of: device: Export of_device_{get_modalias,uvent_modalias} to modules
>   usb: ulpi: Support device discovery via DT
>   usb: chipidea: Only read/write OTGSC from one place
>   usb: chipidea: Handle extcon events properly
>   usb: chipidea: Add platform flag for wrapper phy management
>   usb: chipidea: Notify events when switching host mode
>   usb: chipidea: Remove locking in ci_udc_start()
>   usb: chipidea: Add support for ULPI PHY bus
>   usb: chipidea: Consolidate extcon notifiers
>   usb: chipidea: Emulate OTGSC interrupt enable path
>   usb: chipidea: msm: Mark device as runtime pm active
>   usb: chipidea: msm: Rely on core to override AHBBURST
>   usb: chipidea: msm: Use hw_write_id_reg() instead of writel
>   usb: chipidea: msm: Add proper clk and reset support
>   usb: chipidea: msm: Mux over secondary phy at the right time
>   usb: chipidea: msm: Restore wrapper settings after reset
>   usb: chipidea: msm: Make platform data driver local instead of global
>   usb: chipidea: msm: Add reset controller for PHY POR bit
>   usb: chipidea: msm: Handle phy power states
>   usb: chipidea: msm: Be silent on probe defer errors
>   phy: Add support for Qualcomm's USB HSIC phy
>   phy: Add support for Qualcomm's USB HS phy
> 
>  .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |  86 +++++++
>  .../devicetree/bindings/phy/qcom,usb-hsic-phy.txt  |  65 +++++
>  Documentation/devicetree/bindings/usb/ulpi.txt     |  20 ++
>  drivers/of/device.c                                |  25 ++
>  drivers/phy/Kconfig                                |  15 ++
>  drivers/phy/Makefile                               |   2 +
>  drivers/phy/phy-qcom-usb-hs.c                      | 286 +++++++++++++++++++++
>  drivers/phy/phy-qcom-usb-hsic.c                    | 160 ++++++++++++
>  drivers/usb/chipidea/Kconfig                       |   8 +
>  drivers/usb/chipidea/Makefile                      |   1 +
>  drivers/usb/chipidea/ci.h                          |  24 +-
>  drivers/usb/chipidea/ci_hdrc_msm.c                 | 280 +++++++++++++++++---
>  drivers/usb/chipidea/core.c                        | 135 +++++-----
>  drivers/usb/chipidea/host.c                        |  10 +
>  drivers/usb/chipidea/otg.c                         | 105 +++++++-
>  drivers/usb/chipidea/udc.c                         |   3 -
>  drivers/usb/chipidea/ulpi.c                        | 113 ++++++++
>  drivers/usb/common/ulpi.c                          |  79 +++++-
>  include/linux/of_device.h                          |   6 +
>  include/linux/usb/chipidea.h                       |   9 +-
>  20 files changed, 1292 insertions(+), 140 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hsic-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt
>  create mode 100644 drivers/phy/phy-qcom-usb-hs.c
>  create mode 100644 drivers/phy/phy-qcom-usb-hsic.c
>  create mode 100644 drivers/usb/chipidea/ulpi.c
> 
> -- 
> 2.10.0.297.gf6727b0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 

Best Regards,
Peter Chen
