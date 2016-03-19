From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sat, 19 Mar 2016 18:10:05 +0530
Subject: [PATCH] clocksource/arm_global_timer.c: Reduce the rating from
 300 to 150
In-Reply-To: <56EBAA4B.2090104@topic.nl>
References: <1458198933-3397-1-git-send-email-mike.looijmans@topic.nl>
 <56EAE42C.3010001@ti.com> <56EBAA4B.2090104@topic.nl>
Message-ID: <20160319124005.GA2546@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 18, 2016 at 08:12:11AM +0100, Mike Looijmans wrote:
> ?On 17-03-16 18:06, Grygorii Strashko wrote:
> >On 03/17/2016 09:15 AM, Mike Looijmans wrote:

> >>The arm_global_timer clock runs on the CPU clock, and does not correct
> >>for cpufreq scaling. This makes the clock not very suitable as a
> >>clocksource, and basically any clock running on an independent
> >>oscilator is preferable. Few clocksources have a rating over 300,
> >>so this clock usually gets selected as clock source.
> >>
> >>On the Zynq-7000 for example, the TTC clock on the chip is preferred
> >>to the global timer, because the TTC can at least compensate for
> >>cpufreq scaling. That makes the TTC (which rates itself 200) a much
> >>better clock source than the ARM global timer.
> >>
> >>Reduce the rating to 150 to make systems select the ARM global timer
> >>as a last resort instead of a first choice.

> >Yeh. All this clocksource/clockevent/sched_clock selection process is not really clear and
> >not always works in case of muliplatform build :..(
> >
> >For example, I've had opposite case recently :( I have to reduce rating of OMAP gp_timer (300->290),
> >so it will be possible to use ARM GT as clocksource when no-CPUFrq and no-CPUIdle.
> >
> >When I've tried to deal with it, I've been thinking about smth. like this:
> >- explicitly define set and initialization sequence of devices
> >  chosen {
> >	linux,clocksource = <&clksrc1>, <&clksrc2>..
> >	linux,clockevent = <&clkevt1>, <&clkevt2>..
> >
> >- or mark devices's nodes
> >   timer1: timer at 4ae18000 {
> >		compatible = "ti,omap5430-timer";
> >		linux,clocksource;
> >		linux,clockevent;
> >
> >but I were not able to proceed further due lack of time (^ might cause difficult DT discussion).

> Devicetree would be a proper place for this. A simple implementation
> would be to just move the "rating" to the DT, but that would be
> silly, since the "winner" is already known to the author of th DT so
> he might as well just say "use this one".
> 
> Personally, I like the "chosen" method best in your proposal, just a
> list of clocks in order of selection. The DT author knows best.
> 
> The "rating" system will never actually work, since what's best on
> one board is almost broken on another.

Instead of putting Linux-ism in DT, a suggestion - exploit
"clocksource=" command line argument (which is already documented) in
the relevant clocksource driver by intercepting it & doing,

        clksrc.rating = 499;/* or whatever reqd. to override the best */

iirc, bootloader (read mostly uboot in present scenario) can append
"chosen bootargs" in DT with cmdline that it will present to Linux, so
if passing cmdline arg is not preferred it can be put there.

The above solution is a kind of hack, but when the existing rating's
are not true to it's name, this might be a least intrusive solution.

Regards
afzal
