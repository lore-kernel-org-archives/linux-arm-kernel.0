From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Jan 2015 10:46:31 -0600
Subject: Regression with legacy IRQ numbers caused by 9a1091ef0017
In-Reply-To: <20150116164105.GL18552@atomide.com>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
 <20150115171924.GV11502@n2100.arm.linux.org.uk>
 <20150116162119.GK18552@atomide.com>
 <20150116163019.GW11502@n2100.arm.linux.org.uk>
 <20150116164105.GL18552@atomide.com>
Message-ID: <20150116164631.GI16782@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 08:41:06AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150116 08:33]:
> > On Fri, Jan 16, 2015 at 08:21:20AM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 09:22]:
> > > > On Thu, Jan 15, 2015 at 07:28:39AM -0800, Tony Lindgren wrote:
> > > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 02:53]:
> > > > > > I don't think we've proven a link there.  While you're right that it
> > > > > > causes the wrong interrupt to be claimed, I have two kernels here,
> > > > > > both claim the same interrupt, one which is multi-platform and issues
> > > > > > that strange warning, and one which targets only OMAP4 which doesn't.
> > > > > > 
> > > > > > There's something else going on which causes the bus errors which we
> > > > > > haven't found.
> > > > > 
> > > > > I think it gets triggered if you enable PREEMPT.
> > > > 
> > > > That's something which we can try to prove... build running now with
> > > > CONFIG_PREEMPT=y
> > > 
> > > Looks like you now have the omap_l3_noc error appear for sdp4430 in
> > > your logs after enabling PREEMPT.
> > > 
> > > I guess that means case closed for this one?
> > 
> > I would still like to understand /why/ enabling preempt causes the error.
> > Changing the preempt configuration really should not change what happens
> > on the bus.  (Think about it.)  It's an indication that there is some
> > other error present.
> 
> We have a wrong irq number caused by $subject. And the wrong irq
> gets triggered before the dma hardware is configured during dma
> init. And then we get the invalid access error from omap_l3_noc.
> 
> > Unfortunately, the OMAP hardware appears to make it impossible to
> > determine what the access that caused the error was, so it looks like
> > it's pretty much undebuggable.
> 
> Yeah would be nice to have more info from omap_l3_noc.

you can probably get more info by decoding all L4 instance errors. It's
just not implemented anywhere. In this case, we should decode l4cfg
which is who generated the error.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/691a076c/attachment.sig>
