From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 Apr 2015 17:46:11 +0200
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <20150205132142.GD2079@lukather>
References: <20150121160631.GH4367@lukather>
 <CADYTM3b40_u4Twt27PBVH4dC9ErDnFEi0AUzs_aJRM3mMHaBCQ@mail.gmail.com>
 <54C0A8C9.3040201@visionsystems.de>
 <20150205132142.GD2079@lukather>
Message-ID: <20150414154611.GE27280@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 05, 2015 at 02:21:42PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Jan 22, 2015 at 08:37:45AM +0100, Yegor Yefremov wrote:
> > I have the same experience with 3.15. The switching is working when
> > CONFIG_USB_MUSB_DUAL_ROLE is set and dr_mode = "otg". But since 3.16
> > it seems to be broken. Still had no time to bisect this.
> 
> I've been giving a few versions (from v3.15 to Tuesday's linux-next) a
> try, and I always see the same behaviour now:
> 
>   - Booting as a gadget (ie, with a USB cable plugged in), and
>     swapping the cable for a (real, this time) USB OTG cable with a
>     USB key never works. When the device is plugged, all I get is
> 
> [  262.944846] usb 1-1: new high-speed USB device number 2 using musb-hdrc
> [  278.064748] usb 1-1: device descriptor read/64, error -110
> 
>     Putting in back in gadget results with a load of continuous:
> [  315.258839] musb_bus_suspend 2484: trying to suspend as a_wait_vfall while active
> 
>   - Booting as a host, or with nothing connected to it actually work,
>     up to a few plug-a-device-then-plug-a-host cycles, where you end
>     up with the following logs when disconnecting the device (somehow,
>     it always happens when it is set in host mode).
> 
> [   12.969075] CAUTION: musb: Babble Interrupt Occurred
> [   12.974445] CAUTION: musb: Babble Interrupt Occurred
> [   12.979637] musb_stage0_irq 789: unhandled DISCONNECT transition (a_wait_bcon)
> [   12.988498] usb 1-1: USB disconnect, device number 2
> [   13.071849] musb-hdrc musb-hdrc.0.auto: Restarting MUSB to recover from Babble
> 
>     Plugging back our USB cable, with the AM335x acting as a device
>     work once. Then, when it switches to the host mode, we end up with
>     the same scenario than in the coldplug as gadget case: USB read
>     error, before then having all the a_wait_vfall messages.

I gave it some more testing these two days, with next-20150410, with
pretty much the same results.

Dumping the DSPS glue registers doesn't get anywhere, in both cases
(booting as peripheral and then switching to host, or booting as host)
they are identical.

However, the musb registers vary greatly.

In the first case, we boot as host, switch to peripheral, and then
switch back to host, repeatedly until it fails:

http://code.bulix.org/p0d964-88211?raw

We can see that while it still works, value comes back to their
original state when switching back to host, which makes sense.

However, when it fails, some registers are not set back to their
initial values, including TxMaxPp, TxCSRp, RxMaxPp, ConfigData,
DevCtl, TxFIFOadd and RxFIFOadd.

Some registers that were not changing while it was working also now
have a different value: TxMaxPp, RxMaxPp, MISC, TxFIFOsz and RxFIFOsz.

Starting with the device as peripheral, and then switching to host
fails instantly, once again with exotic values for the registers
compared to the configuration set whenever the host mode is working:

http://code.bulix.org/uo8fmu-88210?raw

However, the registers values are quite similar to the one we got
previously when the host mode was failing after a while, which might
indicate that we end up in the same case somehow.

Since I've not been able to find the musb datasheet, I'm unfortunately
unable to make any deduction from these besides that something looks
fishy.

I've also did some runs with the musb glue and core compiled with
debug options:

Booted as host:
http://code.bulix.org/97jz3i-88207?raw

Booted as peripheral:
http://code.bulix.org/vqdqt6-88208?raw

I hope it helps...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150414/60f5fe1e/attachment-0001.sig>
