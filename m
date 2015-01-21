From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jan 2015 17:06:31 +0100
Subject: MUSB dual-role on AM335x behaving weirdly
Message-ID: <20150121160631.GH4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

I'm currently working on a custom AM335x-based board, that has a OTG
connector wired to one of the musb controlers, and Linux 3.17

This OTG connector seems to behave in a weird way when it comes to
switching from one role to another:

  - The host mode works with CONFIG_USB_MUSB_DUAL_ROLE set, only if
    the dr_mode is set to host in the DT, and only if we plug the USB
    device after the kernel has booted. Otherwise, even though the
    controller seems to be set up as host in the kernel logs, it
    doesn't work. When DR-mode is set to otg, DRVVBUS is not high
    which surely doesn't help, but there might be some other issues.

  - The gadget mode works with CONFIG_USB_MUSB_DUAL_ROLE, if dr_mode
    is set to otg and not host (obviously), and only if we plug the
    USB cable after the kernel has booted.

  - The gadget mode works with CONFIG_USB_MUSB_GADGET, and with
    dr_mode set to otg, even if we cold plug the device.

  - As you might expect from the two first items, the runtime
    switching from gadget to host when CONFIG_USB_MUSB_DUAL_ROLE is
    set and dr_mode is set in otg doesn't work either.

It looks like it's only waiting for an interrupt to occur to read the
ID pin state, without reading its initial value, which would explain
why both the host and gadget enumerate only when a device/cable is
hotplugged, and that there's some configuration bits that differ
whenever dr_mode changes, but I couldn't really see anything standing
out in the driver nor the datasheet.

Have you already experienced something alike with that driver?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/01f9c534/attachment-0001.sig>
