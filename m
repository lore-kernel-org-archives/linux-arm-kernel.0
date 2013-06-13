From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Jun 2013 15:52:16 -0400 (EDT)
Subject: [PATCH V2 05/10] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <9340690.Y20fM6tyU7@flatron>
Message-ID: <Pine.LNX.4.44L0.1306131542080.1561-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Tomasz Figa wrote:

> > +	rc = ohci_suspend(hcd, do_wakeup);
> > +	if (rc == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
> > +		ohci_resume(hcd, false);
> > +		rc = -EBUSY;
> > +	}
> 
> I'm not into USB host subsystem, so I might just ask a stupid question.
> 
> Can't we make ohci_suspend check this for us, so the drivers would just 
> check for error code? It seems like in all your patches this part of code 
> is duplicated, looking as a good candidate to be generic.

Argh!  You're right, of course.

I didn't see it, because the only existing place where this check is 
made is in the PCI glue layer.  Pushing it into the HCDs themselves is 
obviously the right thing to do.

Manjanuth, let's do this.  You can write a preliminary patch that puts 
this check at the end of the ohci_suspend() routine, and then resubmit 
your series.

Alan Stern
