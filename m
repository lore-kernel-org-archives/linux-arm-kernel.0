From: horms@verge.net.au (Simon Horman)
Date: Mon, 10 Nov 2014 09:59:44 +0900
Subject: [PATCH v3/resend] ARM: shmobile: Add early debugging support
 using SCIF(A)
In-Reply-To: <20777697.th35W64j5e@wuerfel>
References: <1415273910-32356-1-git-send-email-geert+renesas@glider.be>
 <3499638.LG41cHl0JS@wuerfel>
 <CAMuHMdUU7XK57a70HWP0+nfwaZ-sXQ5EC2CShgmxwx6JKnuyPQ@mail.gmail.com>
 <20777697.th35W64j5e@wuerfel>
Message-ID: <20141110005944.GE16836@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 02:26:45PM +0100, Arnd Bergmann wrote:
> On Thursday 06 November 2014 13:33:58 Geert Uytterhoeven wrote:
> > 
> > On Thu, Nov 6, 2014 at 12:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thursday 06 November 2014 12:38:30 Geert Uytterhoeven wrote:
> > >> Add serial port debug macros for the SCIF(A) serial ports.
> > >> This includes all shmobile SoCs, except for EMEV2.
> > 
> > > I don't object to this patch going in, but have you looked at doing
> > > just earlycon instead? We are still missing some fixmap changes
> > 
> > I was thinking about earlycon support...
> > 
> > > before that works on arm32, but in general, early looks nicer than
> > 
> > Good to know there are still some parts missing.
> > 
> > > debug_ll because it doesn't require you to build for a particular
> > > machine, with the downside that it's not available as early during
> > > boot.
> > 
> > Hence we're gonna need debug_ll anyway?
> > So far I only needed it for real early issues.
> 
> It depends on whether you were missing it in the past. shmobile
> so far only supports early_platform, which isn't quite as
> early as earlycon. If early_platform was good enough then
> earlycon will work too.
> 
> > >> +     {
> > >> +             .virtual        = 0xffe40000,
> > >> +             .pfn            = __phys_to_pfn(0xffe40000),
> > >> +             .length         = SZ_64K,
> > >> +             .type           = MT_DEVICE_NONSHARED
> > >> +     },
> > >> +#endif /* CONFIG_DEBUG_R8A7779_SCIF2 */
> > >>  };
> > >
> > > This should be done automatically if you call debug_ll_io_init() or
> > > have an empty map_io() callback.
> > 
> > On r8a7779 map_io() is not empty, but it didn't cover the SCIF registers,
> > cfr. the commit log:
> > 
> > > >   4. On SoCs using the legacy machine_desc.map_io(), an identity mapping
> > > >      of the SCIF(A) registers must be set up in .map_io(). On all but
> > > >      r8a7779 this was already done.
> 
> Ok. You can of course just call debug_ll_io_init() manually from the
> map_io function, it will create the same mapping.

This patch feels like is is ready for me to queue up.
Is that the consensus here?
