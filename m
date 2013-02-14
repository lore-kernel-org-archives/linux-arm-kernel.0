From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 13 Feb 2013 23:43:26 -0500 (EST)
Subject: [PATCH 10/17] ARM: update atag-to-fdt code to be endian agnostic
In-Reply-To: <511B78BC.7000708@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-11-git-send-email-ben.dooks@codethink.co.uk>
 <20130209120525.GD17833@n2100.arm.linux.org.uk>
 <51194381.9030505@codethink.co.uk>
 <alpine.LFD.2.03.1302121646380.1242@fluxnic.net>
 <511B78BC.7000708@codethink.co.uk>
Message-ID: <alpine.LFD.2.03.1302132336410.8736@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Feb 2013, Ben Dooks wrote:

> On 12/02/13 21:53, Nicolas Pitre wrote:
> > On Mon, 11 Feb 2013, Ben Dooks wrote:
> > 
> > > On 09/02/13 12:05, Russell King - ARM Linux wrote:
> > > > On Fri, Feb 08, 2013 at 11:17:40PM +0000, Ben Dooks wrote:
> > > > > -	if (atag->hdr.tag != ATAG_CORE ||
> > > > > -	    (atag->hdr.size != tag_size(tag_core)&&
> > > > > -	     atag->hdr.size != 2))
> > > > > +	if (atag->hdr.tag != atag32_to_cpu(ATAG_CORE) ||
> > > > > +	    (atag->hdr.size != atag32_to_cpu(tag_size(tag_core))&&
> > > > > +	     atag->hdr.size != atag32_to_cpu(2)))
> > > > 
> > > > This is wrong.  You're saying that "ATAG_CORE" is in LE32 format.  It
> > > > isn't.  It's in CPU endian format.  If you want to do this kind of
> > > > thing,
> > > > you also need to define cpu_to_atag32() macros as well, otherwise this
> > > > will cause sparse warnings.
> > > > 
> > > > > -			initrd_start = atag->u.initrd.start;
> > > > > -			initrd_size = atag->u.initrd.size;
> > > > > +			initrd_start =
> > > > > atag32_to_cpu(atag->u.initrd.start);
> > > > > +			initrd_size =
> > > > > atag32_to_cpu(____atag->u.initrd.size);
> > > > 
> > > > Where did those four underscores come from?  Has this been built?
> > > 
> > > I probably missed building this one. I've been mostly testing with DT
> > > based systems.
> > 
> > Is this BE8 mode available on old systems?  Or, will those BE8
> > capable old systems have BE userland compiled for them?
> 
> BE8 is for ARMv6 and ARMv7 form of big endian. ARMv5 is BE32.

I think that by now all ARMv6+ targets should be DT enabled.  So you 
shouldn't have to care about ATAGs at all.

> > Where I want to get to is: do we need to support BE8 mode for ATAG based
> > systems at all, given that most if not all the modern ones should be DT
> > based now?  Making the ATAG code BE8 aware is looking to be quite
> > invasive for potentially no users at all.
> 
> The change is only useful when using a BE8 compiled kernel with a
> boot loader environment that is LE.

That's what CONFIG_ARM_ATAG_DTB_COMPAT is for.  So only that code would 
need to swap the ATAG data.

> Even if the ATAGs do not need
> fixing up, then we have a issue with uboot checking the zImage magic.

I gave you a patch for that.

> I have pushed the ATAGs issues to a new series as it is not necessary
> for the current work we are doing with highbank primarily.

I don't think it is needed at all given that BE8 is available mainly on 
targets supporting DT, and is likely to be used on targets that do 
support only DT.


Nicolas
