From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 11:52:26 +0100
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130609014506.GB10027@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072101.44694.arnd@arndb.de>
 <20130607200054.GA9010@obsidianresearch.com>
 <20130608183851.GB2354@localhost>
 <20130609014506.GB10027@obsidianresearch.com>
Message-ID: <20130612105226.3F2723E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 8 Jun 2013 19:45:06 -0600, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> On Sat, Jun 08, 2013 at 03:38:52PM -0300, Ezequiel Garcia wrote:
> 
> > > mbus {
> > >    ranges = <0x012f0000 0  0xe8000000  0x8000000>
> > >    devbus-bootcs {
> > >        ranges = <0  0x012f0000 0  0x8000000>
> > >    }
> > > }
> > > 
> > > We shouldn't mangle the DT format just to make it convenient for
> > > humans to write - if this is a major problem then I'd try to use the
> > > preprocessor first.. There are several reasonable solutions down that
> > > path, IMHO.
> > > 
> > 
> > Right. I think we have two options here for laying the DT ranges.
> > 
> > 1) This is the proposal implied in the patchset I sent:
> > 
> > mbus {
> > 	ranges = < we only put the internal-reg translation here>
> > 	devbus-bootcs {
> > 		ranges = <0 {target_id/attribute}
> > 	{window_physical_base} {size}>
>         ^^^^^^^^^^^^^^^^^^^^^^
> 
> This is the mangling I was referring to. It needs to be the offset
> into the target, it can't be something else.
> 
> I understand your motivation, but this is not a good method of
> encoding this in DT.
> 
> There is nothing especially wrong with updating the ranges at runtime,
> but don't use the 2nd cell in the 2dw address to encode the desired
> base address.

+1 The design intent of the ranges property is it isolates the parent
address space from the child address space. Encoding the physical
address into the second cell breaks that isolation. Sure, you can do it
and it will work, but then it forces a change to the parent ranges to
propagate down to all the child reg and ranges properties.

g.
