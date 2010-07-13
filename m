From: metan@ucw.cz (Cyril Hrubis)
Date: Tue, 13 Jul 2010 13:26:49 +0200
Subject: usb gadget on zaurus and kexec
In-Reply-To: <87wru7xc4z.fsf@free.fr>
References: <20100519154618.GA26381@atrey.karlin.mff.cuni.cz>
	<AANLkTim49akRJK0BN_Qk1wL6e5mrdjZioDjGNWlrjUVQ@mail.gmail.com>
	<AANLkTilCvgvf9Ch55f878nTNTue8tHYmcrLEywsjnylY@mail.gmail.com>
	<201006100900.23981.marek.vasut@gmail.com> <87wru7xc4z.fsf@free.fr>
Message-ID: <20100713112649.GA17065@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> >> > Dumping out the registers of the two situations and doing a comparison
> >> > then might be a quick way.
> >> 
> >> Any debugging update on this?
> >
> > Yeah, there's a workaround. Cyril's working on a proper fix, but that might take 
> > some time. Simply -- UP2OCR is misconfigured.
> 
> That's quite interesting. In the pxa27x_udc gadget driver, I seem to have a
> regression on the resume from suspend to RAM path. My USB UDC is not enumerated
> anymore.
>
>
> The might be a correlation, as UP2OCR is lost in the suspend process. I'm very
> interested by your analysis of the issue you have on kexec, as that might ease
> my work :)

Well it seems, at least for spitz that UP2OCR is set to host at the
initialization and not touched anymore (spitz.c). I guess that the OE kernel,
that is flashed in my spitz, changes UP2OCR when gadget/host driver is loaded
but this doesn't work in vanilla kernels for some time. That would clarify why
gadgets doesn't work after kexec at least for me. 
 
> Besides, it's been some time I've been thinking that the pxa deserves a proper
> encapsulation of the USB internal routing paths (ie. a proper way to switch from
> usb host handled by ohci-pxa27x to an usb client handled by pxa2x_udc), to
> reflect the setup of the Pad Unit (see TRM chapter 12.4 : tables 12.2, 12.15,
> 12.17, 12.18 and 12.19).
> 
> Whatever you find on the USB Port2 configuration register would help me design
> the Pad block.
> 

Would be great. So far the GPIO for usb host/slave cable detection is not used
on spitz so there is no way to switch to USB slave for gadgets to work if you
don't want to play with devmem2.

There is some otg code in drivers/usb/otg/ but I haven't time to look on that yet.

-- 
metan
