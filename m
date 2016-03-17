From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 17 Mar 2016 11:58:05 +0100
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <20160317072721.GJ30977@lukather>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
Message-ID: <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2016 at 08:27, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Mar 10, 2016 at 10:01:04AM +0100, Michal Suchanek wrote:
>> Hello,
>>
>> On 6 March 2016 at 22:42, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Fri, Feb 26, 2016 at 01:51:51PM +0100, Michal Suchanek wrote:
>>
>> >> Besides this non-technical objection there were multiple technical
>> >> objections.
>> >>
>> >> IIRC one was that the driver does not handle the case when the DMA
>> >> channels are not available. As I understand it the channels are
>> >> exclusively reserved for a particular peripherial on sunxi platform so
>> >> this ShoulNotHappen(tm). So it's probably fine for the driver to fail
>> >> probe  when you have broken DT or no DMA engine support for sunxi
>> >> platform.
>> >
>> > There's a quite trivial scenario that would trigger this: if the dma
>> > driver or dmaengine is not enabled / loaded.
>>
>> There are other trivial scenarios under which the driver will fail
>> like loading wrong DT, not compiling or loading the sunxi pinmux
>> driver, and whatnot.
>
> I don't see what the pinmux has to do with SPI and DMA, and you're
> wrong, the pinmux driver is always compiled in if you enable the sunxi
> support.
>
> And you're missing the whole point. DMA accesses are optional, pinmux
> and proper machine support are not.
>
>> When you misconfigure your kernel it does not work. So long as the
>> driver just fails and does not crash and burn it's normal. Since the
>> driver is pretty much useless without DMA as it is now (63 byte
>> transfer limit) losing the non-DMA functionality when DMA engine is
>> not compiled-in does not seem that terrible.
>
> You're mixing two things up: the fact that we can't do more than the
> FIFO length in PIO and that we're missing DMA support. We have patches
> to address both, and there's no depedency between the two.

The only thing is that although DMA is optional on pretty much any
system you will have DMA available unless you broke your config. You
really do want the DMA support when it is available. So there will be
nobody testing the non-DMA part and it will be prone to bitrot.

Thanks

Michal
