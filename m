From: johnyoun@synopsys.com (John Youn)
Date: Wed, 09 Nov 2016 19:27:36 -0800
Subject: [PATCH v2 00/30] usb: dwc2: Gadget descriptor DMA and IOT
Message-ID: <cover.1478748145.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements gadget-side descriptor DMA for the DWC_hsotg
controller.

It also includes support for DWC USB IOT controllers which use the
descriptor DMA mode of operation exclusively. These are two new
device-only USB controller IPs based on DWC_hsotg.

Tested on HAPS platform with:
* HSOTG IP version 3.30a
* FS/LS IOT IP version 1.00a
* HS IOT IP version 1.00a


v2:
* Remove the DMA 'enable' bindings and make them autodetected.
* Add DMA 'disable' bindings to override.
* Separate out commit to add '__packed' attribute.
* Don't print errors on -ENOMEM.
* Remove unnecessary GFP_ATOMIC flags.
* Remove unnecessary patch removing a WARN_ON.
* Reorganize and clarify BNA interrupt.
* Fix issue with enabling STSPHSERCVD interrupt.

Regards,
John


John Youn (4):
  usb: dwc2: Deprecate g-use-dma binding
  usb: dwc2: Update DMA descriptor structure
  usb: dwc2: Make the DMA descriptor structure packed
  usb: dwc2: Add bindings to disable gadget DMA modes

Vahram Aharonyan (23):
  usb: dwc2: gadget: Add descriptor DMA parameter
  usb: dwc2: gadget: Add DMA descriptor status quadlet fields
  usb: dwc2: gadget: Add DMA descriptor chains for EP 0
  usb: dwc2: host: Rename MAX_DMA_DESC_SIZE to HOST_DMA_NBYTES_LIMIT
  usb: dwc2: gadget: Transfer length limit checking for DDMA
  usb: dwc2: gadget: Add DDMA chain pointers to dwc2_hsotg_ep structure
  usb: dwc2: gadget: Add DDMA chain fill and parse functions
  usb: dwc2: gadget: EP 0 specific DDMA programming
  usb: dwc2: gadget: DDMA transfer start and complete
  usb: dwc2: gadget: Fixes for StsPhseRcvd interrupt
  usb: dwc2: gadget: Start DDMA IN status phase in StsPhseRcvd handler
  usb: dwc2: gadget: Enable descriptor DMA mode
  usb: dwc2: gadget: Add DDMA isoc related fields to dwc2_hsotg_ep
  usb: dwc2: gadget: Fill isoc descriptor and start transfer in DDMA
  usb: dwc2: gadget: Add completions for DDMA isoc transfers
  usb: dwc2: gadget: In DDMA keep incompISOOUT and incompISOIN masked
  usb: dwc2: gadget: Add start and complete calls for DDMA ISOC
  usb: dwc2: gadget: Enable the BNA interrupt
  usb: dwc2: gadget: Adjust ISOC OUT request's actual len for DDMA
  usb: dwc2: gadget: For DDMA parse setup only after SetUp interrupt
  usb: dwc2: gadget: Correct dwc2_hsotg_ep_stop_xfr() function
  usb: dwc2: gadget: Disable enabled HW endpoint in
    dwc2_hsotg_ep_disable
  usb: dwc2: Add support of dedicated full-speed PHY interface

Vardan Mikayelyan (3):
  usb: dwc2: gadget: Add IOT device IDs, configure core accordingly
  usb: dwc2: gadget: Program ep0_mps for LS
  usb: dwc2: gadget: Add new core parameter for low speed

 Documentation/devicetree/bindings/usb/dwc2.txt |   6 +-
 arch/arm/boot/dts/rk3036.dtsi                  |   1 -
 arch/arm/boot/dts/rk3288.dtsi                  |   1 -
 arch/arm/boot/dts/rk3xxx.dtsi                  |   1 -
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |   1 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi       |   1 -
 drivers/usb/dwc2/core.h                        |  50 +-
 drivers/usb/dwc2/gadget.c                      | 968 ++++++++++++++++++++++---
 drivers/usb/dwc2/hcd.c                         |  12 +-
 drivers/usb/dwc2/hcd.h                         |   2 +-
 drivers/usb/dwc2/hcd_ddma.c                    |  52 +-
 drivers/usb/dwc2/hw.h                          |  48 +-
 drivers/usb/dwc2/params.c                      |  45 +-
 drivers/usb/dwc2/pci.c                         |   1 -
 14 files changed, 1023 insertions(+), 166 deletions(-)

-- 
2.10.0
