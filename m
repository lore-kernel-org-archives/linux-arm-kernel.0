From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 23 Sep 2013 10:58:31 -0500
Subject: [PATCHv4 2/2] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <201309181332.31561.heiko@sntech.de>
References: <1379455361-13882-1-git-send-email-dinguyen@altera.com>
 <alpine.DEB.2.02.1309180030060.4089@ionos.tec.linutronix.de>
 <20130918110159.GA32005@amd.pavel.ucw.cz>
 <201309181332.31561.heiko@sntech.de>
Message-ID: <1379951911.18377.9.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, 2013-09-18 at 13:32 +0200, Heiko St?bner wrote:
> Am Mittwoch, 18. September 2013, 13:01:59 schrieb Pavel Machek:
> > On Wed 2013-09-18 00:42:36, Thomas Gleixner wrote:
> > > On Tue, 17 Sep 2013, dinguyen at altera.com wrote:
> > And now we can't get the code fixed so that it at least works on our
> > hardware, because, guess what, you noticed upstream merged the gem
> > below, and you don't like it?
> > 
> > > static int num_called;
> > > static void __init dw_apb_timer_init(struct device_node *timer)
> > > {
> > > 
> > >         switch (num_called) {
> > >         
> > >         case 0:
> > >                 pr_debug("%s: found clockevent timer\n", __func__);
> > >                 add_clockevent(timer);
> > >                 of_node_put(timer);
> > >                 break;
> > >         
> > >         case 1:
> > >                 pr_debug("%s: found clocksource timer\n", __func__);
> > >                 add_clocksource(timer);
> > >                 of_node_put(timer);
> > >                 init_sched_clock();
> > >                 break;
> > >         
> > >         default:
> > >                 break;
> > >         
> > >         }
> > >         
> > >         num_called++;
> > > 
> > > }
> > > 
> > > So if you can use different nodes for clockevent and clocksource, why
> > > is that supposed to be dependent on the ordering? That's not how DT is
> > > supposed to be used. DT provides a clear description of the hardware,
> > > not some ordering dependent magic amended by utterly useless pr_debug()
> > > constructs.
> > 
> > You already had non-ugly version in your tree.
> > 
> > Alternatively, tell us what you want done. These boards have 2 to 4
> > identical timers, that can serve as both clockevent and
> > clocksource. We'd like to use one as clockevent and one as
> > clocksource.
> 
> I would also be interested in the "right" way to do this.
> 
> As Pavel already said, the hardware is identical for all N separate timer 
> blocks, so as the DT should be describing the hardware only, there is no way 
> to specifiy one for the clockevent and another for the clocksource there.
> 
> At first I kept using the non-standard init which required it being called from 
> platform code, but got the request to convert the driver to use 
> CLOCKSOURCE_OF_DECLARE to remove the need for separate call.
> 
> As you will know CLOCKSOURCE_OF_DECLARE calls the init function for each found 
> dt node for a matching device, resulting in N calls to dw_apb_timer_init.
> So my solution was to just grab the first one as clockevent and second one as 
> clocksource.
> 
> Therefore I'm all ears for how to solve this in a better way :-)
> 

I'm just wondering if you have gotten a chance to give this patch
anymore thought? The state of the socfpga platform for 3.12 is that it
will not boot without this patch(mainly because of a DTS binding
change). This patch mainly only fixes that issue.

If you would like dw_apb_timer_init() fix for 3.13, can you please give
us advice, so that we can get started on it in time for 3.13?

Thanks,
Dinh
> 
> Heiko
> 
