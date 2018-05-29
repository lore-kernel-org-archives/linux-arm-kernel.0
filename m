From: peda@axentia.se (Peter Rosin)
Date: Tue, 29 May 2018 23:37:50 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <20180529195708.1fa41027@bbrezillon>
References: <20180329131054.22506-1-peda@axentia.se>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
 <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
 <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
 <19d68279-072e-7646-6fdd-8649578229ea@microchip.com>
 <20180529164911.29820e07@bbrezillon>
 <e3c34fb7-4881-3f49-b43b-1b07a8ab865d@microchip.com>
 <20180529171555.19dd723f@bbrezillon>
 <1affd186-7f78-8bb0-050e-da82143c2982@microchip.com>
 <20180529174621.50a9001a@bbrezillon> <20180529195708.1fa41027@bbrezillon>
Message-ID: <6d59f0b7-1213-f225-3e58-8326d384a1d8@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again!

I have spent some hours bringing out the old hardware with the 1024x768
panel from underneath the usual piles of junk and layers of dust...and
tried the current kernel on that one. And the display was stable even
when stressing with lots of NAND accesses.  *boggle*

Then I remembered that I had lowered the pixel clock (from 71.1 MHz to
65 MHz (and reduced the vertical blanking to maintain the refresh rate).
I didn't notice that this fixed the NAND interference, probably because
I ran NAND without DMA at the time? Anyway, if I reset the pixel clock
to 71.1 MHz (without increasing the vertical blanking, just to be nasty)
I can get the artifacts easily. But running with a pixel clock of 65 MHz
is not a problem at all, so we can consider NAND-DMA with that panel
solved.

However, now we know that this setup needs relatively little to start
working, and that might be good if we want to see if other changes has
any effect. I will look into that tomorrow. And we can also get a grip
on the critical bandwidth.

But first, answers to some random questions...


On 2018-05-29 09:25, Eugen Hristev wrote:
> One more thing: what are the actual nand commands which you use when you 
> get the glitches? read/write/erase ... ?

Erase seems to be least sensitive, read or write are worse (and similar)
according to my unscientific observations.

> What happens if you try to minimize the nand access? you also said at 
> some point that only *some* nand accesses cause glitches.

These systems will normally not access the NAND, but the displays look
like total crap when this happens. It can happen even when sync()ing
small files, but doesn't happen for every little file. Writing out or
reading a large file to/from NAND invariably triggers the issue.

> Another thing : even if the LCD displays a still image, the DMA still 
> feeds data to the LCD right ?

Absolutely. But since we are not playing some large video file (which
could have been stored on the NAND) we typically don't see the problem. It
only turns up in special circumstances. But these circumstances can't be
avoided and the display looks so freaking ugly when it happens...



On 2018-05-29 17:01, Eugen Hristev wrote:
> Then we can then try to force NFC SRAM DMA channels to use just DDR port 
> 1 or 2 for memcpy ?

I *think* my "horrid" patch does that. Specifically this line

+			desc->txd.phys = (desc->txd.phys & ~3) | 1;




On 2018-05-28 18:09, Nicolas Ferre wrote:
> Can you try to make all that you can to maximize the blanking period of 
> your screen (some are more tolerant than others according to that). By 
> doing so, you would allow the LCD FIFO to recover better after each 
> line. You might loose some columns on the side of your display but it 
> would give us a good idea of how far we are from getting rid of those 
> annoying LCD reset glitches (that are due to underruns on LCD FIFO).

I noticed that the 1024x768 panel is using 24bpp, not 16bpp as I
stated previously. Also, the horizontal blanking is 320 pixels, so a
total of 1024+320=1344 pixels/row and a pixel clock of 71.1 Mhz yields
18.9 us/row. The needed data during that time is 1024*24 bits so
1.30 Gbit/s. For the 65 MHz pixel clock, I get 1.19 Gbit/s. Assuming,
of course, that the pixel clock is actually what was requested... What
is the granularity of the pixel clock anyway?

For the bigger 1920x1080 panel, I have a horizontal blanking of 200
pixels and a pixel clock of 144 MHz, so 14.7 us/row -> 2.09 Gbit/s.
I suspect that no amount of fiddling with blanking is going to get
that anyway near the needed ~1.25 Gbit/s. Besides, the specs of the
panel say that the maximum horizontal blanking time is 280 pixels.
Seems futile to even try since this horizontal blanking time is so
much shorter for the larger panel (fewer and faster pixels) and the
longer time wasn't enough for the smaller panel to catch up. But ok,
in combination with something else it might be just enough. Will try
tomorrow...


On 2018-05-28 18:09, Boris Brezillon wrote:
> On Mon, 28 May 2018 17:52:53 +0200 Peter Rosin <peda@axentia.se> wrote:
>> The panels we are using only supports one resolution (each), but the issue
>> is there with both 1920x1080 at 16bpp and 1024x768 at 8bpp (~60Hz).
> 
> Duh! This adds to the weirdness of this issue. I'd thought that by
> dividing the required bandwidth by 2 you would get a reliable setup.

I think I might have misremembered seeing the issue with 1024x768 at 8bpp.
Sorry. But it *is* there for (the old variant of) 1024x768 at 24bpp, and
that is still only 60% or so of the bandwidth compared to 1920x1080 at 16bpp.

Cheers,
Peter
