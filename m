From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 21 Jun 2013 10:12:37 +0200 (CEST)
Subject: clocksource with changing frequency?
In-Reply-To: <51C39B1A.5070902@linaro.org>
References: <f5e5d3d7-699d-4f89-80c8-849e432e8b26@VA3EHSMHS017.ehs.local>
 <51C39B1A.5070902@linaro.org>
Message-ID: <alpine.DEB.2.02.1306211010000.4013@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jun 2013, John Stultz wrote:

> On 06/20/2013 05:01 PM, S?ren Brinkmann wrote:
> > Hi all,
> > 
> > I have a question/problem with a clocksource whose input frequency can
> > change.
> 
> That behavior isn't supported by the clocksource core. We expect frequency
> changing clocksources to be detected and disqualified (as we do w/ freq
> changing TSCs on older laptops).
> 
> 
> > On Zynq we use the cadece_ttc timer as clocksource. Its input clock is
> > tightly coupled to the CPU clock. I.e. it changes when cpufreq scales
> > the CPU clocks.
> > To compensate this, I added a clock notifier doing this on a frequency
> > change:
> > 	clocksource_unregister(&ttccs->cs);
> > 	clocksource_register_hz(&ttccs->cs, ndata->new_rate / PRESCALE);
> 
> This will definitely have problems if this is the only high-res capable
> clocksource.

And starting with 3.11 it will be not longer possible to unregister
the only high-res capable clocksource exactly to prevent the wreckage
you are talking about :)

Thanks,

	tglx
