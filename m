From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Apr 2013 11:21:49 +0300
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <5174E58D.8080800@ti.com>
References: <5170B4C6.1030300@gmail.com> <20130419161257.GI10155@atomide.com>
 <5174E58D.8080800@ti.com>
Message-ID: <20130422082149.GK10536@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 22, 2013 at 10:23:57AM +0300, Roger Quadros wrote:
> -Kevin Hilman <khilman@ti.com>
> +Kevin Hilman <khilman@deeprootsystems.com>
> 
> On 04/19/2013 07:12 PM, Tony Lindgren wrote:
> > * Rob Herring <robherring2@gmail.com> [130418 20:11]:
> >> Current errors in linux-next for ARM multi-platform randconfig builds.
> >>
> >> Rob
> >>
> >> arch/arm/mach-omap2/built-in.o:dss-common.c:(.init.text+0x6830): more undefined references to `usb_bind_phy' follow
> > 
> > Felipe & Roger, can you guys take a look at the usb_bind_phy issue
> > in linux next? I have not seen that in the multiplatform randconfigs
> > I've built, but I have had some omap2+ specific things enabled there.
> 
> These problems happen if USB_PHY is not enabled as a built-in driver.
> I had pointed this out earlier [1] and Felipe should have a fix for it.

yeah, ideally we wouldn't do any 'select' and just update defconfig with
the necessary changes. We need the patch below to update defconfig and
another patch to stub out usb_bind_phy when !USB_PHY.

8< ---------------------- cut here -------------------------------------

>From 3062dbf02d0f677aabd5c12333e446ab0c13afc0 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Mon, 22 Apr 2013 11:10:23 +0300
Subject: [PATCH] arm: defconfigs: add USB_PHY to omap2plus_defconfig

without USB_PHY (and a few PHY drivers) we won't
have functional USB on any OMAP platform.

Enable some sensible defaults so omap2plus_defconfig
works for most platforms.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index bd07864..8c243ac 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -74,6 +74,7 @@ CONFIG_CMA=y
 CONFIG_CONNECTOR=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_OMAP_OCP2SCP=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
@@ -205,6 +206,11 @@ CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_LIBUSUAL=y
 CONFIG_USB_TEST=y
+CONFIG_USB_PHY=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_OMAP_USB2=y
+CONFIG_OMAP_USB3=y
+CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
-- 
1.8.2


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130422/61ed6eae/attachment.sig>
