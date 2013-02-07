From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Feb 2013 11:56:32 +0100
Subject: [PATCH v4] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130207105632.GB9183@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander,

Did you have a chance to look at this series? Development of this driver
has stalled for too long now, I don't want to miss the next merge
window.

Thanks
 Sascha

On Mon, Feb 04, 2013 at 02:24:26PM +0100, Sascha Hauer wrote:
> 4th round of patches.
> 
> Peter, I would be glad if you could test them before your holiday. I rebased
> your last round of Chipidea OTG patches onto this series which you can pull
> here:
> 
> git://git.pengutronix.de/git/imx/linux-2.6.git tags/usb-chipidea-otg-for-next
> 
> I couldn't really test the otg patches since my current hardware does not have
> the ID pin connected, but I can verify that my usecase still works with your
> patches applied.
> 
> Alex, should the patches work for you and are fine otherwise, could you apply
> them for v3.9?
> 
> Sascha
> 
> 
> 
> changes since v3:
> 
> - add phy patches (which were accidently already part of v2)
> - Use OP_DEVLC instead of OP_PORTSC for lpm case
> - Use enum usb_dr_mode ub ci_hdrc_probe()
> 
> changes since v2:
> 
> - fix adding of GPL Header was in wrong patch
> - add missing hunk for new file of.c
> 
> changes since v1:
> - move phy specific of helper to drivers/usb/phy/of.c
> - use strcmp instead of strcasecmp for matching property values
> - change usb_phy_dr_mode to usb_dr_mode
> - change USBPHY_INTERFACE_MODE_NA to USBPHY_INTERFACE_MODE_UNKNOWN
> - add copyright header to new files
> - chipidea: drop mdelay at end of PTS/PTW setup
> - chipidea: implement lpm core type handling for PTS/PTW
> 
> 
> The following changes since commit 2f0760774711c957c395b31131b848043af98edf:
> 
>   USB: GADGET: optionally force full-speed for net2280 UDC (2013-01-31 10:09:19 +0100)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/imx/linux-2.6.git tags/usb-chipidea-for-next
> 
> for you to fetch changes up to 25682afd7be85f1462647d8530dca1bf848074fc:
> 
>   USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy (2013-02-04 12:28:53 +0100)
> 
> ----------------------------------------------------------------
> USB: chipidea patches for v3.9
> 
> These add OF helpers for handling the dr_mode and phy_type property
> and makes use of them in the chipidea driver.
> 
> ----------------------------------------------------------------
> Marc Kleine-Budde (1):
>       usb: otg: use try_module_get in all usb_get_phy functions and add missing module_put
> 
> Michael Grzeschik (3):
>       USB: add devicetree helpers for determining dr_mode and phy_type
>       USB: chipidea: ci13xxx-imx: create dynamic platformdata
>       USB: chipidea: add PTW and PTS handling
> 
> Sascha Hauer (5):
>       USB: move bulk of otg/otg.c to phy/phy.c
>       USB chipidea: introduce dual role mode pdata flags
>       USB chipidea i.MX: introduce dr_mode property
>       USB mxs-phy: Register phy with framework
>       USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy
> 
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 +
>  drivers/usb/chipidea/bits.h                        |   14 +-
>  drivers/usb/chipidea/ci13xxx_imx.c                 |   68 +--
>  drivers/usb/chipidea/core.c                        |   60 ++-
>  drivers/usb/otg/mxs-phy.c                          |    9 +
>  drivers/usb/otg/otg.c                              |  423 -------------------
>  drivers/usb/phy/Makefile                           |    2 +
>  drivers/usb/phy/of.c                               |   47 +++
>  drivers/usb/phy/phy.c                              |  438 ++++++++++++++++++++
>  drivers/usb/usb-common.c                           |   36 ++
>  include/linux/usb/chipidea.h                       |    3 +-
>  include/linux/usb/of.h                             |   27 ++
>  include/linux/usb/otg.h                            |    7 +
>  include/linux/usb/phy.h                            |    9 +
>  14 files changed, 687 insertions(+), 462 deletions(-)
>  create mode 100644 drivers/usb/phy/of.c
>  create mode 100644 drivers/usb/phy/phy.c
>  create mode 100644 include/linux/usb/of.h
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
