From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jun 2013 11:48:32 +0100
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130608183851.GB2354@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072101.44694.arnd@arndb.de>
 <20130607200054.GA9010@obsidianresearch.com>
 <20130608183851.GB2354@localhost>
Message-ID: <20130612104832.DE33A3E0A56@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 8 Jun 2013 15:38:52 -0300, Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:
> Hi Jason, Arnd:
> 
> Thanks for your reviews!
> 
> I agree with most of your suggestions so far. However, I'd like to discuss
> one point before we move forward with the other (imo, less importants)
> issues. See below.
> 
> On Fri, Jun 07, 2013 at 02:00:54PM -0600, Jason Gunthorpe wrote:
> [...]
> > 
> > 
> > Is the ranges right though? I was expecting this:
> > 
> >  ranges = <0  0x012f0000 0  0x8000000>
> > 
> > The 2nd address cell in the 2dword space should almost always be 0.
> > 
> > The 2nd address cell should be interprited as the offset within the
> > target's window, not as some kind of physical base address.
> > 
> > >>+ (Note that the windowid cell is encoding the target ID = 0x01 and attribute
> > >>+ ID = 0x2f, and the selected base address for the window is 0xe8000000).
> > 
> > ... The proper place to indicate the base address for the window is in
> > the mbus ranges:
> > 
> > mbus {
> >    ranges = <0x012f0000 0  0xe8000000  0x8000000>
> >    devbus-bootcs {
> >        ranges = <0  0x012f0000 0  0x8000000>
> >    }
> > }
> > 
> > We shouldn't mangle the DT format just to make it convenient for
> > humans to write - if this is a major problem then I'd try to use the
> > preprocessor first.. There are several reasonable solutions down that
> > path, IMHO.
> > 
> 
> Right. I think we have two options here for laying the DT ranges.
> 
> 1) This is the proposal implied in the patchset I sent:
> 
> mbus {
> 	ranges = < we only put the internal-reg translation here>
> 	devbus-bootcs {
> 		ranges = <0 {target_id/attribute} {window_physical_base} {size}>
> 	}
> }
> 
> Of course the above DT will be actually incomplete, for it'll lack a proper ranges
> entry to translate the devbus-bootcs address. So we chosed to do it dynamically
> in the mbus driver (see patch 05/14), and add the missing entry.
> 
> The information of the physical window base address is in this case in
> each child (devbus-bootcs, bootrom, and so on). The MBus driver walks
> each of its first-level children and allocates the window based on the
> address declared in the ranges property of each child, as shown above.
> 
> This is done mostly to avoid having that in the mbus node, and the nightmare
> to maintain it produces. See below.
> 
> 2) This is what Jason is proposing in his mail:
> 
> mbus {
> 	ranges = <{target_id/attribute} 0 {window_physical_base} {size}>
> 	devbus-bootcs {
> 		ranges = <0 {target_id/attribute} 0 {size}>
> 	}
> }
> 
> Of course this looks much cleaner, but it forces a lot of duplication
> in the DT files. Now, if you see some of the recent patches we've been
> sending, I think this duplication is very error-prone, and it'll be a
> nightmare to maintain. Let me propose an example to show this
> duplication:
> 
> Let's suppose we have a board "A" with its armada-A.dts,
> and a common one armada.dtsi.
> 
> The common dtsi file would have this ranges property:
> 
> /* armada.dtsi */
> mbus {
> 	ranges = < internal_regs_id 0 internal_regs_base internal_regs_size
> 		         bootrom_id 0       bootrom_base       bootrom_size >
> }
> 
> The A board has a NOR connected to some devbus, so we need to add it
> to the ranges, but also need to duplicate the ones in the common dtsi:
> 
> /* armada-A.dts */
> mbus {
> 	ranges = < internal_regs_id 0 internal_regs_base internal_regs_size
> 		         bootrom_id 0       bootrom_base       bootrom_size
> 		         devbus0_id 0       devbus0_base       devbus0_size >
> }
> 
> Now, if we add something at the common level, and extend the ranges
> property in the common armada.dtsi, we also have to go through *each* of
> the per-board dts files (for *each* board) adding that entry, because
> entries *need* to be duplicated. Otherwise you're effectively
> "shadowing" the entries.
> 
> It is precisely for this reason that I've decided to adopt option #1
> instead! Now, I'm not saying I like that option particularly.
> In fact it has a couple issues as well:
> 
>   1. The DT is *incomplete* and needs to be completed by the MBus
>      driver which, IMHO, sucks.
> 
>   2. Changing the DT dynamically in the kernel, means that new
>      properties are allocated to replace old ones, but the old ones
>      are *never* released. So if for any reason we do this often,
>      we're effectively "leaking" memory.

3. Modify DTC to support appending to properties.

g.
