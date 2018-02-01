From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Feb 2018 09:32:22 +0100
Subject: [linux-sunxi] Re: [PATCH v6 2/2] media: V3s: Add support for
 Allwinner CSI.
In-Reply-To: <20180131144753.GB19945@bart.dudau.co.uk>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <201801260759.RyNhDZz4%fengguang.wu@intel.com>
 <20180126094658.aa70ed3f890464f6051e21e4@magewell.com>
 <20180126110041.f89848325b9ecfb07df387ca@magewell.com>
 <20180131030807.GA19945@bart.dudau.co.uk>
 <20180131074212.7hvb3nqkt22h2chg@flea.lan>
 <20180131144753.GB19945@bart.dudau.co.uk>
Message-ID: <20180201083222.q6rqql4nngn2bhiy@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 02:47:53PM +0000, Liviu Dudau wrote:
> On Wed, Jan 31, 2018 at 08:42:12AM +0100, Maxime Ripard wrote:
> > On Wed, Jan 31, 2018 at 03:08:08AM +0000, Liviu Dudau wrote:
> > > On Fri, Jan 26, 2018 at 11:00:41AM +0800, Yong wrote:
> > > > Hi Maxime,
> > > > 
> > > > On Fri, 26 Jan 2018 09:46:58 +0800
> > > > Yong <yong.deng@magewell.com> wrote:
> > > > 
> > > > > Hi Maxime,
> > > > > 
> > > > > Do you have any experience in solving this problem?
> > > > > It seems the PHYS_OFFSET maybe undeclared when the ARCH is not arm.
> > > > 
> > > > Got it.
> > > > Should I add 'depends on ARM' in Kconfig?
> > > 
> > > No, I don't think you should do that, you should fix the code.
> > > 
> > > The dma_addr_t addr that you've got is ideally coming from dma_alloc_coherent(),
> > > in which case the addr is already "suitable" for use by the device (because the
> > > bus where the device is attached to does all the address translations).
> > 
> > Like we're discussing in that other part of the thread with Thierry
> > and Arnd, things are slightly more complicated than that :)
> 
> Yeah, sorry, my threading of the discussion was broken and I've seen
> the rest of the thread after I have replied. My bad!
> 
> > 
> > In our case, the bus where the device is attached will not do the
> > address translations, and shouldn't.
> 
> In my view, the bus is already doing address translation at physical
> level, AFAIU it remaps the memory to zero.

Not really. It uses a separate bus with a different mapping for the
DMA accesses (and only the DMA accesses). The AXI (or AHB, I'm not
sure, but, well, the "registers" bus) doesn't remap anything in
itself, and we only describe this one usually in our DTs.

> What you (we?) need is a simple bus driver that registers the
> correct virt_to_bus()/bus_to_virt() hooks for the device that do
> this translation at the DMA API level as well.

Like I said, this only impact DMA transfers, and not the registers
accesses. We have other devices sitting on the same bus that do not
perform DMA accesses through that special memory bus and will not have
that mapping changed.

> > > If you apply PHYS_OFFSET forcefully to it you might get unexpected
> > > results.
> > 
> > Out of curiosity, what would be these unexpected results?
> 
> If in the future (or a parallel world setup) the device is sitting
> behind an IOMMU, the addr value might well be smaller than
> PHYS_OFFSET and you will under-wrap, possibly starting to hit kernel
> physical addresses (or anything sitting at the top of the physical
> memory).
> 
> From my time playing with IOMMUs and PCI domains, I've learned to
> treat the dma_addr_t as a cookie value and never try to do
> arithmetics with it.

I've never worked with PCI or IOMMU, so I tend to overlook them, but
yeah, you're right :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180201/c77b7b2b/attachment.sig>
