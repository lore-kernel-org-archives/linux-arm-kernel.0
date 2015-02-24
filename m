From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Feb 2015 08:46:39 -0600
Subject: New l3-noc error with CPUFREQ_DT built-in with v4.0-rc1
In-Reply-To: <20150224032450.GT32521@atomide.com>
References: <20150223235947.GC25954@atomide.com>
 <20150224015903.GP32521@atomide.com>
 <20150224022433.GB5198@saruman.tx.rr.com>
 <20150224023505.GQ32521@atomide.com>
 <20150224030141.GR32521@atomide.com>
 <20150224031547.GB15941@saruman.tx.rr.com>
 <20150224032107.GS32521@atomide.com>
 <20150224032450.GT32521@atomide.com>
Message-ID: <20150224144639.GE29829@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 23, 2015 at 07:24:50PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150223 19:29]:
> > * Felipe Balbi <balbi@ti.com> [150223 19:19]:
> > > On Mon, Feb 23, 2015 at 07:01:42PM -0800, Tony Lindgren wrote:
> > > > * Tony Lindgren <tony@atomide.com> [150223 18:43]:
> > > > 
> > > > Looks like the address is 0 for "Custom Error". Anyways, reverting
> > > 
> > > yeah, that's because the error comes from l4per2, not l3 :-)
> > 
> > Right so it seems :)
> >  
> > > > a fix for similar issue found on omap3 so far seems to help, that's
> > > > 3d009c8c61f9 ("gpio: omap: Fix bad device access with setup_irq()").
> > > 
> > > if we revert that, we regress omap3, right ?
> > 
> > Yes we saw that getting triggered on omap3/4 before 3d009c8c61f9.
> > 
> > Now looking at the stack trace again, it actually has something:
> > 
> > ...
> > [<c05999a4>] (__irq_svc) from [<c0599164>] (_raw_spin_unlock_irqrestore+0x34/0x44)
> > [<c0599164>] (_raw_spin_unlock_irqrestore) from [<c0027120>] (omap_hwmod_idle+0x34/0x44)
> > [<c0027120>] (omap_hwmod_idle) from [<c00283f8>] (omap_device_idle+0x38/0x78)
> > [<c00283f8>] (omap_device_idle) from [<c0028454>] (_od_runtime_suspend+0x1c/0x24)
> > [<c0028454>] (_od_runtime_suspend) from [<c03b5214>] (__rpm_callback+0x2c/0x60)
> > [<c03b5214>] (__rpm_callback) from [<c03b5268>] (rpm_callback+0x20/0x80)
> > [<c03b5268>] (rpm_callback) from [<c03b56b8>] (rpm_suspend+0xe8/0x55c)
> > [<c03b56b8>] (rpm_suspend) from [<c03b6bdc>] (pm_runtime_work+0x74/0xa8)
> > [<c03b6bdc>] (pm_runtime_work) from [<c0054608>] (process_one_work+0x1b0/0x4a0)
> > ...
> > 
> > If it's the gpio-omap, there's probably some confusion still in
> > the driver regarding the GPIO bank idle status. Anyways, will look
> > more into it tomorrow.
> 
> And now I'm seeing the error with 3d009c8c61f9 reverted, so it
> does not seem to be that either..

well, that's good :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/9fbfc700/attachment.sig>
