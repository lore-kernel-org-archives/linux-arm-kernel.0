From: marex@denx.de (Marek Vasut)
Date: Tue, 3 Dec 2013 16:09:36 +0100
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <529DEB2B.5060009@ti.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <201312031519.49171.marex@denx.de> <529DEB2B.5060009@ti.com>
Message-ID: <201312031609.36299.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sourav Poddar,

> Dear Marek Vasut,
> 
> On Tuesday 03 December 2013 07:49 PM, Marek Vasut wrote:
> > Dear Sourav Poddar,
> > 
> >> Dear Marek Vasut,
> >> 
> >> On Tuesday 03 December 2013 07:12 PM, Marek Vasut wrote:
> >>> Dear Sourav Poddar,
> >>> 
> >>>> Dear Marek Vasut,
> >>>> 
> >>>> On Tuesday 03 December 2013 05:29 AM, Marek Vasut wrote:
> >>>>> Dear Sourav Poddar,
> >>>>> 
> >>>>>> Dear Marek Vasut,
> >>>>>> 
> >>>>>> On Wednesday 27 November 2013 03:36 PM, Marek Vasut wrote:
> >>>>>>> Dear Sourav Poddar,
> >>>>>>> 
> >>>>>>>> Dear Marek Vasut, Huang,
> >>>>>>>> 
> >>>>>>>> On Wednesday 27 November 2013 02:57 PM, Marek Vasut wrote:
> >>>>>>>>> Dear Huang Shijie,
> >>>>>>>>> 
> >>>>>>>>>> 1.) Why add a new framework for SPI NOR?
> >>>>>>>>>> 
> >>>>>>>>>>        The SPI-NOR controller such as Freescale's Quadspi
> >>>>>>>>>>        controller is working in a different way from the SPI
> >>>>>>>>>>        bus. It should knows the NOR commands to find the right
> >>>>>>>>>>        LUT sequence. Unfortunately, the current code can not
> >>>>>>>>>>        meet this requirement.
> >>>>>>>>> 
> >>>>>>>>> Is there any kind of documentation for this controller available?
> >>>>>>>>> I cannot quite understand how this controller works and why can
> >>>>>>>>> it not be used with our current infrastructure.
> >>>>>>>> 
> >>>>>>>> I do have a similar requirement where my controller need to be
> >>>>>>>> configured from slave info. I have submiited a series in the mtd
> >>>>>>>> list adding that portion
> >>>>>>>> of handling such cases. Here, is the patch which specific to
> >>>>>>>> m25p80 part. http://patchwork.ozlabs.org/patch/294285/
> >>>>>>>> 
> >>>>>>>> The whole series can be found here:
> >>>>>>>> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg98691.h
> >>>>>>>> tm l
> >>>>>>> 
> >>>>>>> Is this TI QSPI the same thing as the Altera QSPI controller please
> >>>>>>> ?
> >>>>>> 
> >>>>>> No, its differenet.
> >>>>>> 
> >>>>>>> Otherwise, I seriously believe you and Huang should work on a
> >>>>>>> common infrastructure. I would first like to understand how is the
> >>>>>>> controller in DRA7xx different from regular SPI controller though.
> >>>>>>> Is there any kind of documentation I could study please?
> >>>>>> 
> >>>>>> Sorry, we dont have a public document yet.
> >>>>> 
> >>>>> Sorry for the delayed reply. I am processing the input on the QSPI
> >>>>> and I'm finally starting to understand what's going on in here.
> >>>> 
> >>>> Thanks for the response.
> >>>> 
> >>>>>> Though, this is what ti qspi contoller has
> >>>>>> 
> >>>>>> It supports two modes of operation, one is SPI mode(normal), other
> >>>>>> is the memory mapped read mode.
> >>>>>> 
> >>>>>> For SPI mode, the state machine remains the same as it is with other
> >>>>>> spi controller
> >>>>>> available.
> >>>>>> 
> >>>>>> For memory mapped, there is something more which we need to do
> >>>>>> around ..
> >>>>>> 
> >>>>>> 1. There is a qspi "set up" register available, which needs to be
> >>>>>> filled with
> >>>>>> 
> >>>>>>          information like flash opcode, dummy bytes etc. In short,
> >>>>>>          flash
> >>>>>> 
> >>>>>> specific
> >>>>>> 
> >>>>>>          details.
> >>>>>> 
> >>>>>> 2   if the above register is configured with the required opcodes,
> >>>>>> then whenever
> >>>>>> 
> >>>>>>          we need to use memory mapped operations, we need to do is
> >>>>>>          to
> >>>>>> 
> >>>>>> switch our
> >>>>>> 
> >>>>>>          qspi controller to memory mapped mode.
> >>>>>>         
> >>>>>>         Switching of this mode to memory mapped needs
> >>>>>>         
> >>>>>>          a )  write to a particular qspi register
> >>>>>>          b)   write to control module(optional based on SOC).
> >>>>>> 
> >>>>>> 3. Once the above steps are configured, then the flash data will be
> >>>>>> mapped to a
> >>>>>> 
> >>>>>>         particular memory address(SOC specific) from where the flash
> >>>>>>         data
> >>>>>> 
> >>>>>> can be read.
> >>>>> 
> >>>>> OK, but is the memory mapped mode of any use (but for booting I
> >>>>> suppose) ? How does it handle large SPI NOR flashes (we have spansion
> >>>>> devices as big as 128MiB), does it really hog a _large_ amount of
> >>>>> address space from the CPU address space ? Or is the operation
> >>>>> somehow indexed ? Why is it better than using DMA?
> >>>> 
> >>>> Memory mapped will be of use whenever we try to read the flash
> >>>> content. Instead of going through the entire SPI framework, and
> >>>> raising interrupts, we can
> >>>> memcpy the flash contents. I am using it for mounting a jffs2
> >>>> filesystem.
> >>>> 
> >>>> For me the memory mapped regions are like in the range 5c000000 -
> >>>> 5fffffff, so
> >>>> I can handle flash as large as 64MB.
> >>>> 
> >>>> As far as its comparison with DMA is concerned, I cant comment much
> >>>> about it.
> >>>> My Qspi controller does not support DMA :(:(. So, memory mapped
> >>>> becomes the best option option for me.
> >>> 
> >>> OK, understood. So to sling large chunks of memory from SPI NOR to your
> >>> DRAM, you need to issue these two steps in a loop:
> >>> 
> >>> 1) write into the controller register the starting address of the SPI
> >>> flash which you want to have available via the mmap interface
> >>> 2) memcpy() from this mmaped area to DRAM
> >>> 
> >>> correct? Won't the second step be pretty CPU-intensive
> >> 
> >> No, we dont need to write the starting address in any register.
> > 
> > OK, but how does this handle for example Spansion S70FL01GS , which is 1
> > GBit SPI NOR (128MB) if your memory map window is only 64MB?
> 
> So, the code added in m25p80 does not care about the flash size. It
> works for me
> for 64MB flash spansion (S25fl256s) and Macronix( mx66l51235l, 128 MB)
> flash.
> That memory mapped region info will from device tree. You can see
> patch16/17) of my
> series.
> so in m25p80_read,
>   memcpy(buf, base + from, len)
> where,
> base= memmaped base region
>           ex: ioremap(0x5c000000)
> 
> len =  can be anything, (64mb, 128 mb etc..). Just we need to
> make sure that we have ioremapped the required region through dt.
> 
> For me, SOC takes care of the memory mapped region required.
> 
> DRA7xx board with 64mb spansion flash has mmap region (5c000000 - 5fffffff)
> AM43x board with 128mb macronix flash has mmap region (30000000 -
> 33fffffff)

You mean 0x3000_0000 - 0x33ff_ffff (with one less 'f'), or am I wrong? But 
0x0400_0000 is only 64MiB, how can this map 128MiB SPI NOR? I am still not 
connecting with you here, I am sorry.

Does the QSPI controller simply chomp away N MiB of CPU address space? How big 
is the maximum N here ? I was under the impression that N=64 , but now I am a 
bit confused by your claim that you can use 128 MiB SPI NOR.

> 
> >> 1. we need to write opcodes(flash specific) in a qspi set up register.
> >> 2. Switch to mmap mode using qspi SWITCH register.
> >> 
> >> Memory mapped address need to be avilable though to m25p80_read api to
> >> do memcpy, which is currently done by get_buf api.
> > 
> > OK, got it.
> > 
> >> We dont need to do the steps in a loop.
> >> Point1 above is one time configurable.
> >> point2 above need to be done whenever we want to use mmap operations.
> > 
> > OK, but copying the SPI NOR will be pretty CPU intensive, correct? You'd
> > need to do memcpy() on a full 64MB of stuff on the CPU. I mean, that's
> > what we had DMA for thus far, so the CPU can do more useful things.
> 
> Yes, but there is no DMA available for my controller.

OK, got it, thanks for explaining!
