From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 26 Feb 2013 17:36:00 +0800
Subject: [PATCH v9 0/9] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130226093559.GA18059@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 05:24:34PM +0800, Peter Chen wrote:

Hi Alex, 

Ping............

> Changes for v9:
> - Some small comments from Alex like: variable comment for otg event
> additional newline. [3/9]
> - Import function tell show if the controller has otg capable, if
> the controller supports both host and device, we think it is otg
> capable, and can read OTGSC. [3/9]
> - Merge two otg patches [v8 3/8] and [v8 4/8] to one [v9 3/9]. [3/9]
> - Add inline to ci_hdrc_gadget_destroy if CONFIG_USB_CHIPIDEA_UDC
> is not defined, it can fix one build warning "defined but not used"
> [3/9]
> - One comment from Felipe about changing calling gadget disconnect
> API at chipidea's udc driver. I move calling ci->driver->disconnect
> from _gadget_stop_activity to which calls _gadget_stop_activity except
> ci13xxx_stop, as udc core will call disconnect when do rmmod gadget. [7/9]
> - Add ci core probe's return value to ci's platform_data, we do this
> for getting core's probe's result at platform layer, and quit it
> if the core's probe fails. [8/9] [9/9]
> 
> Changes for v8:
> - Add ci_supports_gadget helper to know if the controller
> supports gadget, if the controller supports gadget, it
> needs to read otgsc to know the vbus value, basically,
> if the controller supports gadget, it will support host
> as well [3/8]
> - At ci_hdrc_probe, it needs to add free memory at error path
> [3/8]
> - Cosolidate ci->driver = NULL at ci13xxx_stop
> [8/8]
> 
> Changes for v7:
> For Patch 8/8, we only need to set ci->driver to NULL when usb cable
> is not connected, for other changes, it will case some runtime pm
> unmatch and un-align with udc-core & composite driver problems.
> 
> Changes for v6:
> - Add Alex comments for init/destroy function [3/8] [4/8]
> - Remove memset(&ci->gadget, 0, sizeof(ci->gadget)) at destory function [4/8]
> - Add Kishon's comment: Change the format of struct usb_otg otg at drivers/usb/chipidea/ci.h
> [1/8]
> - Add comments for CI_VBUS_STABLE_TIMEOUT [3/8]
> - Change the otg_set_peripheral return value check as the fully
> chipidea driver users don't need it. [4/8]
> - Fix one bug that the oops when re-plug in usb cable after
> rmmod gadget [8/8]
> 
> Anyone who has tested this patchset, please give a tested-by, thanks.
> 
> This patchset adds tested otg id switch function and
> vbus connect/disconnect detection for chipidea driver.
> The mainly design of id/vbus handling follows msm otg driver.
> I hope the msm usb maintainer can have a look of this patchset,
> and give some comments, and move the whole msm usb driver to
> chipidea framework if possible in the future.
> 
> This patch is fully tested at imx6 sabresd platform.
> My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
> which is rebased of Sascha's git
> (git://git.pengutronix.de/git/imx/linux-2.6.git tags/usb-chipidea-otg-for-next)
> 
> At sascha's tag, it finishes some dr_mode and phy_type patches,
> in that way, we can choose host-only and gadget-only function at
> dts file as well as we can choose different phy setting.
> 
> Besides sascha's work, there are some Michael Grzeschik/Marc Kleine-Budde
> usbmisc patch, imx chipidea suspend/resume patch, and one pin control
> patch for imx6
> 
> Peter Chen (9):
>   Revert "USB: chipidea: add vbus detect for udc"
>   usb: chipidea: add otg file
>   usb: chipidea: add otg id switch and vbus connect/disconnect detect
>   usb: chipidea: udc: add pullup/pulldown dp at hw_device_state
>   usb: chipidea: udc: retire the flag CI13_PULLUP_ON_VBUS
>   usb: chipidea: imx: add internal vbus regulator control
>   usb: chipidea: udc: fix the oops when plugs in usb cable after rmmod
>     gadget
>   usb: chipidea: tell platform layer the ci core probe's result
>   usb: chipidea: imx: fix the error that using uninitialized pointer
> 
>  drivers/usb/chipidea/Makefile      |    2 +-
>  drivers/usb/chipidea/bits.h        |   10 ++
>  drivers/usb/chipidea/ci.h          |   14 +++-
>  drivers/usb/chipidea/ci13xxx_imx.c |   85 ++++++++++++----
>  drivers/usb/chipidea/ci13xxx_msm.c |    1 -
>  drivers/usb/chipidea/core.c        |  192 ++++++++++++++++++++++++++++++++----
>  drivers/usb/chipidea/host.c        |    6 +
>  drivers/usb/chipidea/host.h        |    6 +-
>  drivers/usb/chipidea/otg.c         |   68 +++++++++++++
>  drivers/usb/chipidea/otg.h         |    9 ++
>  drivers/usb/chipidea/udc.c         |  118 ++++++++++------------
>  drivers/usb/chipidea/udc.h         |    4 +
>  include/linux/usb/chipidea.h       |    2 +-
>  13 files changed, 405 insertions(+), 112 deletions(-)
>  create mode 100644 drivers/usb/chipidea/otg.c
>  create mode 100644 drivers/usb/chipidea/otg.h
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
