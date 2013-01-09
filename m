From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Jan 2013 09:52:15 -0800
Subject: [PATCH] Proposed removal of IS_ERR_OR_NULL() (was: Re: [PATCH
 1/4] gpiolib: introduce descriptor-based GPIO interface)
In-Reply-To: <20130109171206.GQ3931@n2100.arm.linux.org.uk>
References: <201301091035.23206.arnd@arndb.de>
 <20130109104414.GF3931@n2100.arm.linux.org.uk>
 <20130109111055.GG3931@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301090932400.6300@xanadu.home>
 <20130109150427.GL3931@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301091020580.6300@xanadu.home>
 <20130109155154.GN3931@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301091058070.6300@xanadu.home>
 <20130109162145.GO3931@n2100.arm.linux.org.uk>
 <20130109171206.GQ3931@n2100.arm.linux.org.uk>
Message-ID: <20130109175215.GU14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130109 09:15]:
> On Wed, Jan 09, 2013 at 04:21:45PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 09, 2013 at 11:09:23AM -0500, Nicolas Pitre wrote:
> > > On Wed, 9 Jan 2013, Russell King - ARM Linux wrote:
> > > 
> > > > On Wed, Jan 09, 2013 at 10:27:53AM -0500, Nicolas Pitre wrote:
> > > > > Anyone with good coccinelle skills around to deal with the users?
> > > > 
> > > > I'm not sure that's a solution.
> > > 
> > > Well, I was thinking that coccinelle could handle the majority of the 
> > > 354 users when the "fix" is obvious enough to be automated.
> > > 
> > > That said, if we want people to fix their code, it is probably necessary 
> > > to merge your patch right away so the warnings are actually being seen, 
> > > and revert it right before the final v3.8 release if the remaining 
> > > warnings are still too numerous.  Repeat with next cycle.
> > 
> > Well, this is what I currently have for arch/arm thus far, and ooh look,
> > we save some lines of code too.
> 
> Actually, the OMAP dmtimer.c code needs a few more fixes while we're
> reviewing this stuff...  This latest patch leaves three files in
> arch/arm still using IS_ERR_OR_NULL() as they do seem to want to
> legitimately check for error pointers _and_ NULL.
> 
> I'm restricting the patch below to just those cases where it's wrong
> in arch/arm.
> 
> The omap_device.c changes probably also deserve some explanation.  As
> far as I can see, if we have an 'od' then 'od->pdev' _must_ already
> be valid (pdev is passed into omap_device_alloc() which creates the
> 'od' - and the passed pdev better be checked _before_ it's passed in.)
> It also appears that oh->od will _never_ be an error pointer value -
> apart from tracing the paths creating that, there is some evidence for
> this with tests elsewhere just for NULL here.  And lastly
> omap_hwmod_lookup() is documented to _only_ return NULL on error, and
> review of it confirms that.

Looks correct to me.

Regards,

Tony
