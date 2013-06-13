From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Jun 2013 10:33:43 -0400 (EDT)
Subject: [PATCH 10/10] USB: OHCI: Properly handle ohci-spear suspend
In-Reply-To: <CAKohpo=QdPFfcJzDFfH34t2b4QY-vqxCc4hk2KhoGnB_u9QudQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306131029230.1561-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Viresh Kumar wrote:

> > +       bool do_wakeup = device_may_wakeup(&pdev->dev);
> > +       int ret;
> > +
> > +       ret = ohci_suspend(hcd, do_wakeup);
> > +       if (ret == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
> 
> maybe s/ret == 0/!ret

I tend to prefer using ! for boolean values and == 0 for numeric 
values.  Just a matter of personal taste.

> I thought ret == 0 is the success case and not error case.
> 
> > +               ohci_resume(hcd, false);
> > +               ret = -EBUSY;
> > +       }

Yes, 0 is the success case.  You must not have seen the explanation for
this code; it is needed to handle a race.  If the suspend succeeds but
a wakeup request has already arrived, we need to undo the suspend.  
Obviously, if the suspend failed then there's no need to undo anything.

Alan Stern
