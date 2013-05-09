From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 9 May 2013 11:54:42 -0400 (EDT)
Subject: [RFC PATCH 1/2] USB: OHCI: prepare to make ohci-hcd a library
 module
In-Reply-To: <CAJFYCKGSctw1_nXoETYwyVkgAncHyBb8dmZ9aBV-av=8S0rw4A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1305091108130.1796-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 May 2013, Manjunath Goudar wrote:

> > > @@ -767,7 +762,37 @@ retry:
> > >
> > >       return 0;
> > >  }
> > >
> > +/*------------------------------------------------------------------------*/
> > > +
> > > +/* ohci generic function for all OHCI bus glue */
> > > +
> > > +static int ohci_setup(struct usb_hcd *hcd)
> > > +{
> > > +     struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> > > +     int retval;
> > > +
> > > +     ohci->sbrn = HCD_USB11;
> >
> > What is this doing here?  Why did you add this "sbrn" member to struct
> > ohci_hcd?
> >
> > not required so reverted.
> 
> > > +
> > > +     /* data structure init */
> > > +     retval = ohci_init(ohci);
> > > +     if (retval)
> > > +             return retval;
> > > +     ohci_usb_reset(ohci);
> >
> > Why is this call here?  Doesn't ohci_init() already call
> > ohci_usb_reset()?
> >
> >
> ohci_init is not called in ohci_usb_reset() its called in ohci_restart() so
> I think ohci_init needed.

It sounds like you did not understand what I wrote.

ohci_setup does not need to call ohci_usb_reset.  ohci_setup calls
ohci_init, and ohci_init calls ohci_usb_reset.


> > The #else part of this isn't needed, and I doubt very much that it
> > would work correctly if it was needed.
> >
> > As Arnd suggestion,so I written else part.

The existing code doesn't have a #else part, and I don't think you need 
to add one.

Alan Stern
