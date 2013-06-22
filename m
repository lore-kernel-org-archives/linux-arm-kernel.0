From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 22 Jun 2013 15:08:45 -0400 (EDT)
Subject: [PATCH V2 5/6] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <CAJFYCKEfyb+2BpTDLpVS3Qvdim2JTyuJNYFHweF8+3s9f28vvw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306221500300.2162-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Jun 2013, Manjunath Goudar wrote:

> > As a general rule, you should never change code that you don't
> > understand.  Do you _know_ that it will be safe to call ohci_setup() or
> > ohci_restart() at this point?
> >
> >
> From David Brownell comment I am understanding,instead of calling
> ohci_setup()
> or ohci_restart(),we can use directly below code.
> 
>         ohci->hc_control &= OHCI_CTRL_RWC;
>         ohci_writel (ohci, ohci->hc_control, &ohci->regs->control);
>         ohci->rh_state = OHCI_RH_HALTED;

Of course you can use that code; that's exactly what ohci_usb_reset() 
does now.

> the 3rd line code is written by you,I want to know what exactly it is doing.
> Is it required here?

Yes, it is required.  ohci->rh_state stores the current state of the
root hub.  When the controller is reset, the root hub goes into the 
HALTED state; this line records that fact.

> > It might be a good idea to get in touch with the person who wrote that
> > routine originally and ask why they used ohci_usb_reset().
> >
> > yes I will.
> 
> Hi David,
> 
> As I understood ohci_usb_reset() is calling for to notice
> disconnect,reconnect,
> or wakeup without the 48 MHz clock active.
> After fix power management hanging(869aa98c) issue by Patrice Vilchez,I
> think
> ohci_usb_reset() is not required to call. what is your opinion about this.

Sadly, David Brownell died in 2011.  I can tell you, though, that
commit 869aa98c does not eliminate the need to call ohci_usb_reset().

Alan Stern
