From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 10 Jan 2013 20:03:27 +0100
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130110185505.GA22944@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130109231758.GA27065@obsidianresearch.com>
 <20130110071937.GG15212@avionic-0098.adnet.avionic-design.de>
 <201301100917.19577.arnd@arndb.de>
 <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
 <20130110182007.GA28004@obsidianresearch.com>
 <20130110185505.GA22944@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130110190327.GA23110@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 07:55:05PM +0100, Thierry Reding wrote:
> On Thu, Jan 10, 2013 at 11:20:07AM -0700, Jason Gunthorpe wrote:
> > On Thu, Jan 10, 2013 at 11:25:44AM +0100, Thierry Reding wrote:
> > > On Thu, Jan 10, 2013 at 09:17:19AM +0000, Arnd Bergmann wrote:
> > > > On Thursday 10 January 2013, Thierry Reding wrote:
> > > > > On Wed, Jan 09, 2013 at 04:17:58PM -0700, Jason Gunthorpe wrote:
> > > > > > On Wed, Jan 09, 2013 at 04:12:31PM -0700, Stephen Warren wrote:
> > > > > > You could decrease the size of the mapping to only span the bus
> > > > > > numbers that are configured for use via DT.
> > > > > 
> > > > > That won't work, unfortunately. The mapping is such that the bus number
> > > > > is not encoded in the uppermost bits, the extended register number is.
> > > > > So the only thing that we could do is decrease the size of the extended
> > > > > register space for *all* devices.
> > > > 
> > > > But you could still a method to map 16 separate areas per bus, each 65536
> > > > bytes long, which results in 1MB per bus. That is probably ok, since
> > > > very few systems have more than a handful of buses in practice.
> > > > 
> > > > In theory, doing static mappings on a per-page base would let you
> > > > do 16 devices at a time, but it's probably worth doing at this fine
> > > > granularity.
> > > 
> > > I don't understand how this would help. The encoding is like this:
> > > 
> > > 	[27:24] extended register number
> > > 	[23:16] bus number
> > > 	[15:11] device number
> > > 	[10: 8] function number
> > > 	[ 7: 0] register number
> > > 
> > > So it doesn't matter whether I use separate areas per bus or not. As
> > > soon as the whole extended configuration space needs to be accessed a
> > > whopping 28 bits (256 MiB) are required.
> > 
> > You'd piece a mapping together, each bus requires 16 64k mappings, a
> > simple 2d array of busnr*16 of pointers would do the trick. A more
> > clever solution would be to allocate contiguous virtual memory and
> > split that up..
> 
> Oh, I see. I'm not very familiar with the internals of remapping, so
> I'll need to do some more reading. Thanks for the hints.

I forgot to ask. What's the advantage of having a contiguous virtual
memory area and splitting it up versus remapping each chunk separately?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/48319579/attachment.sig>
