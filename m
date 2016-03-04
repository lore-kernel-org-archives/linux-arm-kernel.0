From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Mar 2016 16:37:29 +0100
Subject: [PATCH] [media] v4l2/dvb: allow v4l2_mc functions to be used by
 dvb
In-Reply-To: <20160303142953.2f8943bd@recife.lan>
References: <1456692724-751344-1-git-send-email-arnd@arndb.de>
 <20160303142953.2f8943bd@recife.lan>
Message-ID: <4935115.sMizstOCUV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 14:29:53 Mauro Carvalho Chehab wrote:
> Em Sun, 28 Feb 2016 21:51:48 +0100
> Arnd Bergmann <arnd@arndb.de> escreveu:
> 
> > In a configuration that supports all DVB drivers but that disables
> > V4L2 or builds it as a loadable module, we get link errors because
> > of the recent change to use __v4l2_mc_usb_media_device_init:
> > 
> > drivers/media/built-in.o: In function `dvb_usb_adapter_dvb_init':
> > :(.text+0xe7966): undefined reference to `__v4l2_mc_usb_media_device_init'
> > drivers/media/built-in.o: In function `dvb_usbv2_init':
> > :(.text+0xff1cc): undefined reference to `__v4l2_mc_usb_media_device_init'
> > drivers/media/built-in.o: In function `smsusb_init_device':
> > :(.text+0x113be4): undefined reference to `__v4l2_mc_usb_media_device_init'
> > drivers/media/built-in.o: In function `au0828_usb_probe':
> > :(.text+0x114d08): undefined reference to `__v4l2_mc_usb_media_device_init'
> > 
> > This patch is one way out, by simply building the v4l2-mc.c file
> > whenever at least one of VIDEO_V4L2 or DVB_CORE are enabled, including
> > the case that one of them is a module and the other is built-in, which
> > leads the MC code to become built-in as well.
> 
> Thanks for the patch, but I actually solved this issue the other way
> around: I moved those functions to the media core, where both V4L and DVB
> uses it. This also allows using the function outside (like on ALSA).
> 
> I should be pushing it later today to Linux next.
> 
> 

Excellent! I was trying to come up with a better place for the code but
didn't know where else to put it.

	Arnd
