From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 08:46:27 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <20130214224710.GF11362@atomide.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
 <20130214224710.GF11362@atomide.com>
Message-ID: <20130215064626.GB30038@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 02:47:10PM -0800, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [130214 13:44]:
> > Hi,
> > 
> > On Thu, 14 Feb 2013, Paul Walmsley wrote:
> > 
> > > So instead of something bus-specific like that, a better way would be to 
> > > use something like:
> > > 
> > > va = dev->bus->ioremap( ... );
> > > va = dev->bus->iounmap( ... );
> > 
> > Something like this is what I was thinking.  Obviously there would be more
> > patches needed, for the various arches, etc.; and I'm not convinced that
> > the function pointer init is done at the right time yet. Comments welcome.
> > 
> > 
> > - Paul
> > 
> > 
> > From: Paul Walmsley <paul@pwsan.com>
> > Date: Thu, 14 Feb 2013 13:49:58 -0700
> > Subject: [PATCH] EXPERIMENTAL: device/ARM: allow buses to override ioremap*()
> >  and iounmap()
> > 
> > On some hardware, such as OMAP, the bus abstraction code needs to call
> > ioremap(), since some SoC-integration registers are located in the
> > device address space.  But generic device drivers should be able to
> > call ioremap() from driver code, for the majority of situations where
> > this isn't necessary.  This experimental patch allows Linux bus abstraction
> > code to override all of the ioremap*() and iounmap() functions.  In the OMAP
> > case, this would be used to return the previously-mapped address range from
> > the bus code, when called for the device's register area.  This would avoid
> > a duplicate TLB mapping for that space.
> > 
> > This might also be useful as a generic replacement for pci_ioremap_bar().
> > 
> > Compile-tested only.
> 
> The other option could be to allow custom ioremap function pointers 
> based on address range in __arm_ioremap_pfn_caller() the same way as
> the SoC specific static mappings are allowed. That would require adding
> a function pointer to struct map_desc.
> 
> Maybe that would do the trick?

I'm not sure we should even try that. I mean, eventually (maybe in 100
years) we wouldn't mach-* at all and even struct map_desc would be
dynamically initialized by data passed in via DTB, right ? Just consider
Arnd's patch for the "machine_desc-less" DT boot. If we add a function
pointer to struct map_desc, it will just become yet another function
pointer to be removed later.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/9d963284/attachment-0001.sig>
