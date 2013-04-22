From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Apr 2013 14:52:43 +0300
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <20130422082149.GK10536@arwen.pp.htv.fi>
References: <5170B4C6.1030300@gmail.com> <20130419161257.GI10155@atomide.com>
 <5174E58D.8080800@ti.com> <20130422082149.GK10536@arwen.pp.htv.fi>
Message-ID: <20130422115243.GD10797@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 22, 2013 at 11:21:49AM +0300, Felipe Balbi wrote:
> > -Kevin Hilman <khilman@ti.com>
> > +Kevin Hilman <khilman@deeprootsystems.com>
> > 
> > On 04/19/2013 07:12 PM, Tony Lindgren wrote:
> > > * Rob Herring <robherring2@gmail.com> [130418 20:11]:
> > >> Current errors in linux-next for ARM multi-platform randconfig builds.
> > >>
> > >> Rob
> > >>
> > >> arch/arm/mach-omap2/built-in.o:dss-common.c:(.init.text+0x6830): more undefined references to `usb_bind_phy' follow
> > > 
> > > Felipe & Roger, can you guys take a look at the usb_bind_phy issue
> > > in linux next? I have not seen that in the multiplatform randconfigs
> > > I've built, but I have had some omap2+ specific things enabled there.
> > 
> > These problems happen if USB_PHY is not enabled as a built-in driver.
> > I had pointed this out earlier [1] and Felipe should have a fix for it.
> 
> yeah, ideally we wouldn't do any 'select' and just update defconfig with
> the necessary changes. We need the patch below to update defconfig and
> another patch to stub out usb_bind_phy when !USB_PHY.

the stub is already there, this should fix the other part though:

8< --------------- cut here ----------------------

>From b2ead0f71d62ff896bd035c92f1216dba4eb3385 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Mon, 22 Apr 2013 14:50:56 +0300
Subject: [PATCH] usb: phy: remove bogus __init annotation

there's no guarantee that usb_bind_phy() will
always be called from initialization time.

Leaving that __init section annotation leads
to undefined references build errors. Remove it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index f52c006..a9984c7 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -413,7 +413,7 @@ EXPORT_SYMBOL_GPL(usb_remove_phy);
  *
  * To be used by platform specific initialization code.
  */
-int __init usb_bind_phy(const char *dev_name, u8 index,
+int usb_bind_phy(const char *dev_name, u8 index,
 				const char *phy_dev_name)
 {
 	struct usb_phy_bind *phy_bind;
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130422/037a93b9/attachment-0001.sig>
