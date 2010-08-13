From: david-b@pacbell.net (David Brownell)
Date: Fri, 13 Aug 2010 06:42:32 -0700 (PDT)
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <201008131258.55016.oneukum@suse.de>
Message-ID: <732137.54230.qm@web180303.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: Problem with non aligned DMA in usbnet on ARM

I remain unconvinced the bug is anywhere except
in whatever host controller is rejecting the
buffers it's given.

Does anyone have proof the bug is elsewhere?


Think for a moment what chaos the kernel would be
if arbitrary subsystems were allowed to introduce
random DMA alignment "requirements".  It would not
be possible to pass buffers between subsystems with
any success at all...

> > 1) Require that usb drivers submit buffers obtained
> from kmalloc() and > friends

Requirements are already documented with the
Description of what memory is DMA-able.  It's
not kmalloc() specifically that's required.

 with no extra offsets.

Offsets have nothing to do with being DMA-able.
They might have to do with working around hardware
flaws though.  (ISTR PXA255 also had a 32-bit goof,
making its DMA engine unusable for most purposes.)

 
> > 2) Require that usb_submit_urb() accept byte aligned buffers.

I believe we already require that.  Of course,
the requirement is on HCDs, not on that call.
