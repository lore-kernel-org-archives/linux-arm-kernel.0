From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 14 Jun 2011 17:21:52 -0400 (EDT)
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <201106142232.02217.arnd@arndb.de>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110614145329.GK23145@atomide.com>
	<alpine.LFD.2.00.1106141322530.2142@xanadu.home>
	<201106142232.02217.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1106141650520.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Jun 2011, Arnd Bergmann wrote:

> On Tuesday 14 June 2011 19:28:49 Nicolas Pitre wrote:
> > On Tue, 14 Jun 2011, Tony Lindgren wrote:
> > 
> > > * Nicolas Pitre <nicolas.pitre@linaro.org> [110614 00:04]:
> > > > +
> > > > +   for_each_tag(atag, atag_list) {
> > > > +           if (atag->hdr.tag == ATAG_CMDLINE) {
> > > > +                   setprop_string(dt, "/chosen", "bootargs",
> > > > +                                     atag->u.cmdline.cmdline);
> > > > +           } else if (atag->hdr.tag == ATAG_MEM) {
> > > > +                   uint32_t mem_reg_property[2];
> > > > +                   mem_reg_property[0] = cpu_to_fdt32(atag->u.mem.start);
> > > > +                   mem_reg_property[1] = cpu_to_fdt32(atag->u.mem.size);
> > > > +                   setprop(dt, "/memory", "reg", mem_reg_property,
> > > > +                              sizeof(mem_reg_property));
> > > > +           } else if (atag->hdr.tag == ATAG_INITRD2) {
> > > > +                   uint32_t initrd_start, initrd_size;
> > > > +                   initrd_start = atag->u.initrd.start;
> > > > +                   initrd_size = atag->u.initrd.size;
> > > > +                   setprop_cell(dt, "/chosen", "linux,initrd-start",
> > > > +                                   initrd_start);
> > > > +                   setprop_cell(dt, "/chosen", "linux,initrd-end",
> > > > +                                   initrd_start + initrd_size);
> > > > +           }
> > > > +   }
> > > 
> > > I think Russell posted a complete list of the ATAGs to translate
> > > somewhere, but at least ATAG_REVISION is missing here. That's being
> > > used quite a bit as system_rev to set things dynamically.
> > 
> > No problem.  This is a work in progress.  We still can test the concept 
> > and fine tune the actual set of ATAGs being translated.
> 
> Let's talk about the revision field now, because it doesn't have a
> direct correspondence in existing attributes.
> 
> Functionality-wise, this would probably be the "compatible" property
> of the root node, with its most specific name to match, but that's not
> trivial to generate.
> 
> In some cases, the system revisions have significant differences in their
> devices (why else would you care about the revision), which means that you
> actually need a different device tree per revision anyway. If that's the
> common case, we could just ignore it completely or instead have a way
> to choose a specific device tree from a list based on the revision.

I don't think this is all that common.  Almost half of the cases, the 
system_rev variable is assigned a specific value from direct probing, 
not from the ATAG_REVISION tag.  So there are only a few cases to 
consider.

Yet it is used only for a few things, which doesn't indicate the system 
differences are that significant in practice.

If we were to use this revision number, which appears to be completely 
arbitrary from one board to another, in order to select the appropriate 
DTB amongst many possibilities, then we'll need something in the DTB 
that can be correlated to this revision number in the first place.

And let's remember that this is only about some compatibility 
convenience for legacy systems.  I really don't want this to be 
over engineered.

> Another option would be to merge both the ATAG_REVISION and ATAG_SERIAL
> into a string and put them into the root "serial-number" property that
> is fairly easy to do, but would be harder to parse if you actually rely
> on specific values.

At some point, if some boards do use the ATAG to let the bootloader 
specify the board revision, that must be because this revision number 
can't be probed by software.  If this can be probed by software, then 
let's do it with kernel code instead.

Otherwise, if the revision number is effectively non probable, then I 
would guess it is the device tree's purpose to carry that information 
somehow, right?  Maybe this can be appended to the board name string?


Nicolas
