From: marex@denx.de (Marek Vasut)
Date: Thu, 20 Sep 2012 18:33:38 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <505B1FC2.2090609@free-electrons.com>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
 <201209201510.24631.marex@denx.de> <505B1FC2.2090609@free-electrons.com>
Message-ID: <201209201833.38960.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

> Hi Marek,
> 
> Le 20/09/2012 15:10, Marek Vasut a ?crit :
> >>> If barebox can't handle even basic DT fixup, it's broken.
> >> 
> >> It can. It maybe was just not needed up to now, dunno.
> > 
> > Fix it and send patch, so this problem doesn't spread.
> 
> I'm sorry, but you still miss the point.
> 
> If someone wants to use another bootloader than U-boot (or a possible
> patched barebox), or none other than the bootlets to boot directly the
> Linux (with an appended device tree), you will still have no way to get
> the NIC from the OCOTP, and I'm sorry, but it is just wrong.
> 
> The kernel shouldn't rely on a particular feature of a given bootloader.

So what do you think about this patch (skip loading from OCOTP if it's already 
present in DT):

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 71d47f5..4f014ef 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -175,6 +175,10 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
                np = of_find_compatible_node(from, NULL, "fsl,imx28-fec");
                if (!np)
                        return;
+
+               if (of_get_property(np, "local-mac-address", NULL))
+                       continue;
+
                from = np;
 
                newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);


Best regards,
Marek Vasut
