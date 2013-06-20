From: pavel@denx.de (Pavel Machek)
Date: Thu, 20 Jun 2013 16:44:33 +0200
Subject: [RFC PATCH 2/2] clocksource: dw_apb: allow build for
 architectures other than arm
In-Reply-To: <20130530053233.GL25186@sapphire.tkos.co.il>
References: <1369570367-994-2-git-send-email-baruch@tkos.co.il>
 <51A51271.2070506@linaro.org>
 <20130530053233.GL25186@sapphire.tkos.co.il>
Message-ID: <20130620144432.GA22115@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > >@@ -73,6 +77,9 @@ static void add_clocksource(struct device_node 
> > >  *source_timer)
> > >  }
> > >  static void __iomem *sched_io_base;
> > >+#ifndef CONFIG_HAVE_SETUP_SCHED_CLOCK
> > >+static u64 sched_clock_mult __read_mostly;
> > >+#endif
> > >  static u32 read_sched_clock(void)
> > >  {
> > >@@ -97,7 +104,11 @@ static void init_sched_clock(void)
> > >  	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
> > >  	of_node_put(sched_timer);
> > >+#ifdef CONFIG_HAVE_SETUP_SCHED_CLOCK
> > >  	setup_sched_clock(read_sched_clock, 32, rate);
> > >+#else
> > >+	sched_clock_mult = NSEC_PER_SEC / rate;
> > >+#endif
> > >  }
> > 
> > Can you rework this to not use #ifdefs within the function? They
> > make it annoying to read the code.
> > 
> > Instead maybe have a local setup_sched_clock() function that sets
> > the mult value for the !CONFIG_HAVE_SETUP_SCHED_CLOCK case?
> > 
> > >  static const struct of_device_id osctimer_ids[] __initconst = {
> > >@@ -124,3 +135,10 @@ void __init dw_apb_timer_init(void)
> > >  	init_sched_clock();
> > >  }
> > >+
> > >+#ifndef CONFIG_HAVE_SETUP_SCHED_CLOCK
> > >+unsigned long long notrace sched_clock()
> > >+{
> > >+	return read_sched_clock() * sched_clock_mult;
> > >+}
> > >+#endif
> > 
> > Also, can you try to condense the number of #ifndef
> > CONFIG_HAVE_SETUP_SCHED_CLOCK checks to one, and consolidate the
> > needed functions all in that one conditional?
> 
> Thanks for your comments. I'll rework the patch and resubmit.
> 
> I've just noticed that I have a bigger problem. read_sched_clock() returns 
> u32, not u64. This means that in a rate of, say, 100MHz it will wrap around 
> after a little more than 40 seconds. Would it make sense to put ARM's 32 bin 
> sched_clock extension code (arch/arm/kernel/sched_clock.c) is a common place 
> (maybe drivers/clocksource), and use that? There seems to be nothing ARM 
> specific in this code, after all.

Also note that there are two conflicting changes to this area
pending. It seems one in soc-next arm tree will prevail.

Please take a look...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
