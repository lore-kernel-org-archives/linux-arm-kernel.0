From: oneukum@suse.de (Oliver Neukum)
Date: Fri, 13 Aug 2010 12:58:54 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <4C65193E.4090807@gmail.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
	<4C642AA9.1060404@parrot.com> <4C65193E.4090807@gmail.com>
Message-ID: <201008131258.55016.oneukum@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 13. August 2010, 12:06:54 schrieb Martin Fuzzey:

> So I think a policy needs to be defined to ensure this and enforced in
> the code. I can see two possible methods:
> 
> 1) Require that usb drivers submit buffers obtained from kmalloc() and
> friends with no extra offsets. If they want some other alignment later
> they can use memmove in the completion handler. Enforce this in the core
> by checking the buffer pointers are aligned to ARCH_KMALLOC_MINALIGN
> 
> or
> 
> 2) Require that usb_submit_urb() accept byte aligned buffers. Enforce
> this by a new test in usbtest (which all HCDs are expected to pass).
> Implement it either in individual HCDs that require it or by letting
> HCDs inform the core of their requirements and have the core do the
> alignment (as it already does the dma mapping). Of course HCDs that can
> implement byte aligned transfers (either natively or using tricks such
> as the one Russell suggested) should do so.
> 
> I think 2) is the better solution because:
> a) Solution 1 will impose a runtime overhead even on platforms / HCDs
> that don't need it (including the most common cases)
> b) There are more drivers than HCDs

Yes. But it doesn't prevent you from publishing this information so
drivers can help the lower levels.
	Regards
		Oliver
