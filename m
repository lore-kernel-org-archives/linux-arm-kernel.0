From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 6 Aug 2018 16:07:39 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu8XN-vP64G_NLHFcRUJ2fptSrmxfd6CHWDgHkJj073Hbg@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAPv3WKdxwoW5MAOvy6uEBEuMpsigMo98hyO+TpKMsFrKR9oBzg@mail.gmail.com>
 <CAKv+Gu8XN-vP64G_NLHFcRUJ2fptSrmxfd6CHWDgHkJj073Hbg@mail.gmail.com>
Message-ID: <CAPv3WKeVkWChEE7WjKuu__bg+zvh9dTNy=U_2jiSyWxFWiatbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard, Mikulas,

pon., 6 sie 2018 o 15:48 Ard Biesheuvel <ard.biesheuvel@linaro.org> napisa?(a):
>
> On 6 August 2018 at 15:41, Marcin Wojtas <mw@semihalf.com> wrote:
> > Hi Mikulas,
> >
> > pon., 6 sie 2018 o 14:42 Robin Murphy <robin.murphy@arm.com> napisa?(a):
> >>
> >> On 06/08/18 11:25, Mikulas Patocka wrote:
> >> [...]
> >> >> None of this explains why some transactions fail to make it across
> >> >> entirely. The overlapping writes in question write the same data to
> >> >> the memory locations that are covered by both, and so the ordering in
> >> >> which the transactions are received should not affect the outcome.
> >> >
> >> > You're right that the corruption couldn't be explained just by reordering
> >> > writes. My hypothesis is that the PCIe controller tries to disambiguate
> >> > the overlapping writes, but the disambiguation logic was not tested and it
> >> > is buggy. If there's a barrier between the overlapping writes, the PCIe
> >> > controller won't see any overlapping writes, so it won't trigger the
> >> > faulty disambiguation logic and it works.
> >> >
> >> > Could the ARM engineers look if there's some chicken bit in Cortex-A72
> >> > that could insert barriers between non-cached writes automatically?
> >>
> >> I don't think there is, and even if there was I imagine it would have a
> >> pretty hideous effect on non-coherent DMA buffers and the various other
> >> places in which we have Normal-NC mappings of actual system RAM.
> >>
> >> > I observe these kinds of corruptions:
> >> > - failing to write a few bytes
> >>
> >> That could potentially be explained by the reordering/atomicity issues
> >> Matt mentioned, i.e. the load is observing part of the store, before the
> >> store has fully completed.
> >>
> >> > - writing a few bytes that were written 16 bytes before
> >> > - writing a few bytes that were written 16 bytes after
> >>
> >> Those sound more like the interconnect or root complex ignoring the byte
> >> strobes on an unaligned burst, of which I think the simplistic view
> >> would be "it's broken".
> >>
> >> FWIW I stuck my old Nvidia 7600GT card in my Arm Juno r2 board (2x
> >> Cortex-A72), built your test program natively with GCC 8.1.1 at -O2, and
> >> it's still happily flickering pixels in the corner of the console after
> >> nearly an hour (in parallel with some iperf3 just to ensure plenty of
> >> PCIe traffic). I would strongly suspect this issue is particular to
> >> Armada 8k, so its' probably one for the Marvell folks to take a closer
> >> look at - I believe some previous interconnect issues on those SoCs were
> >> actually fixable in firmware.
> >>
> >>
> >
> > On my Macchiato I use GT630 card (nuveau driver) + debian + xfce
> > desktop and in dual monitor mode, I could run a couple of 1080p
> > streams. All smooth and I've never noticed any image corruption
> > whatsoever (I spent a lot of time in front of such setup). Just to be
> > on a safe side, can you send me a bootlog and your board revision? I'd
> > like to see your firware version and type.
> >
>
> Hi Marcin,
>
> Could you please try running his reproducer?

This is exactly what I plan to do, as soon as I can plug my GFX card
back to the board (tomorrow). Just to remain aligned - is it ok, if I
boot my debian with GT630 plugged, compile the program with -O2 and
simlply run it on /dev/fb0?

Best regards,
Marcin
