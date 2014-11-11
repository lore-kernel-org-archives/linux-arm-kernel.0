From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Nov 2014 09:14:30 +0900
Subject: [PATCH v3/resend] ARM: shmobile: Add early debugging support
 using SCIF(A)
In-Reply-To: <CAMuHMdVJMB7Nz6dR414yG7jyneMbeoaRW43JQUKmW1u7i-=fbA@mail.gmail.com>
References: <1415273910-32356-1-git-send-email-geert+renesas@glider.be>
 <3499638.LG41cHl0JS@wuerfel>
 <CAMuHMdUU7XK57a70HWP0+nfwaZ-sXQ5EC2CShgmxwx6JKnuyPQ@mail.gmail.com>
 <20777697.th35W64j5e@wuerfel>
 <CAMuHMdVJMB7Nz6dR414yG7jyneMbeoaRW43JQUKmW1u7i-=fbA@mail.gmail.com>
Message-ID: <20141111001427.GA29665@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 09:01:45AM +0100, Geert Uytterhoeven wrote:
> On Thu, Nov 6, 2014 at 2:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> +     {
> >> >> +             .virtual        = 0xffe40000,
> >> >> +             .pfn            = __phys_to_pfn(0xffe40000),
> >> >> +             .length         = SZ_64K,
> >> >> +             .type           = MT_DEVICE_NONSHARED
> >> >> +     },
> >> >> +#endif /* CONFIG_DEBUG_R8A7779_SCIF2 */
> >> >>  };
> >> >
> >> > This should be done automatically if you call debug_ll_io_init() or
> >> > have an empty map_io() callback.
> >>
> >> On r8a7779 map_io() is not empty, but it didn't cover the SCIF registers,
> >> cfr. the commit log:
> >>
> >> > >   4. On SoCs using the legacy machine_desc.map_io(), an identity mapping
> >> > >      of the SCIF(A) registers must be set up in .map_io(). On all but
> >> > >      r8a7779 this was already done.
> >
> > Ok. You can of course just call debug_ll_io_init() manually from the
> > map_io function, it will create the same mapping.
> 
> Good idea, that would indeed simpify the logic, both in Kconfig and
> renesas-scif.S.
> 
> I gave it a try. On Armadillo it worked, on kzm9g it didn't.
> Probably the virtual address choice is wrong.
> 
> As I can't test it on the other boards using map_io(), I'd like to
> keep this as-is
> for now. We can migrate them gradually later.

I am happy to assist with testing but I think your incremental approach is
a good one: lets merge something that works and then improve on it.
