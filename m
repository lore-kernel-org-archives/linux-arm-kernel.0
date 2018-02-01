From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Feb 2018 10:20:28 +0100
Subject: [linux-sunxi] Re: [PATCH v6 2/2] media: V3s: Add support for
 Allwinner CSI.
In-Reply-To: <20180201083222.q6rqql4nngn2bhiy@flea.lan>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
 <201801260759.RyNhDZz4%fengguang.wu@intel.com>
 <20180126094658.aa70ed3f890464f6051e21e4@magewell.com>
 <20180126110041.f89848325b9ecfb07df387ca@magewell.com>
 <20180131030807.GA19945@bart.dudau.co.uk>
 <20180131074212.7hvb3nqkt22h2chg@flea.lan>
 <20180131144753.GB19945@bart.dudau.co.uk>
 <20180201083222.q6rqql4nngn2bhiy@flea.lan>
Message-ID: <CAK8P3a01DqmVJKt6J2i_okVoeELJCUW0voW0r52EzBY7iF74xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 1, 2018 at 9:32 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jan 31, 2018 at 02:47:53PM +0000, Liviu Dudau wrote:
>> On Wed, Jan 31, 2018 at 08:42:12AM +0100, Maxime Ripard wrote:
>> > On Wed, Jan 31, 2018 at 03:08:08AM +0000, Liviu Dudau wrote:
>> > > On Fri, Jan 26, 2018 at 11:00:41AM +0800, Yong wrote:
>>
>> Yeah, sorry, my threading of the discussion was broken and I've seen
>> the rest of the thread after I have replied. My bad!
>>
>> >
>> > In our case, the bus where the device is attached will not do the
>> > address translations, and shouldn't.
>>
>> In my view, the bus is already doing address translation at physical
>> level, AFAIU it remaps the memory to zero.
>
> Not really. It uses a separate bus with a different mapping for the
> DMA accesses (and only the DMA accesses). The AXI (or AHB, I'm not
> sure, but, well, the "registers" bus) doesn't remap anything in
> itself, and we only describe this one usually in our DTs.

Exactly, the DT model fundamentally assumes that each a device is
connected to exactly one bus, so we make up a device *tree* rather
than a non-directed mesh topology that you might see in modern
SoCs.

The "dma-ranges" property was introduced when this first started
falling apart and we got devices that had a different translation
in DMA direction compared to control direction (i.e. the "ranges"
property), but that still assumed that every device on a given bus
had the same view of DMA space.

With just "dma-ranges", we could easy deal with a topology where
each DMA master on an AXI bus sees main memory at address
zero but the CPU sees the same memory at a high address while
seeing the MMIO ranges at a low address.

What we cannot represent is multiple masters on the same
AXI bus that use a different translation. Making up arbitrary
intermediate buses would get this to work, but would likely
cause other problems in the future when we do something
else that relies on having a correct representation of the
hierarchy of all the AXI/AHB/APB buses in the system, such
as doing per-bus bandwidth allocation for child devices or
anything else that requires configuring the bus bridge itself.

>> What you (we?) need is a simple bus driver that registers the
>> correct virt_to_bus()/bus_to_virt() hooks for the device that do
>> this translation at the DMA API level as well.
>
> Like I said, this only impact DMA transfers, and not the registers
> accesses. We have other devices sitting on the same bus that do not
> perform DMA accesses through that special memory bus and will not have
> that mapping changed.

virt_to_bus()/bus_to_virt() don't actually exist on modern platforms any
more, but when they did, they were only about dma access, not
mmio access, so they would correspond to what we do with
'dma-ranges' rather than 'ranges'.

        Arnd
