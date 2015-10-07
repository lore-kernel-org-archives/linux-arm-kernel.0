From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 7 Oct 2015 03:33:50 +0000
Subject: [PATCH 3/5] mtd: brcmnand: Optional DT flag to reset IPROC NAND
 controller
In-Reply-To: <5614574C.2060701@gmail.com>
References: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
 <1443808606-21203-4-git-send-email-anup.patel@broadcom.com>
 <20151004214943.GA28904@localhost>
 <39063E8F96E11742B35A201CC5D095B7AD54C1@SJEXCHMB10.corp.ad.broadcom.com>
 <20151006134119.GB26818@localhost> <56144A62.70300@broadcom.com>
 <5614574C.2060701@gmail.com>
Message-ID: <39063E8F96E11742B35A201CC5D095B7AD8ADD@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com]
> Sent: 07 October 2015 04:51
> To: Scott Branden; Brian Norris; Anup Patel
> Cc: linux-arm-kernel at lists.infradead.org; Rob Herring; Pawel Moll; Mark
> Rutland; Ian Campbell; Kumar Gala; Catalin Marinas; Will Deacon; David
> Woodhouse; Ray Jui; Florian Fainelli; Pramod Kumar; Vikram Prakash; Sandeep
> Tripathy; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> mtd at lists.infradead.org; bcm-kernel-feedback-list; Rafal Milecki
> Subject: Re: [PATCH 3/5] mtd: brcmnand: Optional DT flag to reset IPROC NAND
> controller
> 
> On 06/10/15 15:25, Scott Branden wrote:
> > Hi Brian,
> >
> > On 15-10-06 06:41 AM, Brian Norris wrote:
> >
> >>>>
> >>>> Is there a reason not to do this reset unconditionally? I recall
> >>>> this came up in discussion previously, when the OpenWRT folks were
> >>>> trying to integrate with BCMA, where this reset was one of the few
> >>>> differences between the
> >>>> platform-
> >>>> device-based driver (i.e., this one) and the BCMA based driver.
> >>>> Might it help
> >>>> simplify things a bit if we just did the same thing everywhere?
> >>>
> >>> This driver is currently shared by Cygnus and NS2.
> >>>
> >>> We had similar suggestion when this patch was reviewed internally in
> >>> Broadcom.
> >>>
> >>> The rationale for adding optional DT flag is as follows:
> >>> 1. The NAND controller reset is currently required for NS2 only so
> >>> that it is in sane state before any NAND commands are issued. We are
> >>> not sure if Cygnus and all future iProc SoCs will require NAND
> >>> controller reset.
> >>
> >> I'm not sure this is a very strong reason. It seems fairly reasonable
> >> in general to reset a HW block before using it.
> >
> > Efficient Boot time is a very strong reason for needing this actually.
> > We use the NAND controller in the bootROM, boot1/BL1, u-boot/UEFI, and
> > then Kernel stage.  By properly initializing the controller once we do
> > not need to reset it 4 different times.
> 
> This could be used as a reverse argument, issuing a reset will increase the boot
> time.
> 
> >
> >>
> >>> 2. The NAND controller reset in probe would certainly increase Linux
> >>> boot time so for certain iProc SoCs we might choose avoid NAND
> >>> controller reset to reduce boot time if possible.
> >>
> >> I recall this reason being mentioned before. I believe this only
> >> happens because the brcmnand driver doesn't yet handle configuring
> >> the timing registers, so iProc is implicitly relying on the
> >> bootloader to configure the NAND timings. Perhaps it's time that we
> >> fix that. I'd rather not add extra DT properties unless we actually
> >> need to [1]. And having proper timing configuration in the Linux
> >> driver will help improve speeds for all users (whose timings may not be
> configured in the bootloader).
> >
> > This is the very reason we need the optional reset property.  We need
> > to have timings configured by the linux driver or not.  Yes, in some
> > cases we will be relying on earlier boot stages to configure some of
> > the hardware.
> 
> Then instead of adding a "reset flag" to Device Tree, another approach could be
> to put the desired or currently configured exhaustive list of NAND timings in
> Device Tree, and based on that you could have this:
> 
> - the NAND controller driver finds that these timings match the current
> configuration, you are good to go
> 
> - the NAND controller drivers finds a difference in how current timings are
> configured vs. desired timings, and issues a controller reset, prior to applying
> new timing configuration

To add to this ...

The mechanism to reset is BRCM NAND controller is SOC specific so the
SoC independent BRCM NAND driver (i.e. brcmnand.c) does not know how
to reset the NAND controller.

For iProc SoC family, the NAND controller reset is through IDM register
space which is only iomap'ed by iproc_nand.c.

We might end-up having one more SoC specific callback which will be
Provided by iproc_nand.c to brcmnand.c.

> 
> - no timings are configured, reset the controller and use existing auto-detection
> capabilities like ONFI modes
> 
> Typically you would put the desired timings instead of the currently configured
> timings though..

Overall, it would good to support timing parameters through DT or ONFI but
for now have we can rely on reset and auto-devid configuration.

> 
> >
> >>
> >> I actually had some preliminary work to do some timing configuration
> >> according to the new timing information from nand_base.c/nand_timing.c.
> >> Unfortunately, I didn't complete this, and I'm no longer working at
> >> Broadcom, so I don't exactly have access to the HW docs for all the
> >> NAND controller revisions, nor do I have access to as much HW for testing...
> >>
> >> Brian
> >>
> >> [1] If we really do need a device tree differentiation, perhaps it
> >> would be better to just differentiate the compatible string than to
> >> have individual boolean properties. e.g.:
> >>
> >>     compatible = "brcm,iproc-nand-ns2", ...;
> >>
> > As described above - the option is not SoC specific.  It is system
> > specific.  In some systems we may wish to reset the NAND controller in
> > linux.  In some we may wish to rely on initialization that has already
> > been done to speed up boot times.
> 
> It seems to me like having this property is fine as long as you are describing that
> the controller *needs* a reset to operate properly, it does not strike me as a
> particularly well suited property if its side effect and main usage is to keep or
> wipe-out existing NAND timings.

IMHO, having SoC specific compatible string for NS2 is like saying
NAND controller on NS2 is different from other iProc SoCs whereas
Having optional DT flags for quirks/work-arounds (e.g. NAND controller
reset) is like saying NAND controller on NS2 same as other iProc SoCs
but some additional programming is required. 

--
Anup
