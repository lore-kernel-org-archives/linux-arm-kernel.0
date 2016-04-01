From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 1 Apr 2016 16:38:07 +0200
Subject: usb: gadget breakage on N900: bind UDC by name passed via
 usb_gadget_driver structure
In-Reply-To: <CAB=otbTsAwBohbYmwBERpdG-ZdAUk_vJwoZoO8dUf_H-W4jREg@mail.gmail.com>
References: <CAB=otbRd+hZaO6ihL3c88Ys_q-R4grmup4cfP70PT+N2JEQ3WQ@mail.gmail.com>
 <CAB=otbQ=jJNk=CtB4hu51HXxOLxhWEDaeWf3V0Uc7Uh3veXsfg@mail.gmail.com>
 <CAB=otbQ1J7FZm9vWLwor93+uD3Fv38ykduWMXG3qByNh4mV9=g@mail.gmail.com>
 <20160327202657.GA31059@amd>
 <CAB=otbTsAwBohbYmwBERpdG-ZdAUk_vJwoZoO8dUf_H-W4jREg@mail.gmail.com>
Message-ID: <20160401143807.GF11860@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> > Dmesg from the n900 is attached as /tmp/delme.gz. I did _not_ apply
> >> > the patch from https://lkml.org/lkml/2016/3/24/670 , yet, as I'm using
> >> > devicetree boot.
> >>
> >> Hmm.. don't see anything strange in the boot log related to USB,
> >> I'll try your config
> >
> > Let me know how it went.
> 
> I tried your config (with slight modifications) with vanilla kernel v4.5
> (modifications: cmdline changed to default; used INITRAMFS_SOURCE
> for prebuilt cpio archive with rootfs) and Device Tree booting.
> Works fine for me except I need to unplug-plug usb cable or issue
> # echo connect > /sys/devices/platform/68000000.ocp/480ab000
> .usb_otg_hs/musb-hdrc.0.auto/udc/musb-hdrc.0.auto/soft_connect
> to make connection.
> The gadget driver successfully binds to the gadget, but I don't know
> why the musb core doesn't issue pullup on USB lines during boot.

Hmm, strange. Unplug/replug of the USB cable results in:

<6>usb 1-5: new high-speed USB device number 100 using ehci-pci
<3>usb 1-5: device descriptor read/64, error -32
tail: /proc/kmsg: file truncated
<3>usb 1-5: device descriptor read/64, error -32
<3>usb 1-5: device descriptor read/64, error -32
<3>usb 1-5: device descriptor read/8, error -32
<3>usb 1-5: device descriptor read/8, error -32
<6>usb 1-5: new high-speed USB device number 103 using ehci-pci
<3>usb 1-5: device descriptor read/8, error -32
<3>usb 1-5: device descriptor read/8, error -32
<3>usb usb1-port5: unable to enumerate USB device
<6>usb 4-1: new full-speed USB device number 80 using uhci_hcd
<3>usb 4-1: device descriptor read/64, error -32
<3>usb 4-1: device descriptor read/64, error -32
<6>usb 4-1: new full-speed USB device number 81 using uhci_hcd
<3>usb 4-1: device descriptor read/64, error -32
<3>usb 4-1: device descriptor read/64, error -32
<3>usb usb4-port1: unable to enumerate USB device

echo connect does not seem to do the trick, either:

root at n900:~# echo connect >
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/udc/musb-hdrc.0.auto/soft_connect
-bash: echo: write error: Operation not supported
root at n900:~# uname -a
Linux n900 4.4.0-omap3-149558-g5cf5ee5-dirty #168 PREEMPT Tue Mar 29
09:49:40 CEST 2016 armv7l GNU/Linux

Hmm, documentation is not too helpful, either...

What:           /sys/class/udc/<udc>/soft_connect
Date:           June 2011
KernelVersion:  3.1
Contact:        Felipe Balbi <balbi@kernel.org>
Description:
		Allows users to disconnect data pullup resistors thus
		causing a
 		logical disconnection from the USB
 		Host.

Dmesg says:

[  619.471374] udc musb-hdrc.0.auto: soft-connect without a gadget
driver

Any ideas?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
