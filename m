From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 23:59:26 +0300
Subject: [PATCH 6/7] watchdog: OMAP: use standard GETBOOTSTATUS
 interface; use platform_data fn ptr
In-Reply-To: <alpine.DEB.2.00.1210252028330.21193@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013233.21844.1279.stgit@dusk.lan>
 <50899DB9.8050308@ti.com>
 <alpine.DEB.2.00.1210252015490.21193@utopia.booyaka.com>
 <alpine.DEB.2.00.1210252028330.21193@utopia.booyaka.com>
Message-ID: <20121025205926.GA19439@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 08:29:26PM +0000, Paul Walmsley wrote:
> On Thu, 25 Oct 2012, Paul Walmsley wrote:
> 
> > On Thu, 25 Oct 2012, Jon Hunter wrote:
> > 
> > > In the case of booting with device-tree, pdata could be null and so
> > > should we check for this too? In other words ...
> > > 
> > > +		if (!pdata || !pdata->read_reset_sources)
> > > +			return put_user(0, (int __user *)arg);
> > 
> > Thanks, good catch, will integrate that fix.
> 
> Here's the updated patch.
> 
> - Paul
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sun, 7 Oct 2012 20:13:26 -0600
> Subject: [PATCH] watchdog: OMAP: use standard GETBOOTSTATUS interface; use
>  platform_data fn ptr
> 
> Previously the OMAP watchdog driver used a non-standard way to report
> the chip reset source via the GETBOOTSTATUS ioctl.  This patch
> converts the driver to use the standard WDIOF_* flags for this
> purpose.
> 
> This patch may break existing userspace code that uses the existing
> non-standard data format returned by the OMAP watchdog driver's
> GETBOOTSTATUS ioctl.  To fetch detailed reset source information,
> userspace code will need to retrieve it directly from the CGRM or PRM
> drivers when those are completed.
> 
> Previously, to fetch the reset source, the driver either read a
> register outside the watchdog IP block (OMAP1), or called a function
> exported directly from arch/arm/mach-omap2.  Both approaches are
> broken.  This patch also converts the driver to use a platform_data
> function pointer.  This approach is temporary, and is due to the lack
> of drivers for the OMAP16xx+ Clock Generation and Reset Management IP
> block and the OMAP2+ Power and Reset Management IP block.  Once
> drivers are available for those IP blocks, the watchdog driver can be
> converted to call exported drivers from those functions directly.

should be "exported functions from those drivers directly."

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/83e5922c/attachment-0001.sig>
