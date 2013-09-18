From: pavel@denx.de (Pavel Machek)
Date: Wed, 18 Sep 2013 13:01:59 +0200
Subject: [PATCHv4 2/2] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <alpine.DEB.2.02.1309180030060.4089@ionos.tec.linutronix.de>
References: <1379455361-13882-1-git-send-email-dinguyen@altera.com>
 <1379455361-13882-2-git-send-email-dinguyen@altera.com>
 <alpine.DEB.2.02.1309180030060.4089@ionos.tec.linutronix.de>
Message-ID: <20130918110159.GA32005@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2013-09-18 00:42:36, Thomas Gleixner wrote:
> On Tue, 17 Sep 2013, dinguyen at altera.com wrote: 
> 
> > read_sched_clock() should be the same as __apbt_read_clocksource().
> 
> So why is it using a separate function in the first place?


> > If a separate timer for the sched_clock exist, then read_sched_clock()
> > will return an incorrect value. The (sched_io_base + 0x4) needs to be in
> > the function for both cases.
> 
> It really took me some time to understand the "separate timer" part of
> the above explanation. Though that made me look at the actual
> implementation and I have to say, that this abuse of the device tree
> is really a unique masterpiece:

Well. We did a patch to fix timers on socfpga. You merged it. Then it
clashed with Heiko Stubner's work. Our version was dropped, his
version contained this code you complain about.

_I also complained about that
code_. http://www.spinics.net/lists/arm-kernel/msg252732.html . Seems
it was merged anyway. (2 months ago.)

And now we can't get the code fixed so that it at least works on our
hardware, because, guess what, you noticed upstream merged the gem
below, and you don't like it?

> static int num_called;
> static void __init dw_apb_timer_init(struct device_node *timer)
> {
>         switch (num_called) {
>         case 0:
>                 pr_debug("%s: found clockevent timer\n", __func__);
>                 add_clockevent(timer);
>                 of_node_put(timer);
>                 break;
>         case 1:
>                 pr_debug("%s: found clocksource timer\n", __func__);
>                 add_clocksource(timer);
>                 of_node_put(timer);
>                 init_sched_clock();
>                 break;
>         default:
>                 break;
>         }
> 
>         num_called++;
> }
> 
> So if you can use different nodes for clockevent and clocksource, why
> is that supposed to be dependent on the ordering? That's not how DT is
> supposed to be used. DT provides a clear description of the hardware,
> not some ordering dependent magic amended by utterly useless pr_debug()
> constructs.

You already had non-ugly version in your tree.

Alternatively, tell us what you want done. These boards have 2 to 4
identical timers, that can serve as both clockevent and
clocksource. We'd like to use one as clockevent and one as
clocksource. 

Regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
