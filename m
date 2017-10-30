From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Oct 2017 10:10:37 -0700
Subject: [bug report] ARM: OMAP2+: Populate legacy resources for dma and
 smartreflex
In-Reply-To: <20171027225048.GG21504@atomide.com>
References: <20171027064440.i5zf4fwsdj3phwuy@mwanda>
 <20171027225048.GG21504@atomide.com>
Message-ID: <20171030171037.GB7339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [171027 22:52]:
> * Dan Carpenter <dan.carpenter@oracle.com> [171026 23:46]:
> > Hello Tony Lindgren,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch d85a2d61432a: "ARM: OMAP2+: Populate legacy resources for 
> > dma and smartreflex" from Oct 10, 2017, leads to the following Smatch 
> > complaint:
> > 
> > arch/arm/mach-omap2/omap_device.c:453 omap_device_copy_resources()
> > 	 error: we previously assumed 'oh' could be null (see line 394)
> > 
> > arch/arm/mach-omap2/omap_device.c
> >    393	
> >    394		if (!oh || !oh->od || !oh->od->pdev) {
> >                     ^^^
> > Patch adds check for NULL.
> > 
> >    395			error = -EINVAL;
> >    396			goto error;
> >    397		}
> >    398	
> > 
> > [ snip ]
> > 
> >    448	
> >    449	free:
> >    450		kfree(res);
> >    451	
> >    452	error:
> >    453		WARN(error, "%s: %s device %s failed: %i\n",
> >    454		     __func__, oh->name, dev_name(&pdev->dev),
> >                                ^^^^^^^^
> > and the patch adds a dereference.
> > 
> >    455		     error);
> 
> Thanks, looks like we should just return early there. I'll send
> a fix for this.

And here's the patch to fix it.

Regards,

Tony

8< -------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 30 Oct 2017 10:01:39 -0700
Subject: [PATCH] ARM: OMAP2+: Fix smatch found issue for omap_device

The patch d85a2d61432a: "ARM: OMAP2+: Populate legacy resources for
dma and smartreflex" from Oct 10, 2017, leads to the following Smatch
complaint:

arch/arm/mach-omap2/omap_device.c:453 omap_device_copy_resources()
         error: we previously assumed 'oh' could be null (see line 394)

Fixes: d85a2d61432a: ("ARM: OMAP2+: Populate legacy resources for dma
and smartreflex")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -391,10 +391,8 @@ omap_device_copy_resources(struct omap_hwmod *oh,
 	const char *name;
 	int error, irq = 0;
 
-	if (!oh || !oh->od || !oh->od->pdev) {
-		error = -EINVAL;
-		goto error;
-	}
+	if (!oh || !oh->od || !oh->od->pdev)
+		return -EINVAL;
 
 	np = oh->od->pdev->dev.of_node;
 	if (!np) {
-- 
2.14.3
