From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 08:53:08 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130214222247.GE11362@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
Message-ID: <20130215065308.GC30038@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 02:22:47PM -0800, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [130214 12:51]:
> > Hi,
> > 
> > On Thu, 14 Feb 2013, Tony Lindgren wrote:
> > 
> > > I don't think so as hwmod should only touch the sysconfig space
> > > when no driver has claimed it.
> > 
> > hwmod does need to touch the SYSCONFIG register during pm_runtime suspend 
> > and resume operations, and during device enable and disable operations.  
> > Here's the relevant code:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2157
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2195
> 
> But that's triggered by runtime PM from the device driver, right?
> 
> I think it's fine for hwmod to do that as requested by the device
> driver via runtime PM since hwmod is the bus glue making the drivers arch
> independent.
> 
> I think the only piece we're missing for that is for driver to run
> something like pm_runtime_init() that initializes the address space
> to hwmod. Or just bus specific ioremap like you're suggesting later
> on.
> 
> Just to recap what we've discussed earlier, the reasons why we want
> reset and idle functions should be in the driver specific header are:
> 
> 1. There's often driver specific logic needed in addition to the
>    syconfig tinkering in the reset/idle functions.

how about introducing generic device_reset() and device_idle() hooks
which driver can implement and can be called by bus glue ?

Something like:


diff --git a/include/linux/pm.h b/include/linux/pm.h
index 03d7bb1..9c921e2 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -256,6 +256,8 @@ typedef struct pm_message {
  *	these conditions and handle the device as appropriate, possibly queueing
  *	a suspend request for it.  The return value is ignored by the PM core.
  *
+ * @runtime_reset: Resets the device and puts it in a known state.
+ *
  * Refer to Documentation/power/runtime_pm.txt for more information about the
  * role of the above callbacks in device runtime power management.
  *
@@ -285,6 +287,7 @@ struct dev_pm_ops {
 	int (*runtime_suspend)(struct device *dev);
 	int (*runtime_resume)(struct device *dev);
 	int (*runtime_idle)(struct device *dev);
+	int (*runtime_reset)(struct device *dev);
 };
 
 #ifdef CONFIG_PM_SLEEP


We already have ->runtime_idle() which we could be using...

> 2. We need to be able to reset and idle some hardware even if the
>    driver is not compiled in.

yeah, this will be tricky. Even if you try late_initcall() there could
still be issues with -EPROBE_DEFER. Maybe you don't need to reset the
IPs but rather put those which have status = "disabled" to FORCE_IDLE.

Wouldn't that be enough ? If a driver claims the device later, then
pm_runtime_enable() + pm_runtime_get() will change that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/83010646/attachment.sig>
