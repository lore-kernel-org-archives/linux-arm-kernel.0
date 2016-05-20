From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 20 May 2016 10:31:56 -0400 (EDT)
Subject: [PATCH] usb: echi-hcd: Add ehci_setup check before echi_shutdown
In-Reply-To: <CAPBZ5QcMiMEv1n=WU6aW2PGNsSPZJR42iZge_VUX4aWZ-KKzbw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1605201026060.1938-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 May 2016, Andy Gross wrote:

> On 19 May 2016 at 05:12, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> 
> <snip>
> 
> > +++ b/drivers/usb/host/ehci-hcd.c
> > @@ -368,6 +368,15 @@ static void ehci_shutdown(struct usb_hcd *hcd)
> >  {
> >         struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> >
> > +       /**
> > +        * Protect the system from crashing at system shutdown in cases where
> > +        * usb host is not added yet from OTG controller driver.
> > +        * As ehci_setup() not done yet, so stop accessing registers or
> > +        * variables initialized in ehci_setup()
> > +        */
> > +       if (!ehci->sbrn)
> > +               return;
> > +
> >         spin_lock_irq(&ehci->lock);
> >         ehci->shutdown = true;
> >         ehci->rh_state = EHCI_RH_STOPPING;
> 
> 
> Should we also not check this in ehci_suspend and ehci_resume?  If I
> do suspend/resume, it crashes in a similar manner.  I know this goes
> beyond the problem scope of the patch.  Perhaps I should send in an
> additional patch with the code?
> 
> Are there any other places in the ehci-hcd where this needs to be checked?

Really, this is an indication that the problem lies not in ehci-hcd but 
rather in the platform glue code.  The platform code allows itself to 
be registered as the driver of the controller device but does not 
initialize the ehci-hcd parts.

Neither ehci_suspend nor ehci_resume is called directly by the driver
core; the calls all have to pass through the glue code.  So maybe the
glue layer needs to be careful about invoking these routines in
ehci-hcd before ehci-hcd has been initialized.

Alan Stern
