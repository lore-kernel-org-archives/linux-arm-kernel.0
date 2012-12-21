From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Dec 2012 07:24:14 -0200
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <20121221022249.GA16251@nchen-desktop>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
 <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
 <20121220043943.GA992@nchen-desktop>
 <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
 <CAOMZO5B5hv+oG+8fQYyFxRb=VLOiPmC8+0LhAFLOOzBY4z6PZA@mail.gmail.com>
 <CAOMZO5Dhasq11fyJj73_UcyVdoz-N0MAHBu0=PQUxRn42VOdkw@mail.gmail.com>
 <20121221022249.GA16251@nchen-desktop>
Message-ID: <CAOMZO5B3EXOB4ijh0LOhvU4g67kdz8KSXw8dvS2dOD1anu_8Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Dec 21, 2012 at 12:22 AM, Peter Chen <peter.chen@freescale.com> wrote:

> Current chipidea driver only considers disable stream mode at device
> mode, in fact, it may be related to below chipidea bug, and needs
> to consider all usb modes.
>
> STAR 9000378958
> Title: Non-Double Word Aligned Buffer Address Sometimes Causes Host to Hang on OUT Retry
> www.synopsys.com/dw/star.php?c=dwc_usb2_hs_otg_controller&fixedIn=2.20a
>
> To fix this, we need to add CI13XXX_DISABLE_STREAMING after role->start/init.

Yes, setting CI13XXX_DISABLE_STREAMING inside ci_role_start does work.

If you think the patch below is fine I can properly submit it.

---
 drivers/usb/chipidea/ci.h |   39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index e25d126..7fe652a 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -18,6 +18,8 @@
 #include <linux/usb.h>
 #include <linux/usb/gadget.h>

+#define USBMODE_CI_SDIS       BIT(4)
+
 /******************************************************************************
  * DEFINE
  *****************************************************************************/
@@ -173,22 +175,6 @@ static inline struct ci_role_driver
*ci_role(struct ci13xxx *ci)
 	return ci->roles[ci->role];
 }

-static inline int ci_role_start(struct ci13xxx *ci, enum ci_role role)
-{
-	int ret;
-
-	if (role >= CI_ROLE_END)
-		return -EINVAL;
-
-	if (!ci->roles[role])
-		return -ENXIO;
-
-	ret = ci->roles[role]->start(ci);
-	if (!ret)
-		ci->role = role;
-	return ret;
-}
-
 static inline void ci_role_stop(struct ci13xxx *ci)
 {
 	enum ci_role role = ci->role;
@@ -307,6 +293,27 @@ static inline u32 hw_test_and_write(struct
ci13xxx *ci, enum ci13xxx_regs reg,
 	return (val & mask) >> ffs_nr(mask);
 }

+
+static inline int ci_role_start(struct ci13xxx *ci, enum ci_role role)
+{
+	int ret;
+
+	if (role >= CI_ROLE_END)
+		return -EINVAL;
+
+	if (!ci->roles[role])
+		return -ENXIO;
+
+	ret = ci->roles[role]->start(ci);
+	if (!ret)
+		ci->role = role;
+
+	if (ci->platdata->flags & CI13XXX_DISABLE_STREAMING)
+		hw_write(ci, OP_USBMODE, USBMODE_CI_SDIS, USBMODE_CI_SDIS);
+
+	return ret;
+}
+
 int hw_device_reset(struct ci13xxx *ci, u32 mode);

 int hw_port_test_set(struct ci13xxx *ci, u8 mode);
--
