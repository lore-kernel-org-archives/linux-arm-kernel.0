From: horms@verge.net.au (Simon Horman)
Date: Mon, 9 Nov 2015 17:51:04 +0900
Subject: [PATCH] ARM: shmobile: r8a7793: Add thermal device to DT
In-Reply-To: <CAMuHMdX81Vy59uGmkiq6wLTrnWse-kMsHQRaEHFAUu5pUEtnWA@mail.gmail.com>
References: <1446795048-29767-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdV-xGYvsSU1xXvB1Z9ssPD0yW_mFg=vre+dyLzs6wmiTw@mail.gmail.com>
 <20151106091735.GA6122@verge.net.au>
 <CAMuHMdX1-4wmfnq0MuwNDd6RmvbZ=4HkKpRp28yeb5fLHKHn7A@mail.gmail.com>
 <20151109011504.GE4832@verge.net.au>
 <CAMuHMdX81Vy59uGmkiq6wLTrnWse-kMsHQRaEHFAUu5pUEtnWA@mail.gmail.com>
Message-ID: <20151109085104.GL4832@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 09:02:51AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Nov 9, 2015 at 2:15 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Nov 06, 2015 at 11:00:17AM +0100, Geert Uytterhoeven wrote:
> >> On Fri, Nov 6, 2015 at 10:17 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Fri, Nov 06, 2015 at 09:50:27AM +0100, Geert Uytterhoeven wrote:
> >> >> On Fri, Nov 6, 2015 at 8:30 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> >> >> > Instantiate the thermal sensor in the r8a7793 device tree.
> >> >> >
> >> >> > Based on very similar work for the r8a7790 by Magnus Damm.
> >> >>
> >> >> Given the similarity of R-Car M2-N and M2-W, I would have referred
> >> >> to r8a7791 ;-)
> >> >
> >> > True. Though for thermal the datasheet indicates H2 is also quite similar.
> >> >
> >> > I also prepared a very similar patch to add thermal to the r8a7794 (E2).
> >> > But the driver reports the sensor is broken - my inspection of the code
> >> > leads me to believe its not able to get a proper reading from the sensor.
> >> >
> >> > I'm wondering if anyone knows about this issue. Perhaps its specific
> >> > to my Alt board. Or a limitation of the E2?
> >>
> >> Using the same kernel image as on other boards? I.e. it's not an MSTP
> >> clock issue?
> >
> > I am using the same kernel image.
> > I wonder if it is an MSTP issue.
> >
> > Looking over the datasheet I see:
> >
> > For the r8a779[0-4] Thermal in MSTPSR5, RMSTPCR5.
> > I.e. there is a bit for thermal in those registers for all R-Car Gen-2
> > SoCs covered by the datasheet.
> >
> > But only on the r8a779[0-3] I see thermal in SRCR5, SRSTCLR5.
> > I.e. there is no bit for thermal in those registers for the r8a7794
> > which is different from the other R-Car Gen-2 SoCs covered by the datasheet.
> 
> Indeed, strange. Those are the reset registers, which we don't use yet.

Thanks for clearing up that mystery for me.

> Can you please check from U-Boot that the thermal module is not held in reset?
> On r8a7791/koelsch I get:
> 
> => md.l 0xe61500c4 1
> e61500c4: 00000000    ....
> => md.l 0xe6150954 1
> e6150954: 00000000    ....
> 
> I.e. no reset or reset clear bit is set.

I see the same as above.
