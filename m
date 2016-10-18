From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:26 -0700
Subject: [PATCH v5 13/23] usb: chipidea: msm: Rely on core to override AHBBURST
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-14-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core framework already handles setting this parameter with a
platform quirk. Add the appropriate flag so that we always set
AHBBURST to 0. Technically DT should be doing this, but we always
do it for msm chipidea devices so setting the flag in the driver
works just as well. If the burst needs to be anything besides 0,
we expect the 'ahb-burst-config' dts property to be present.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 89c1a02d69b5..719b20caf88e 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -24,7 +24,6 @@ static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 	switch (event) {
 	case CI_HDRC_CONTROLLER_RESET_EVENT:
 		dev_dbg(dev, "CI_HDRC_CONTROLLER_RESET_EVENT received\n");
-		writel(0, USB_AHBBURST);
 		/* use AHB transactor, allow posted data writes */
 		writel(0x8, USB_AHBMODE);
 		usb_phy_init(ci->usb_phy);
@@ -47,7 +46,8 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
 	.name			= "ci_hdrc_msm",
 	.capoffset		= DEF_CAPOFFSET,
 	.flags			= CI_HDRC_REGS_SHARED |
-				  CI_HDRC_DISABLE_STREAMING,
+				  CI_HDRC_DISABLE_STREAMING |
+				  CI_HDRC_OVERRIDE_AHB_BURST,
 
 	.notify_event		= ci_hdrc_msm_notify_event,
 };
-- 
2.10.0.297.gf6727b0
