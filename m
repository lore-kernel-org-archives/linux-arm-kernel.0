From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 22 Jan 2015 12:01:13 +0100
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <20150122104330.GN4367@lukather>
References: <20150121160631.GH4367@lukather>
 <CADYTM3b40_u4Twt27PBVH4dC9ErDnFEi0AUzs_aJRM3mMHaBCQ@mail.gmail.com>
 <54C0A8C9.3040201@visionsystems.de>
 <20150122104330.GN4367@lukather>
Message-ID: <20150122110113.GA17866@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 22, 2015 at 11:43:30AM +0100, Maxime Ripard wrote:
> Hi Yegor,
> 
> On Thu, Jan 22, 2015 at 08:37:45AM +0100, Yegor Yefremov wrote:
> > On 21.01.2015 19:53, Bin Liu wrote:
> > > Hi,
> > > 
> > > On Wed, Jan 21, 2015 at 10:06 AM, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> wrote:
> > >> Hi Felipe,
> > >>
> > >> I'm currently working on a custom AM335x-based board, that has a OTG
> > >> connector wired to one of the musb controlers, and Linux 3.17
> > >>
> > >> This OTG connector seems to behave in a weird way when it comes to
> > >> switching from one role to another:
> > >>
> > >>   - The host mode works with CONFIG_USB_MUSB_DUAL_ROLE set, only if
> > >>     the dr_mode is set to host in the DT, and only if we plug the USB
> > >>     device after the kernel has booted. Otherwise, even though the
> > >>     controller seems to be set up as host in the kernel logs, it
> > >>     doesn't work. When DR-mode is set to otg, DRVVBUS is not high
> > >>     which surely doesn't help, but there might be some other issues.
> > >>
> > >>   - The gadget mode works with CONFIG_USB_MUSB_DUAL_ROLE, if dr_mode
> > >>     is set to otg and not host (obviously), and only if we plug the
> > >>     USB cable after the kernel has booted.
> > >>
> > >>   - The gadget mode works with CONFIG_USB_MUSB_GADGET, and with
> > >>     dr_mode set to otg, even if we cold plug the device.
> > >>
> > >>   - As you might expect from the two first items, the runtime
> > >>     switching from gadget to host when CONFIG_USB_MUSB_DUAL_ROLE is
> > >>     set and dr_mode is set in otg doesn't work either.
> > >>
> > >> It looks like it's only waiting for an interrupt to occur to read the
> > >> ID pin state, without reading its initial value, which would explain
> > >> why both the host and gadget enumerate only when a device/cable is
> > >> hotplugged, and that there's some configuration bits that differ
> > >> whenever dr_mode changes, but I couldn't really see anything standing
> > >> out in the driver nor the datasheet.
> > >>
> > >> Have you already experienced something alike with that driver?
> > > 
> > > I don't use vanilla mainline kernel very often, but I don't have such
> > > hotplug issues with TI 3.12/14 kernels [1]. I only use
> > > CONFIG_USB_MUSB_DUAL_ROLE though.
> > > 
> > > [1] git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git, branch
> > > remote/origin/linux-3.14.y
> > 
> > I have the same experience with 3.15. The switching is working when
> > CONFIG_USB_MUSB_DUAL_ROLE is set and dr_mode = "otg". But since 3.16
> > it seems to be broken. Still had no time to bisect this.
> 
> I just gave 3.15 a quick try, and it looks like it can now detect when
> the device is acting as a gadget, but the host mode is not working at
> all.
> 
> That's a good lead though, I'll dig more into the older versions and
> see if some are working better than others.

This issue may be related to the fact that the musb controller does not
have an ID pin interrupt. Last year I sent a RFC for a soft detection in
OTG mode. It has a poll loop which toggles the SESSION bit of the
controller to detect devices as host and drops back to device otherwise.
This is far away from a good solution.

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/204519.html

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150122/0a823516/attachment-0001.sig>
