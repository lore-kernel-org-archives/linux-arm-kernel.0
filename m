From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Feb 2018 16:54:32 +0100
Subject: [linux-sunxi] Re: [PATCH v6 2/2] media: V3s: Add support for
 Allwinner CSI.
In-Reply-To: <20180201113442.GC19945@bart.dudau.co.uk>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <201801260759.RyNhDZz4%fengguang.wu@intel.com>
 <20180126094658.aa70ed3f890464f6051e21e4@magewell.com>
 <20180126110041.f89848325b9ecfb07df387ca@magewell.com>
 <20180131030807.GA19945@bart.dudau.co.uk>
 <20180131074212.7hvb3nqkt22h2chg@flea.lan>
 <20180131144753.GB19945@bart.dudau.co.uk>
 <20180201083222.q6rqql4nngn2bhiy@flea.lan>
 <CAK8P3a01DqmVJKt6J2i_okVoeELJCUW0voW0r52EzBY7iF74xQ@mail.gmail.com>
 <20180201113442.GC19945@bart.dudau.co.uk>
Message-ID: <20180201155432.odv6p6rals3sujhx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 11:34:43AM +0000, Liviu Dudau wrote:
> On Thu, Feb 01, 2018 at 10:20:28AM +0100, Arnd Bergmann wrote:
> > On Thu, Feb 1, 2018 at 9:32 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > On Wed, Jan 31, 2018 at 02:47:53PM +0000, Liviu Dudau wrote:
> > >> On Wed, Jan 31, 2018 at 08:42:12AM +0100, Maxime Ripard wrote:
> > >> > On Wed, Jan 31, 2018 at 03:08:08AM +0000, Liviu Dudau wrote:
> > >> > > On Fri, Jan 26, 2018 at 11:00:41AM +0800, Yong wrote:
> > >>
> > >> Yeah, sorry, my threading of the discussion was broken and I've seen
> > >> the rest of the thread after I have replied. My bad!
> > >>
> > >> >
> > >> > In our case, the bus where the device is attached will not do the
> > >> > address translations, and shouldn't.
> > >>
> > >> In my view, the bus is already doing address translation at physical
> > >> level, AFAIU it remaps the memory to zero.
> > >
> > > Not really. It uses a separate bus with a different mapping for the
> > > DMA accesses (and only the DMA accesses). The AXI (or AHB, I'm not
> > > sure, but, well, the "registers" bus) doesn't remap anything in
> > > itself, and we only describe this one usually in our DTs.
> 
> I was actually thinking about the DMA bus (AXI bus, most likely), not the
> "registers" bus (yes, usually APB or AHB). The DMA bus is the one that does
> the implicit remapping for the addresses it uses, if I understood you correctly.
> 
> > Exactly, the DT model fundamentally assumes that each a device is
> > connected to exactly one bus, so we make up a device *tree* rather
> > than a non-directed mesh topology that you might see in modern
> > SoCs.
> 
> I think you are right, but we also have the registers property for a device node
> and that can be used for describing the "registers" bus. Now, it is possible
> that some driver code gets confused between accessing the device registers
> (which in Arm world happens through an APB or AHB bus) and the device doing system
> read/writes which usually happends through an AXI (or for very old systems, AHB) bus.
> 
> For the sake of making sure we are talking about the same thing and in hope
> that Maxime or Yong can give a more detailed picture of this device

Keep in mind that this part is heavily under-documented to us, and
this is mostly information collected through testing and reading
through the various vendor trees.

As far as I know, a few devices (Display Engine, hardware codec, the
CSI driver that spawned this discussion) are connected to the memory
through a proprietary bus that does the remapping. The registers part
is connected to an AHB bus.

> I'll re-iterate what a lot of devices in the Arm world look like
> nowadays:
> 
> - they have a bus for accessing the "registers" of the device, for controlling
>   the behaviour of that device. Inside the SoC, that happens through the
>   APB bus and it has a separate clock. The CPU has a view of those registers
>   through some mapping in the address space that has been backed by the hardware
>   engineers at design time and in DT we express that through the "registers" property,
>   plus the "apb_clk" for most of the bindings. In DT world we express the mapping
>   vis-a-vis the parent bus by using the "ranges" property.

We do have that.

> - they have a high speed bus for doing data transfers. Inside the SoC that
>   happens through an AXI or more modern CCI interconnect bus. The CPU does not
>   have a direct view on those transfers, but by using IOMMUs, SMMUs or simple
>   bus mastering capabilities it can gain knowledge of the state of the transfers
>   and/or influence the target memory.

Part of that bus controller allows to probe the bus bandwidth and / or
set limits for the various controllers connected to it, so it seems to
match that description.

>   In the DT world, we use the "dma-ranges" property like you say to
>   express the translations that happen on that bus.

Right, except that the way dma-ranges is parsed at the moment is that
it will look on the parent node for dma-ranges. In this case, the
parent in the DT will be our AHB bus, and not all the devices
connected on that AHB bus that do DMA go through that DMA bus with the
different mapping. So setting it there isn't an option.

> Maxime/Yong: does your device have more than one AXI bus for doing
> transfers?

Not as far as I know.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180201/923d8ebe/attachment.sig>
