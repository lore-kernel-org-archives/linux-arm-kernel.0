From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 Feb 2013 08:44:04 +0100
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin
 function name
In-Reply-To: <CAKGA1bmw+CzBDLHty1+L1VdeWLgkPpLSLpGKBJEeQj-ByyzicA@mail.gmail.com>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
 <20130222055203.GB27371@S2101-09.ap.freescale.net>
 <CAKGA1bmw+CzBDLHty1+L1VdeWLgkPpLSLpGKBJEeQj-ByyzicA@mail.gmail.com>
Message-ID: <20130227074404.GD1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 12:51:56AM -0600, Matt Sealey wrote:
> On Thu, Feb 21, 2013 at 11:52 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Thu, Feb 21, 2013 at 11:36:36AM -0600, Matt Sealey wrote:
> >> On Wed, Feb 20, 2013 at 11:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >> > On Wed, Feb 20, 2013 at 06:03:39PM -0600, Matt Sealey wrote:
> >> >> I am not sure I am getting this point across, but.. damn it.. nack nack nack :D
> >> >>
> >> > Do you see any downgrade side that the series introduces over the
> >> > existing implementation?
> >>
> >> Because it replaces the horribly stupid existing implementation with
> >> something that doesn't solve the fundamental logical problems caused
> >> by the existing implementation.
> >
> > When did I say that the series is targeting to solve those "fundamental
> > logical problems" in *your* view?
> >
> > ...
> 
> Why would you submit a series that doesn't solve such problems? :)
> 
> To replace an illogical, ridiculous system of arbitrary pin numbering
> with an illogical mapping of registers to arbitrary names is..
> illogical.
> 
> >> What you've fixed it to do, as I read this patch, is this;
> >>
> >> <arbitrary_pin_name pad_mode>
> >>
> > No, it's not arbitrary_pin_name.  It's pin function name which comes
> > from hardware manual.  It may not exactly match the public reference
> > manual, but they are obvious to be identified.  For imx6q pad SD2_DAT1
> > example, the manual says:
> >
> > Select 1 of 6 iomux modes to be used for pad: SD2_DAT1.
> >   000 ALT0 ? Select signal SD2_DATA1.
> >   001 ALT1 ? Select signal ECSPI5_SS0.
> >   010 ALT2 ? Select signal EIM_CS2.
> >   011 ALT3 ? Select signal AUD4_TXFS.
> >   100 ALT4 ? Select signal KEY_COL7.
> >   101 ALT5 ? Select signal GPIO1_IO14.
> >
> > And imx6q-pinfunc.h gives:
> >
> >   MX6Q_PAD_SD2_DAT1__USDHC2_DAT1
> >   MX6Q_PAD_SD2_DAT1__ECSPI5_SS0
> >   MX6Q_PAD_SD2_DAT1__WEIM_WEIM_CS_2
> >   MX6Q_PAD_SD2_DAT1__AUDMUX_AUD4_TXFS
> >   MX6Q_PAD_SD2_DAT1__KPP_COL_7
> >   MX6Q_PAD_SD2_DAT1__GPIO_1_14
> 
> So, SD2_DAT1 with function SD2_DAT1 in the manual is SD2_DAT1__USDHC2_DAT1 ?
> 
> KEY_COL7 -> KPP_COL_7?
> EIM_CS2 -> WEIM_WEIM_CS_2?
> AUD4_TXFS -> AUDMUX_AUD4_TXFS?
> GPIO1_IO14 -> GPIO_1_14?
> 
> This is what I call arbitrary.
> 
> Since the documented NAMING of pins changes between SoC revisions
> (where pins change definition or group), manual revisions (where
> people fix definitions), and even existing source code, it makes no
> sense whatsoever to give things like this a name. Especially as it is
> possible to break out the pin definitions and see that your "use a
> macro to encode 5 values at once and leave the most-often changing
> value to the device tree" method misses one thing: it is not easy to
> set the SION bit in the ALT register for each of these without
> replacing the macro. Sometimes SION is important for debugging,
> sometimes it is not... some pins need SION *forever* and other times..
> not. On i.MX6 using RMII ethernet, you need SION to loopback the clock
> input to the MAC.. but it's possible you'd want to temporarily disable
> this in a build. The only way here is to replace the pin definition
> macro part with the actual register values, set your SION bit, and
> rebuild the device tree.
> 
> The only canonical thing you can guarantee is that in general the
> registers fit within certain ranges (although on i.MX51 the ranges did
> change between revisions, this is another problem), and accept certain
> values.
> 
> The only reasonable thing we can be doing with pre-processing IOMUX
> data is make sure it fits those ranges (within reason) and possibly
> use the preprocessing to ensure that invalid values never make it into
> a device tree (i.e. there are bits in the pad settings which are
> never, ever set on a particular SoC, and masking and bailing out using
> #error or pitching a #warning would be much more useful than allowing
> random bits to go into register areas that are "reserved".
> 
> I half-agree with Sascha. I am responsible for porting the i.MX51
> iomux-v3.h stuff to U-Boot because using the naming scheme worked so
> much better there than mxc_request_iomux clutter since most boards
> came with almost exactly the same settings on exactly the same buses
> because it was a limited choice on i.MX51. This MOSTLY works but there
> are several - if not a ridiculous number - of entries which needed to
> be modified for any particular board. And the remit came from the
> U-Boot guys simply that we should not commit into the tree any pins
> which no board makes use of.
> 
> Here, we have potential for a huge file full of macros of which a good
> deal of them will end up with NOBODY using, and therefore just clutter
> the file. If we go with the U-Boot model, we only add macros to define
> a pin configuration set if at least ONE board requires that
> definition. This will keep it nice and clean and make sure nobody
> commits huge swaths of macros which nobody is testing.

Great, so you end up patching this file over and over again, maintaining
out of boards always require patches to the iomux file, maintainers have
to deal with merge conflicts.

> 
> Since I did that work, I've changed my mind; actually naming the pins
> by their intended function simply doesn't ADD anything to the device
> tree functionality, nor does it really help Sascha out any more than
> simply having a *really good reference* would help him out.
> 
> For example, please explain to me why;
> 
> MX51_PIN_EIM_23__GPIO1_2 0x6528
> 
> is clearer than;
> 
> 0x174 0x5 0x3d8 0x7 0x654 0x7633, /* EIM_23 GPIO1_2 and some pullup
> settings or so comment comment comment */

Look what you have to do to get the pin muxing for a single pin from the
datasheet.

- identify the name, grep for it in the datasheet, find 0x78 for the mux
  register.
- identify the mode wanted, it's ALT1 for GPIO1_2
- Look if it is involved in daisy chain, grep again if it is
- grep again for EIM_D23, find 0x40c for the PAD_CTL register

That's exactly the steps that are annoying, error prone and you can get
rid of by having a macro like we currently have. If you found a bug in
the macro, fix it and everyone benefits.

Also you should notice that with the new patches Shawn has posted nobody
is forced to use these macros. If you don't like them, go and dump the
raw hex numbers into your devicetrees.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
