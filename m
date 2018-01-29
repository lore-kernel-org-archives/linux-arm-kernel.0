From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jan 2018 10:25:07 +0100
Subject: [PATCH v6 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <20180129082533.6edmqgbauo6q5dgz@flea.lan>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <CACRpkdan52UB7HOyH1gnHWg4CDke_VQxAdq8cBgwUroibE59Ow@mail.gmail.com>
 <20180129082533.6edmqgbauo6q5dgz@flea.lan>
Message-ID: <CACRpkdYAGwUjr2C-w5U+WuG48pZAOUcnxFjznLbdF6Lmy1uZuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 9:25 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Jan 27, 2018 at 05:14:26PM +0100, Linus Walleij wrote:
>> > +void sun6i_csi_update_buf_addr(struct sun6i_csi *csi, dma_addr_t addr)
>> > +{
>> > +       struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
>> > +       /* transform physical address to bus address */
>> > +       dma_addr_t bus_addr = addr - PHYS_OFFSET;
>>
>> I am sorry if this is an unjustified drive-by comment. Maybe you
>> have already investigate other ways to do this.
>
> It's definitely not unjustified :)
>
>> Accessing PHYS_OFFSET directly seems unintuitive and not good
>> practice.
>>
>> But normally an dma_addr_t only comes from some function inside
>> <linux/dma-mapping.h> such as: dma_alloc_coherent() for a contigous
>> buffer which is coherent in physical memory, or from some buffer <=
>> 64KB that is switching ownership between device and CPU explicitly
>> with dma_map* or so. Did you check with Documentation/DMA-API.txt?
>
> So, I've discussed this with Arnd a month ago or so, because I'm not
> really fond of the current approach but we haven't found better way to
> do it yet.
>
> The issue is that all the DMA accesses are done not through the main
> AXI bus, but through a separate bus dedicated for memory accesses,
> where the RAM is mapped at the address 0. So the CPU and DMA devices
> have a different mapping for the RAM.

Aha, I see the problem ... but since the dma_addr_t is supposed
to actually be the address the DMA controller sees, something is
apparently broken.

> I guess we could address this by using the field dma_pfn_offset that
> seems to be used in similar situations.

That does seem like the right thing to do (to me).

> However, in DT systems, that
> field is filled only with the parent's node dma-ranges property. In
> our case, and since the DT parenthood is based on the "control" bus,
> and not the "data" bus, our parent node would be the AXI bus, and not
> the memory bus that enforce those constraints.
>
> And other devices doing DMA through regular DMA accesses won't have
> that mapping, so we definitely shouldn't enforce it for all the
> devices there, but only the one connected to the separate memory bus.
>
> tl; dr: the DT is not really an option to store that info.
>
> I suggested setting dma_pfn_offset at probe, but Arnd didn't seem too
> fond of that approach either at the time.
>
> So, well, I guess we could do better. We just have no idea how :)

Usually of Arnd cannot suggest something smart, neither can I :(

If some aspect of the memory layout of the system *really* doesn't
fit into DT because of the assumptions that DT is doing about
how systems work, we have a problem.

Is the problem that DT's model assumes that devices have one and
only one data port to the system memory, and that is how it
populates the Linux devices?

I guess, if nothing else works, I would use auxdata in the board file.
It is our definitive last resort when DT doesn't hold.

I.e. I would go into struct of_dev_auxdata
(from <linux/of_platform.h>) and add a
dma_pfn_offset field that gets set into the device's dma_pfn_offset
in drivers/of/platform.c overriding anything else and use that to hammer
it down in the boardfile.

But I bet some DT people are going to have other ideas.

Yours,
Linus Walleij
