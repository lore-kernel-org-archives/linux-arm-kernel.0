From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 10 Mar 2018 12:26:34 +0100
Subject: Nokia N900: refcount_t underflow, use after free
In-Reply-To: <c8ee5692-bf71-a9d7-8607-50adc9f0e9f1@ti.com>
References: <20180308143053.GA17267@amd> <20180308165903.GM5799@atomide.com>
 <57c9f17b-fc9d-8506-4b5d-70ac216c9248@ti.com>
 <20180308185046.GA22796@amd>
 <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
 <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com>
 <20180309221834.GA15476@amd>
 <c8ee5692-bf71-a9d7-8607-50adc9f0e9f1@ti.com>
Message-ID: <20180310112634.GA31614@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> Well, there certainly seems to be an obvious bug wherein
> >>> isp_detach_iommu() just releases the mapping directly without calling
> >>> arm_iommu_detach_device() to balance the equivalent attach. That can't
> >>> be helping.
> >>
> >> Indeed, I have been able to reproduce the same warning using a
> >> standalone test module, and the missing arm_iommu_detach_device() is
> >> causing the warning after probe (during failure path) or during
> >> remove.
> > 
> > Ok do you have an idea how to fix the isp error paths? Untested patch
> > would be fine... But it seems that you know what needs to be fixed and
> > I don't.
> > 
> 
> OK, see if the following fixes the issue for you, only build tested.

Word-wrapped, so I applied by hand. And yes, the oops at boot is
gone. Thanks!

(Camera still does not work in -next... kills system. Oh well. Lets
debug that some other day.)

> 8< ---------------------
> >From bac9a48fb646dc51f2030d676a0dbe3298c3b134 Mon Sep 17 00:00:00 2001
> From: Suman Anna <s-anna@ti.com>
> Date: Fri, 9 Mar 2018 16:39:59 -0600
> Subject: [PATCH] media: omap3isp: fix unbalanced dma_iommu_mapping
> 
> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
> ARM DMA backend. The current code creates a dma_iommu_mapping and
> attaches this to the ISP device, but never detaches the mapping in
> either the probe failure paths or the driver remove path resulting
> in an unbalanced mapping refcount and a memory leak. Fix this properly.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Suman Anna <s-anna@ti.com>

Tested-by: Pavel Machek <pavel@ucw.cz>
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180310/85acc094/attachment.sig>
