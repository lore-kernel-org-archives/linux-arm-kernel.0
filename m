From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 6 Oct 2015 14:41:19 +0100
Subject: [PATCH 3/5] mtd: brcmnand: Optional DT flag to reset IPROC NAND
 controller
In-Reply-To: <39063E8F96E11742B35A201CC5D095B7AD54C1@SJEXCHMB10.corp.ad.broadcom.com>
References: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
 <1443808606-21203-4-git-send-email-anup.patel@broadcom.com>
 <20151004214943.GA28904@localhost>
 <39063E8F96E11742B35A201CC5D095B7AD54C1@SJEXCHMB10.corp.ad.broadcom.com>
Message-ID: <20151006134119.GB26818@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anup,

On Mon, Oct 05, 2015 at 06:27:16AM +0000, Anup Patel wrote:
> > -----Original Message-----
> > From: Brian Norris [mailto:computersforpeace at gmail.com]
> > Sent: 05 October 2015 03:20
> > To: Anup Patel
> > Cc: linux-arm-kernel at lists.infradead.org; Rob Herring; Pawel Moll; Mark
> > Rutland; Ian Campbell; Kumar Gala; Catalin Marinas; Will Deacon; David
> > Woodhouse; Ray Jui; Scott Branden; Florian Fainelli; Pramod Kumar; Vikram
> > Prakash; Sandeep Tripathy; devicetree at vger.kernel.org; linux-
> > kernel at vger.kernel.org; linux-mtd at lists.infradead.org; bcm-kernel-feedback-
> > list; Rafal Milecki
> > Subject: Re: [PATCH 3/5] mtd: brcmnand: Optional DT flag to reset IPROC NAND
> > controller
> > 
> > + Rafal (to extend this mighty CC list)
> > 
> > On Fri, Oct 02, 2015 at 11:26:44PM +0530, Anup Patel wrote:
> > > The BRCM NAND controller on NS2 SoC requires a reset to cleanup
> > > previously configured NAND controller state.
> > >
> > > This patch adds optional boolean device tree flag named
> > > "brcm,nand-iproc-reset". If this flag is present in NAND controller DT
> > > node then BRCM IPROC NAND driver will reset the NAND controller before
> > > any commands are issued.
> > 
> > Is there a reason not to do this reset unconditionally? I recall this came up in
> > discussion previously, when the OpenWRT folks were trying to integrate with
> > BCMA, where this reset was one of the few differences between the platform-
> > device-based driver (i.e., this one) and the BCMA based driver. Might it help
> > simplify things a bit if we just did the same thing everywhere?
> 
> This driver is currently shared by Cygnus and NS2.
> 
> We had similar suggestion when this patch was reviewed
> internally in Broadcom.
> 
> The rationale for adding optional DT flag is as follows:
> 1. The NAND controller reset is currently required for NS2 only so
> that it is in sane state before any NAND commands are issued. We
> are not sure if Cygnus and all future iProc SoCs will require NAND
> controller reset.

I'm not sure this is a very strong reason. It seems fairly reasonable in
general to reset a HW block before using it.

> 2. The NAND controller reset in probe would certainly increase
> Linux boot time so for certain iProc SoCs we might choose avoid
> NAND controller reset to reduce boot time if possible.

I recall this reason being mentioned before. I believe this only happens
because the brcmnand driver doesn't yet handle configuring the timing
registers, so iProc is implicitly relying on the bootloader to configure
the NAND timings. Perhaps it's time that we fix that. I'd rather not add
extra DT properties unless we actually need to [1]. And having proper
timing configuration in the Linux driver will help improve speeds for
all users (whose timings may not be configured in the bootloader).

I actually had some preliminary work to do some timing configuration
according to the new timing information from nand_base.c/nand_timing.c.
Unfortunately, I didn't complete this, and I'm no longer working at
Broadcom, so I don't exactly have access to the HW docs for all the NAND
controller revisions, nor do I have access to as much HW for testing...

Brian

[1] If we really do need a device tree differentiation, perhaps it would
be better to just differentiate the compatible string than to have
individual boolean properties. e.g.:

	compatible = "brcm,iproc-nand-ns2", ...;
