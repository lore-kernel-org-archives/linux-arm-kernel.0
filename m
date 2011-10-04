From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Oct 2011 10:50:57 -0700
Subject: Please help with the OMAP static mapping mess
In-Reply-To: <CAMQu2gxgRZzb6hh5pOVBgaPUZEizEqBr_e358MBuD_xHJOvX3Q@mail.gmail.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
	<alpine.LFD.2.02.1110031827440.9106@xanadu.home>
	<20111003225908.GL6324@atomide.com>
	<CAMQu2gxgRZzb6hh5pOVBgaPUZEizEqBr_e358MBuD_xHJOvX3Q@mail.gmail.com>
Message-ID: <20111004175057.GU6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [111003 22:45]:
> On Tue, Oct 4, 2011 at 4:29 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Nicolas Pitre <nico@fluxnic.net> [111003 15:05]:
> >> On Mon, 3 Oct 2011, Nicolas Pitre wrote:
> >>
> >> > On Mon, 3 Oct 2011, Tony Lindgren wrote:
> >> >
> >> > > * Nicolas Pitre <nico@fluxnic.net> [111003 11:26]:
> >> > > >
> >> > > > Furthermore... there is also a static mapping for physical address
> >> > > > 0x4e000000 using virtual address 0xff100000 which is already reserved
> >> > > > for other purposes i.e. the consistent DMA area. ?It is not immediately
> >> > > > obvious where this comes from without being intimate with the OMAP code.
> >> > > > Can this be fixed as well i.e. moved elsewhere please?
> >> > >
> >> > > This sounds like a bug somewhere. Which omap are you seeing this on?
> >> >
> >> > OMAP4430 on a Panda board.
> >> >
> >> > Here are the static mappings I'm seeing:
> >> >
> >> > phys = 0x44000000 virt = 0xf8000000 size = 0x100000
> >> > phys = 0x4a000000 virt = 0xfc000000 size = 0x400000
> >> > phys = 0x50000000 virt = 0xf9000000 size = 0x100000
> >> > phys = 0x4c000000 virt = 0xfd100000 size = 0x100000
> >> > phys = 0x4d000000 virt = 0xfe100000 size = 0x100000
> >> > phys = 0x4e000000 virt = 0xff100000 size = 0x100000 <---
> >> > phys = 0x48000000 virt = 0xfa000000 size = 0x400000
> >> > phys = 0x54000000 virt = 0xfe800000 size = 0x800000
> >>
> >> It looks like this comes from OMAP44XX_DMM_VIRT.
> >>
> >> #define OMAP44XX_DMM_PHYS ? ? ? OMAP44XX_DMM_BASE
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? /* 0x4e000000 --> 0xfd300000 */
> >> #define OMAP44XX_DMM_VIRT ? ? ? (OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
> >> #define OMAP44XX_DMM_SIZE ? ? ? SZ_1M
> >>
> >> The comment suggesting a mapping correspondance is obviously wrong. We have:
> >>
> >> #define OMAP44XX_DMM_BASE ? ? ? 0x4e000000
> >> #define OMAP4_L3_PER_IO_OFFSET ?0xb1100000
> >>
> >> Hence 0x4e000000 + 0xb1100000 = 0xff100000.
> >
> > Seem like it might cause some random patterns in tiler :)
> > Santosh, can youp please check it?
> >
> This is already fixed Tony. You have pulled that patch.
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg55258.html

OK thanks. Yup, looks like it's queued up in l3 branch.

Tony
