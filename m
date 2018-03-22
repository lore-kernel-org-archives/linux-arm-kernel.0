From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 22 Mar 2018 14:06:39 +0100
Subject: [PATCH v2] usb: dwc2: dwc2_vbus_supply_init: fix error check
In-Reply-To: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
Message-ID: <20180322130639.9957-1-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_regulator_get_optional returns -ENODEV if the regulator isn't
there, so if that's the case we have to make sure not to leave -ENODEV
in the regulator pointer.

Also, make sure we return 0 in that case, but correctly propagate any
other errors. Also propagate the error from _dwc2_hcd_start.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus supply")
Cc: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

v2: Only overwrite the error in the pointer after checking it (Heiko
    St?bner <heiko@sntech.de>)
---
 arch/arm/configs/multi_v7_defconfig |  3 +++
 drivers/usb/dwc2/hcd.c              | 11 +++++++----
 scripts/setlocalversion             |  9 ---------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 846ce7bb24bc..33148fcabd17 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1029,3 +1029,6 @@ CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_PCI_LEGACY=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_LOCALVERSION_AUTO=n
+CONFIG_LOCALVERSION=""
+
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index dcfda5eb4cac..863aed20517f 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -359,8 +359,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
 {
 	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
-	if (IS_ERR(hsotg->vbus_supply))
+	if (PTR_ERR(hsotg->vbus_supply) == -ENODEV) {
+		hsotg->vbus_supply = NULL;
 		return 0;
+	} else if (IS_ERR(hsotg->vbus_supply)) {
+		hsotg->vbus_supply = NULL;
+		return PTR_ERR(hsotg->vbus_supply);
+	}
 
 	return regulator_enable(hsotg->vbus_supply);
 }
@@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	dwc2_vbus_supply_init(hsotg);
-
-	return 0;
+	return dwc2_vbus_supply_init(hsotg);
 }
 
 /*
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 71f39410691b..cbc36d3b4d0f 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -161,15 +161,6 @@ res="${res}${CONFIG_LOCALVERSION}${LOCALVERSION}"
 if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
 	# full scm version string
 	res="$res$(scm_version)"
-else
-	# append a plus sign if the repository is not in a clean
-	# annotated or signed tagged state (as git describe only
-	# looks at signed or annotated tags - git tag -a/-s) and
-	# LOCALVERSION= is not specified
-	if test "${LOCALVERSION+set}" != "set"; then
-		scm=$(scm_version --short)
-		res="$res${scm:++}"
-	fi
 fi
 
 echo "$res"
-- 
2.14.3
