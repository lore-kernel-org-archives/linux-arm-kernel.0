From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 26 Oct 2014 13:00:07 +0100
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <201410261212.46582@pali>
References: <20141019090107.GA19132@amd>
 <20141020213518.GB28144@drone.musicnaut.iki.fi>
 <20141026110825.GA2263@amd> <201410261212.46582@pali>
Message-ID: <20141026120007.GA25140@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2014-10-26 12:12:46, Pali Roh?r wrote:
> On Sunday 26 October 2014 12:08:25 Pavel Machek wrote:
> > Hi!
> > 
> > > On Sun, Oct 19, 2014 at 09:19:37PM +0200, Pavel Machek wrote:
> > > > I am trying to use nfsroot, so I can't use modules.
> > > 
> > > Why not?
> > > 
> > > > (I am attaching full config, in case I missed something
> > > > important).
> > > 
> > > I'm using the below config with 3.17 and g_ether works OK.
> > > 
> > > (My initramfs modprobes g_ether, runs busybox ifconfig for
> > > usb0 and launches sshd.)
> > 
> > I am trying to get 3.14 kernel to work, first. There, usb
> > gadget works when compiled into kernel. But with modules, I
> > get
> > 
> > # root@(none):/tmp# insmod libcomposite.ko
> > # root@(none):/tmp# insmod u_ether.ko
> > # root@(none):/tmp# insmod usb_f_rndis.ko
> > # root@(none):/tmp# insmod g_ether.ko
> > 
> > [  169.061218] udc musb-hdrc.0.auto: registering UDC driver
> > [g_ether] [  169.078918] g_ether musb-hdrc.0.auto: failed to
> > start g_ether: -2
> > 
> > -2 is ENOENT...
> 
> Can you try g_nokia.ko? I used this module for usb networking.

Ok, so lets go to 3.17, and try with compiled-in modules?

[13220.555232] usb 5-1: USB disconnect, device number 41
[13225.972033] usb 5-1: new high-speed USB device number 42 using
ehci-pci
[13241.084037] usb 5-1: device descriptor read/64, error -110
pavel at amd:/data/l/maemo$ 

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_SUBSET=y
# CONFIG_USB_CONFIGFS is not set                                                                   
# CONFIG_USB_ZERO is not set                                                                       
CONFIG_USB_ETH=y

I had musb_dual_role set, trying to make it gadget-only:

      1. Host only mode (USB_MUSB_HOST) (NEW)
      2. Gadget only mode (USB_MUSB_GADGET) (NEW)
    > 3. Dual Role mode (USB_MUSB_DUAL_ROLE) (NEW)
    choice[1-3]: 2

Same result:
[13621.776030] usb 5-1: new high-speed USB device number 57 using
ehci-pci
[13636.888036] usb 5-1: device descriptor read/64, error -110

Wait a moment. It seems I'm using drivers from legacy/ directory. Is
that good idea?

Lets try:

    10. CDC Composite Device (Ethernet and ACM) (USB_CDC_COMPOSITE)

No, same result.

[13844.456032] usb 5-1: new high-speed USB device number 63 using
ehci-pci
[13859.568028] usb 5-1: device descriptor read/64, error -110

I don't think I can actually select nokia support in 3.17 :-(.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
