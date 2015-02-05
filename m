From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Feb 2015 14:21:42 +0100
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <54C0A8C9.3040201@visionsystems.de>
References: <20150121160631.GH4367@lukather>
 <CADYTM3b40_u4Twt27PBVH4dC9ErDnFEi0AUzs_aJRM3mMHaBCQ@mail.gmail.com>
 <54C0A8C9.3040201@visionsystems.de>
Message-ID: <20150205132142.GD2079@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 22, 2015 at 08:37:45AM +0100, Yegor Yefremov wrote:
> I have the same experience with 3.15. The switching is working when
> CONFIG_USB_MUSB_DUAL_ROLE is set and dr_mode = "otg". But since 3.16
> it seems to be broken. Still had no time to bisect this.

I've been giving a few versions (from v3.15 to Tuesday's linux-next) a
try, and I always see the same behaviour now:

  - Booting as a gadget (ie, with a USB cable plugged in), and
    swapping the cable for a (real, this time) USB OTG cable with a
    USB key never works. When the device is plugged, all I get is

[  262.944846] usb 1-1: new high-speed USB device number 2 using musb-hdrc
[  278.064748] usb 1-1: device descriptor read/64, error -110

    Putting in back in gadget results with a load of continuous:
[  315.258839] musb_bus_suspend 2484: trying to suspend as a_wait_vfall while active

  - Booting as a host, or with nothing connected to it actually work,
    up to a few plug-a-device-then-plug-a-host cycles, where you end
    up with the following logs when disconnecting the device (somehow,
    it always happens when it is set in host mode).

[   12.969075] CAUTION: musb: Babble Interrupt Occurred
[   12.974445] CAUTION: musb: Babble Interrupt Occurred
[   12.979637] musb_stage0_irq 789: unhandled DISCONNECT transition (a_wait_bcon)
[   12.988498] usb 1-1: USB disconnect, device number 2
[   13.071849] musb-hdrc musb-hdrc.0.auto: Restarting MUSB to recover from Babble

    Plugging back our USB cable, with the AM335x acting as a device
    work once. Then, when it switches to the host mode, we end up with
    the same scenario than in the coldplug as gadget case: USB read
    error, before then having all the a_wait_vfall messages.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150205/2d577670/attachment.sig>
