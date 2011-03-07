From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Mar 2011 12:07:32 -0000
Subject: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way
	operationcan	cause data corruption
In-Reply-To: <69dd173e3c7b4d02ef50ceaa19b2343a@mail.gmail.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>	<1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>	<20110227120021.GA15314@n2100.arm.linux.org.uk>	<20110228101351.GA30781@n2100.arm.linux.org.uk>
	<69dd173e3c7b4d02ef50ceaa19b2343a@mail.gmail.com>
Message-ID: <000a01cbdcc0$3d0dfeb0$b729fc10$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

> > On Sun, Feb 27, 2011 at 12:00:21PM +0000, Russell King - ARM Linux
> > wrote:
> > > > +#else
> > > > +/* Optimised out for non-errata case */
> > > > +static inline void debug_writel(unsigned long val)
> > > > +{
> > > >  }
> > >
> > > #define l2x0_set_debug	NULL
> > >
> > > > +#endif
> >
> > I notice you got rid of the inline function.  Have you tried
> > building this without the errata enabled?
> 
> I accidently dropped the inline function while
> incorporating the comment from you. :(
> 
> Fixed it. Updated version # 6770/1

This version of the patch (as it appears in -next) is broken:


+#define debug_writel(val)	outer_cache.set_debug(val)
+
+static void l2x0_set_debug(unsigned long val)
+{
+	writel(val, l2x0_base + L2X0_DEBUG_CTRL);
 }

[...]

@@ -119,9 +120,11 @@ static void l2x0_flush_all(void)
 
 	/* clean all ways */
 	spin_lock_irqsave(&l2x0_lock, flags);
+	debug_writel(0x03);
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
 	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
 	cache_sync();
+	debug_writel(0x00);
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }


This deadlocks because the writel forces an outer cache sync, which
then tries to acquire the spinlock which is held by the calling
function.

If you change l2x0_set_debug to use writel_relaxed then you can avoid
the problem.

Will
