From: stern@rowland.harvard.edu (Alan Stern)
Date: Sun, 9 Jun 2013 12:06:24 -0400 (EDT)
Subject: [RFC PATCH 2/4] USB: EHCI: don't release ehci->lock if URB
 giveback in tasklet context
In-Reply-To: <1370791112-18464-3-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306091158480.13202-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Jun 2013, Ming Lei wrote:

> If HCD_BH is set for HC driver's flags, URB giveback will be
> done in tasklet context instead of interrupt context, so the
> ehci->lock needn't to be released any more before calling
> usb_hcd_giveback_urb().

Ah, this is the reason why you don't need to release the private lock.  
I'm not sure that this will save much time overall.

With the existing code, the main reason for lock contention would be if
(for example) CPU 2 submitted or cancelled an URB while the giveback
was occurring on CPU 1.  Then CPU 1 would be forced to wait while CPU 2 
finished its submission or cancellation.

With this patch, it's the other way around.  CPU 2 would be forced to 
wait while CPU 1 does all the rest of the work in its interrupt 
handler.  The total time spent holding the lock will be the same; it 
will just be distributed differently among the CPUs.  Hence it is not 
at all clear that this change will save any time.

Alan Stern
