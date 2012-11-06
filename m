From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2012 20:20:38 +0000
Subject: scheduler clock for MXS
In-Reply-To: <20121106134630.GD27643@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <5098CB9F.9030401@meduna.org>
 <20121106134630.GD27643@S2100-06.ap.freescale.net>
Message-ID: <20121106202038.GB32398@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 09:46:31PM +0800, Shawn Guo wrote:
> On Tue, Nov 06, 2012 at 09:34:39AM +0100, Stanislav Meduna wrote:
> > Shawn: could you try change the
> >   update_sched_clock();
> > to
> >   sched_clock_poll(sched_clock_timer.data);
> > right after update_sched_clock call in setup_sched_clock?
> > 
> With the change, it still wraps at 2 seconds.

And there's no way that such a change could ever go into mainline; it
can mean that the timer is registered into the timer subsystem before
the timer subsystem has been initialised.  That's why we postpone that
part to time_init().

(And it has _always_ been intended that this sched_clock() implementation
would be usable by the time setup_arch() completes...)
