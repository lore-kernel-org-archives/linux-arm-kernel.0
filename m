From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 18 May 2016 14:54:25 -0400 (EDT)
Subject: [PATCH] usb: echi-hcd: Add register access check in shutdown
In-Reply-To: <573CAD1A.4090805@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1605181449390.1981-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 May 2016, Srinivas Kandagatla wrote:

> On 18/05/16 15:56, Alan Stern wrote:
> > This doesn't seem like the right place.  What you really should do is
> > skip calling ehci_silence_controller() if the hardware isn't
> > accessible.  That's where the hardware gets touched, not in
> > ehci_shutdown().
> 
> Just tried this suggestion, this would not work as well, Its not just 
> the hardware registers, which are of concern here, but also the rest of 
> the things like ehci->hrtimer pointer which are allocated or initialized 
> as part of ehci_setup().
> 
> Either the msm controller driver is not correct or we should have a way 
> to stop calling ehci_shutdown() if there was no ehci_setup() done yet.
> 
> Any suggestions?

Yes, you're right.

Since you're concerned about more than just accessing the hardware 
registers, HW_ACCESSIBLE isn't the right thing to test.  You need 
something that gets set in ehci_setup() and nowhere else.

One possibility is ehci->sbrn.  If that is equal to 0 then ehci_setup() 
hasn't run, so ehci->shutdown() can simply return.  Be sure to put a 
comment in the code explaining the reason for doing this.

Alan Stern
