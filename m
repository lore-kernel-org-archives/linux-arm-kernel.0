From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Nov 2014 13:54:12 +0100
Subject: [PATCH 08/25] ARM: shmobile: r8a7790: sound enables Audio DMAC
 peri peri entry on DTSI
In-Reply-To: <87a93pxtlr.wl%kuninori.morimoto.gx@renesas.com>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
 <1877842.49FtTfL2eK@wuerfel> <87a93pxtlr.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <15076656.0HaaBPou9k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 November 2014 00:03:50 Kuninori Morimoto wrote:
> Hi Arnd
> 
> > >                                 "mem_src6",     "src6_mem",
> > >                                 "mem_src7",     "src7_mem",
> > >                                 "mem_src8",     "src8_mem",
> > > -                               "mem_src9",     "src9_mem";
> > > +                               "mem_src9",     "src9_mem",
> > > +
> > > +                               "src0_ssiu0",           "src1_ssiu0",           "src2_ssiu0",           "src3_ssiu0",           "src4_ssiu0",
> > > +                               "src0_ssiu1",           "src1_ssiu1",           "src2_ssiu1",           "src3_ssiu1",           "src4_ssiu1",
> > > +                               "src0_ssiu2",           "src1_ssiu2",           "src2_ssiu2",           "src3_ssiu2",           "src4_ssiu2",
> > > 
> > 
> > I have to note that this looks rather weird and that none of the names
> > are documented in the binding.
> > 
> > Can you explain why this device uses over 100 DMA channels and put the
> > exact naming rules into the binding?
> > Do you expect all channels to be in use simultaneously?
> 
> This device has 10 sound channels, and using 3 kind of IPs.
> Then, data input/output needs DMA channel which needs specific ID to using.
> Above name has ID pair for it, so there is much combination. 
> These specific ID is based on SoC, not board.
> Sound driver / DMAEngine can get specific ID from above.
> 
> Indeed binding itself was not documented yet.
> I will add it ASAP.

It sounds like you have some device-to-device DMAs here, which isn't
supported by the generic dmaengine binding at all, and I don't think
the driver currently attempts to use them.

Is that correct? Could you try to remove those from the binding and
just leave the device-to-memory and memory-to-device channels there?
If we ever want to support those, we probably have to extend the
dmaengine binding first, and then the driver binding would also look
different.

	Arnd
