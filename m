From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 05 Oct 2012 06:42:03 +1300
Subject: usb: uhci-platform driver fails after patch changes during merge
In-Reply-To: <20121004142617.GA26625@kroah.com>
References: <1349332691.7583.3.camel@gitbox>
 <1349333716.7905.1.camel@gitbox> <20121004142617.GA26625@kroah.com>
Message-ID: <1349372523.8451.10.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-04 at 07:26 -0700, Greg KH wrote:
> On Thu, Oct 04, 2012 at 07:55:16PM +1300, Tony Prisk wrote:
> > On Thu, 2012-10-04 at 19:38 +1300, Tony Prisk wrote:
> > > Mike,
> > > 
> > > I see someone made changes to the uhci-platform.c driver I submitted
> > > during v3.7 which results in it not working on mach-vt8500.
> > > 
> > > Could you clarify why the changes were made, and what the suggested
> > > resolution would be to solve the problem that it introduced?
> > > 
> > > Lines indicated by ---> below were removed from the patch, which means
> > > that on arch-vt8500 there is no dma_mask set, and its fails to
> > > communicate with attached devices.
> > > 
> > > Regards
> > > 
> > > Tony P
> > > 
> > > 
> > > static int __devinit uhci_hcd_platform_probe(struct platform_device
> > > *pdev)
> > > ...
> > > 	if (usb_disabled())
> > > 		return -ENODEV;
> > > --->
> > > 	/* Right now device-tree probed devices don't get dma_mask set.
> > > 	 * Since shared usb code relies on it, set it here for now.
> > > 	 * Once we have dma capability bindings this can go away.
> > > 	 */
> > > 	if (!pdev->dev.dma_mask)
> > > 		pdev->dev.dma_mask = &platform_uhci_dma_mask;
> > > --->
> > > 	hcd = usb_create_hcd(&uhci_platform_hc_driver, &pdev->dev,
> > > 				pdev->name);
> > > ...
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> > Greg,
> > 
> > This message was intended for you rather than Mike. Could you clarify
> > what happened and the expected resolution?
> 
> I don't know, this should be directed at the person who made the change
> that is causing the problem, and the linux-usb at vger.kernel.org mailing
> list.
> 
> Who changed the patch?  What patch exactly are you referring to?  Who
> signed off on it?  Where was it discussed?
> 
> thanks,
> 
> greg k-h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Greg,

Thats the problem I have - I can't track where the changes came from.

The commit details show:

author
Tony Prisk
<linux@prisktech.co.nz>


Sat, 21 Jul 2012
10:58:53 +0000 (22:58
+1200)
committer
Greg Kroah-Hartman
<gregkh@linuxfoundation.org>


Thu, 16 Aug 2012
21:00:37 +0000 (14:00
-0700)
commit
100d45970327f78584ff4846deeca14bba511e28

But this file -
drivers/usb/host/uhci-platform.c

isn't the version I supplied in the patchset. There are no other commits
against it so I assume it was changed before it was committed.

Confused?!?

Regards

Tony P
