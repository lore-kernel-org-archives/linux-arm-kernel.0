From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 30 Aug 2013 14:12:10 +0100
Subject: [PATCH RFC v2 14/16] ARM: vexpress: remove custom .init_time hook
In-Reply-To: <1377856951.3655.34.camel@linaro1.home>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-15-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308291535.53005.arnd@arndb.de> <521F901B.3090305@gmail.com>
 <1377856951.3655.34.camel@linaro1.home>
Message-ID: <1377868330.3342.10.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-30 at 11:02 +0100, Jon Medhurst (Tixy) wrote:
> On Thu, 2013-08-29 at 20:16 +0200, Sebastian Hesselbarth wrote:
> > On 08/29/13 15:35, Arnd Bergmann wrote:
> > > On Tuesday 27 August 2013, Sebastian Hesselbarth wrote:
> > >> @@ -422,16 +419,8 @@ void __init v2m_dt_init_early(void)
> > >>                          pr_warning("vexpress: DT HBI (%x) is not matching "
> > >>                                          "hardware (%x)!\n", dt_hbi, hbi);
> > >>          }
> > >> -}
> > >> -
> > >> -static void __init v2m_dt_timer_init(void)
> > >> -{
> > >> -       of_clk_init(NULL);
> > >>
> > >> -       clocksource_of_init();
> > >> -
> > >> -       versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
> > >> -                               24000000);
> > >> +       versatile_sched_clock_init(vexpress_get_24mhz_clock_base(), 24000000);
> > >>   }
> > >
> > > You are moving versatile_sched_clock_init() ahead of clocksource_of_init(), which I suspect
> > > won't work. Have you checked this?
> > 
> > "Checked" as in "Tested", no I haven't.
> > 
> > But non-DT v2m has it in v2m_init_early also, while v2m_sp804_init()
> > is called in v2m_timer_init().
> > 
> > That matches the above approach taken for DT v2m where
> > versatile_sched_clock_init() is now called from v2m_dt_init_early()
> > and clocksource_of_init() called from arch-wide .timer_init.
> > 
> > get_maintainer.pl did not spit out any additional maintainer except
> > Russell of course. You know someone who can test the above?
> 
> After adding of_clk_init(NULL) to time_init() things boot OK for me with
> this patch. However, do we know that sched_clock is never going to get
> read before time_init() has actually started the clock it reads? Are we
> making things more fragile?

The versatile_sched_clock_init() is currently completely independent of
the clocksource infrastructure, so no harm should be done at all by
moving it.

Pawe?
