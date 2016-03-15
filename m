From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 15 Mar 2016 14:08:26 +0530
Subject: [RFC PATCH 0/4] Implement USB device/host switch for Vybrid
Message-ID: <cover.1458030082.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

The existing usage of extcon in Chipidea driver relies on OTG
registers. In case of SoC with dual role device but not a true
OTG controller, this does not work. Such SoC's should specify
the existing CI_HDRC_DUAL_ROLE_NOT_OTG flag and do the role
switch without checking any of the OTG registers in my opinion.
This is the case for Vybrid which uses a Chipidea IP but does
not have a true 5 pin OTG implemented.

This patch almost reverts most of commit 3ecb3e09b042e70799ff3a1ff464a5ecaa7547d9
"usb: chipidea: Use extcon framework for VBUS and ID detect".
We do not rely anymore on emulating an OTG capable controller
by faking OTG controller reads.

Observations without the following patchset with the current
implementation.

CONFIG_USB_OTG was kept selected. Just the device tree changes
done in the fourth patch of this patch were done.

1. Booting with the USB device connected and then disconnecting
on boot results in "irq 38: nobody cared (try booting with the
"irqpoll" option)" stack trace.

2. Disconnecting the USB device and reconnecting results in a
timeout error message coming ci_handle_id_switch --> hw_wait_reg
while waiting for OTGSC_BSV register field. Why rely on a read
from OTG register while using extcon?

Also, usb_gadget_vbus_connect seems not to be called, render device
mode useless (usb_gadget_vbus_connect according to my understanding
should be called through ci_vbus_notifier -> ci_irq -> ci_otg_work ->
ci_handle_vbus_change).

3. Once in a while doing the switch from host to device would
result "ci_hdrc.0 Freeing queued request" but the switch won't
be successful as expected and I wont get the following message

[  167.298040] ci_hdrc ci_hdrc.0: USB bus 2 deregistered
[  167.772520] configfs-gadget gadget: high-speed config #1: c

and further our RNDIS client configuration on said USB connection
won't work. Once in a while I also experience a complete freeze
if I try to ping the interface after this.

4. With the current "OTG" implementation, should the ci->lock not
be acquired before calling ci_role_stop or ci_role_start in the
code path ci_id_notifier -> ci_irq -> otg_workqueue?

Looking at the commit message this extcon was introduced for Qualcomm's
410 Dragonboard and while I did not look at Dragonboard's or 410's DS,
requirement seems similar to Vybrid.?

What are your thoughts on this? Or considering the requirement of Qualcomm
would keeping direct role switch in case of DUAL_ROLE_NOT_OTG flag
and keeping existing OTG reads would be acceptable? Currently in our tree
we keep both implementations. The 410 is a 64bit SoC but grepping arch/
arm64/boot/dts/qcom for an extcon entry I didn't find any.

Regards,
Sanchayan.

Sanchayan Maity (4):
  usb: chipidea: Do not rely on OTG while using extcon
  usb: chipidea: ci_hdrc_imx: Introduce CI_HDRC_DUAL_ROLE_NOT_OTG for Vybrid
  ARM: dts: vfxxx: Make Vybrid match only on it's own compatible string
  ARM: dts: vf-colibri: USB device/host switch using extcon gpio

 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 12 ++++++
 arch/arm/boot/dts/vf-colibri.dtsi         |  7 ++++
 arch/arm/boot/dts/vfxxx.dtsi              |  2 +-
 drivers/usb/chipidea/ci_hdrc_imx.c        |  5 +++
 drivers/usb/chipidea/core.c               | 64 +++++++++++++++++--------------
 drivers/usb/chipidea/otg.c                | 39 +------------------
 include/linux/usb/chipidea.h              |  2 -
 7 files changed, 61 insertions(+), 70 deletions(-)

-- 
2.7.3
