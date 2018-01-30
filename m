From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jan 2018 08:54:41 +0100
Subject: [PATCH v6 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <CAK8P3a2HmPOTHAzqBnmim388pcWOE=fG50mG5HJifT=vzKOaTg@mail.gmail.com>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <CACRpkdan52UB7HOyH1gnHWg4CDke_VQxAdq8cBgwUroibE59Ow@mail.gmail.com>
 <20180129082533.6edmqgbauo6q5dgz@flea.lan>
 <CACRpkdYAGwUjr2C-w5U+WuG48pZAOUcnxFjznLbdF6Lmy1uZuQ@mail.gmail.com>
 <CAK8P3a2HmPOTHAzqBnmim388pcWOE=fG50mG5HJifT=vzKOaTg@mail.gmail.com>
Message-ID: <20180130075441.rqxzkwero6sdfak6@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 29, 2018 at 03:34:02PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 29, 2018 at 10:25 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> > On Mon, Jan 29, 2018 at 9:25 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> >> On Sat, Jan 27, 2018 at 05:14:26PM +0100, Linus Walleij wrote:
> >> However, in DT systems, that
> >> field is filled only with the parent's node dma-ranges property. In
> >> our case, and since the DT parenthood is based on the "control" bus,
> >> and not the "data" bus, our parent node would be the AXI bus, and not
> >> the memory bus that enforce those constraints.
> >>
> >> And other devices doing DMA through regular DMA accesses won't have
> >> that mapping, so we definitely shouldn't enforce it for all the
> >> devices there, but only the one connected to the separate memory bus.
> >>
> >> tl; dr: the DT is not really an option to store that info.
> >>
> >> I suggested setting dma_pfn_offset at probe, but Arnd didn't seem too
> >> fond of that approach either at the time.
> >>
> >> So, well, I guess we could do better. We just have no idea how :)
> >
> > Usually of Arnd cannot suggest something smart, neither can I :(
> >
> > If some aspect of the memory layout of the system *really* doesn't
> > fit into DT because of the assumptions that DT is doing about
> > how systems work, we have a problem.
> >
> > Is the problem that DT's model assumes that devices have one and
> > only one data port to the system memory, and that is how it
> > populates the Linux devices?
> >
> > I guess, if nothing else works, I would use auxdata in the board file.
> > It is our definitive last resort when DT doesn't hold.
> >
> > I.e. I would go into struct of_dev_auxdata
> > (from <linux/of_platform.h>) and add a
> > dma_pfn_offset field that gets set into the device's dma_pfn_offset
> > in drivers/of/platform.c overriding anything else and use that to hammer
> > it down in the boardfile.
> >
> > But I bet some DT people are going to have other ideas.
> 
> At one point we had discussed adding a 'dma-masters' property that
> lists all the buses on which a device can be a dma master, and
> the respective properties of those masters (iommu, coherency,
> offset, ...).
>
> IIRC at the time we decided that we could live without that complexity,
> but perhaps we cannot.

Are you talking about this ?
https://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/dma/dma.txt#L41

It doesn't seem to be related to that issue to me. And in our
particular cases, all the devices are DMA masters, the RAM is just
mapped to another address.

> Another local hack that we can do here is to have two separate
> device nodes and let the device driver bind to one device and then
> look up the other one through a phandle to look up a platform_device
> for it, which it can then use with the DMA mapping interface.

We have multiple devices doing that, a couple of them already merged
(mostly on the display side). I'd rather not do that.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180130/516523c9/attachment.sig>
