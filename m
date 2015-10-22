From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Oct 2015 16:01:33 -0700
Subject: MUSB peripheral DMA regression caused by driver core runtime PM
 change
In-Reply-To: <20151022180216.GT3078@atomide.com>
References: <20151021234134.GQ3078@atomide.com>
 <20151022180216.GT3078@atomide.com>
Message-ID: <20151022230133.GV3078@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [151022 11:03]:
> * Tony Lindgren <tony@atomide.com> [151021 16:44]:
> > Hi all,
> > 
> > I noticed a regresssino in v4.3-rc series to day with MUSB gadgets
> > and DMA. Doing a git bisect between v4.2..v4.3-rc1 on it pointed to:
> > 
> > ddef08dd00f5 ("Driver core: wakeup the parent device before trying probe")
> > 
> > With the commit above reverted things work fine with DMA and USB gadgets.
> > 
> > This is on omap3 with CONFIG_USB_INVENTRA_DMA selected. Selecting
> > CONFIG_MUSB_PIO_ONLY still works even without reverting ddef08dd00f5.
> > 
> > Anybody got ideas what might be wrong? Some wrong runtime PM usage
> > under drivers/usb/musb?
> 
> Here's some more debug info on where things are different initializing
> the USB gadgets. I added some printks and diffed the dmesg output. The
> added calls from commit ddef08dd00f5 start with dd:

Well turns out the problem actually happens earlier. We end up calling
omap2430_runtime_resume with NULL struct musb while EPROBE_DEFER
probing.

No ideas yet how it should be fixed though.

Regards,

Tony
