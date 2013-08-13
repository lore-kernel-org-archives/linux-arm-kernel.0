From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 14 Aug 2013 07:43:04 +0800
Subject: [PATCH v15 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130813234303.GA27876@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 09:22:46AM +0800, Peter Chen wrote:
> This patchset adds tested otg id switch function and vbus connect
> and disconnect detection for chipidea driver. And fix kinds of 
> bugs found at chipidea drivers after enabling id and vbus detection.
> 
> This patch are fully tested at imx6 sabresd and imx28evk platform by me.
> Besides, marek tested it on two STMP3780-based boards (not yet mainline)
> and two MX28-based boards.
> 
> My chipidea repo: https://github.com/hzpeterchen/linux-usb.git

Hi Alex,

I see Felipe has already sent his pull request for 3.12 merge
windows. Would you please speed up review my chipidea patches?
At least, I hope this serial can be queued at 3.12. Thanks.

> 
> Changes for v15:
> - Mark otgsc API as static line, and move them to otg.h [4/13]
> - Remove some redundant comments [6/13]
> - Fix some typos [8/13]
> - Retire flag CI_HDRC_PULLUP_ON_VBUS [12/13] [13/13]
> 
> Changes for v14:
> - This patchset is based on below recent chipidea patches and newest
> usb-next, it can decrease rebase effort.
> 
> Fabio Estevam (3):
>   chipidea: ci_hdrc_imx: Remove unused variable 'res'
>   chipidea: core: Move hw_phymode_configure() into probe
>   chipidea: Remove previous MODULE_ALIAS
> 
> Lothar Wabmann (3):
>   usb: chipidea: improve kconfig 2.0
>   usb: chipidea: don't clobber return value of ci_role_start()
>   usb: chipidea: ci_hdrc_imx: remove an unsolicited module_put() call
>     from ci_hdrc_imx_remove()
> 
> Peter Chen (1):
>   usb: chipidea: fix the build error with randconfig
> 
> - [Michael comments]: move vbus operation to core, and squash two vbus
> patches. [1/12], [2/12]
> - [Michael comments]: move out non vbus and non id related patches. [14/14 at v13]
> 
> Chagnes for v13:
> - Add Tested-by: Marek Vasut <marex@denx.de>
> - [Sascha's comments]: Add return value check for devm_regulator_get. [3/14]
> - [Marc's comments]: Change timeout usage at hw_wait_reg. [11/14]
> - [Alex's comments]: Using platdata flag to indicate dual role but not 
> OTG controller. [7/14]
> 
> Changes for v12:
> - Rebased greg's usb-next tree (3.10.0-rc7+)
> - Split more small patches for single function and fix.
> 
> Peter Chen (12):
>   usb: chipidea: move vbus regulator operation to core
>   usb: chipidea: host: add vbus regulator control
>   usb: chipidea: udc: otg_set_peripheral is useless for some chipidea
>     users
>   usb: chipidea: otg: Add otg file used to access otgsc
>   usb: chipidea: Add role init and destory APIs
>   usb: chipidea: add flag CI_HDRC_DUAL_ROLE_NOT_OTG
>   usb: chipidea: disable all interrupts and clear all interrupts status
>   usb: chipidea: move otg relate things to otg file
>   usb: chipidea: add vbus interrupt handler
>   usb: chipidea: add wait vbus lower than OTGSC_BSV before role starts
>   usb: chipidea: udc: misuse flag CI_HDRC_REGS_SHARED and
>     CI_HDRC_PULLUP_ON_VBUS
>   usb: chipidea: udc: .pullup is valid when vbus is on at
>     CI_HDRC_PULLUP_ON_VBUS
> 
> Peter Chen (13):
>   usb: chipidea: move vbus regulator operation to core
>   usb: chipidea: host: add vbus regulator control
>   usb: chipidea: udc: otg_set_peripheral is useless for some chipidea
>     users
>   usb: chipidea: otg: Add otg file used to access otgsc
>   usb: chipidea: Add role init and destroy APIs
>   usb: chipidea: add flag CI_HDRC_DUAL_ROLE_NOT_OTG
>   usb: chipidea: disable all interrupts and clear all interrupts status
>   usb: chipidea: move otg related things to otg file
>   usb: chipidea: add vbus interrupt handler
>   usb: chipidea: add wait vbus lower than OTGSC_BSV before role starts
>   usb: chipidea: udc: misuse flag CI_HDRC_REGS_SHARED and
>     CI_HDRC_PULLUP_ON_VBUS
>   usb: chipidea: retire flag CI_HDRC_PULLUP_ON_VBUS
>   usb: chipidea: udc: .pullup is valid only when vbus is there
> 
>  drivers/usb/chipidea/Makefile      |    2 +-
>  drivers/usb/chipidea/bits.h        |   10 ++
>  drivers/usb/chipidea/ci.h          |    8 ++
>  drivers/usb/chipidea/ci_hdrc_imx.c |   27 +-----
>  drivers/usb/chipidea/ci_hdrc_msm.c |    1 -
>  drivers/usb/chipidea/core.c        |  183 +++++++++++++++++++++++++-----------
>  drivers/usb/chipidea/host.c        |   30 ++++++-
>  drivers/usb/chipidea/host.h        |    6 +
>  drivers/usb/chipidea/otg.c         |  120 +++++++++++++++++++++++
>  drivers/usb/chipidea/otg.h         |   35 +++++++
>  drivers/usb/chipidea/udc.c         |   78 ++++++++++------
>  drivers/usb/chipidea/udc.h         |    6 +
>  include/linux/usb/chipidea.h       |    7 +-
>  13 files changed, 401 insertions(+), 112 deletions(-)
>  create mode 100644 drivers/usb/chipidea/otg.c
>  create mode 100644 drivers/usb/chipidea/otg.h
> 

-- 

Best Regards,
Peter Chen
