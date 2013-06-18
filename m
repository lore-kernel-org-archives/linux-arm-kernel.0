From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 11:06:00 -0400 (EDT)
Subject: [PATCH V2 05/10] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <CAJFYCKFHhD2LuPP5LKSXzg4zuCMmNTSWRRUQkwFcQVmXSaLo9Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306181056590.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jun 2013, Manjunath Goudar wrote:

> After Alan explanation I am writing below code end of ohci_suspend()
> routine.is it correct Alan.
> 
>        if (do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
>                 ohci_resume(hcd, false);
>                 rc = -EBUSY;
>         }

I'm glad you asked, because there is an important part I forgot about.
Just before the code above, it is also necessary to add:

	synchronize_irq(hcd->irq);

The reason is because a wakeup interrupt might race with the suspend
call.  If the suspend finishes first, we need to wait until the
interrupt has been handled before checking whether there is a pending
wakeup.  That's what synchronize_irq() does; it waits until all the
outstanding interrupt requests have been handled.

(Also, as Sachin pointed out, you have to return rc instead of 0.)

Alan Stern
