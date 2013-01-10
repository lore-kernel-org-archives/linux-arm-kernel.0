From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 10 Jan 2013 21:20:07 +0100
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130110192417.GA18478@obsidianresearch.com>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130109231758.GA27065@obsidianresearch.com>
 <20130110071937.GG15212@avionic-0098.adnet.avionic-design.de>
 <201301100917.19577.arnd@arndb.de>
 <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
 <20130110182007.GA28004@obsidianresearch.com>
 <20130110185505.GA22944@avionic-0098.adnet.avionic-design.de>
 <20130110190327.GA23110@avionic-0098.adnet.avionic-design.de>
 <20130110192417.GA18478@obsidianresearch.com>
Message-ID: <20130110202007.GA26139@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 12:24:17PM -0700, Jason Gunthorpe wrote:
> On Thu, Jan 10, 2013 at 08:03:27PM +0100, Thierry Reding wrote:
> 
> > > > You'd piece a mapping together, each bus requires 16 64k mappings, a
> > > > simple 2d array of busnr*16 of pointers would do the trick. A more
> > > > clever solution would be to allocate contiguous virtual memory and
> > > > split that up..
>  
> > > Oh, I see. I'm not very familiar with the internals of remapping, so
> > > I'll need to do some more reading. Thanks for the hints.
> > 
> > I forgot to ask. What's the advantage of having a contiguous virtual
> > memory area and splitting it up versus remapping each chunk separately?
> 
> Not alot, really, but it saves you from the pointer array and
> associated overhead. IIRC it is fairly easy to do in the kernel.

I've been investigating this a bit, and one problem is that it will
prevent the driver from ever building as a module because the necessary
functions aren't exported and I'm not sure exporting them would be
acceptable. Currently PCI host controller drivers with MSI support can't
be built as modules because the MSI infrastructure requires it, but I
briefly discussed this with Bjorn at some point and it should be easy to
remove that requirement.

> Arnd's version is good too, but you would be restricted to aligned
> powers of two for the bus number range in the DT, which is probably
> not that big a deal either?

Stephen suggested on IRC that we could try to keep a bit of dynamicity
in the allocation scheme if we create the bus mapping when the first
device on the bus is probed and discard the mapping if no devices are
found.

Sounds like a good plan to me. Does anybody see any potential pitfalls?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/2ef4883c/attachment.sig>
