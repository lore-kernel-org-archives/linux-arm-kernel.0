From: john.stultz@linaro.org (John Stultz)
Date: Mon, 21 Jan 2013 16:51:58 -0800
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <CAKGA1bmtTH1N8nx79MGiMighdQROpNtpvAZXhHKT+mT3kcazBQ@mail.gmail.com>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de> <50FDAC5F.4040605@linaro.org>
 <CAKGA1b=D5CNikijoOAk5xP6TC-nB_gEGtS05ncrPR68sQTMrxw@mail.gmail.com>
 <50FDC2DD.7090406@linaro.org>
 <CAKGA1bmtTH1N8nx79MGiMighdQROpNtpvAZXhHKT+mT3kcazBQ@mail.gmail.com>
Message-ID: <50FDE2AE.8030608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 02:54 PM, Matt Sealey wrote:
> On Mon, Jan 21, 2013 at 4:36 PM, John Stultz <john.stultz@linaro.org> wrote:
>> On 01/21/2013 01:14 PM, Matt Sealey wrote:
>>> My question really has to be is CONFIG_SCHED_HRTICK useful, what
>>> exactly is it going to do on ARM here since nobody can ever have
>>> enabled it? Is it going to keel over and explode if nobody registers a
>>> non-jiffies sched_clock (since the jiffies clock is technically
>>> reporting itself as a ridiculously high resolution clocksource..)?
>> ??? Not following this at all.  jiffies is the *MOST* coarse resolution
>> clocksource there is (at least that I'm aware of.. I recall someone wanting
>> to do a 60Hz clocksource, but I don't think that ever happened).
> Is that based on it's clocksource rating (probably worse than a real
> hrtimer) or it's reported resolution? Because on i.MX51 if I force it
> to use the jiffies clock the debug on the kernel log is telling me it
> has a higher resolution (it TELLS me that it ticks "as fast" as the
> CPU frequency and wraps less than my real timer).
So the clocksource rating is supposed to be defined by the clocksource 
driver writer, and just provides a way for the clocksource core to 
select the best clocksource given a set of clocksources. It is not 
defined as any sort of calculated mapping to any property of the 
clocksource itself (although some driver writers might compute a ratings 
value in that way, but I feel the static ranking is much simpler). The 
comment above struct clocksource in clocksource.h tries to explain this.

As far as jiffies rating, from jiffies.c:
     .rating        = 1, /* lowest valid rating*/

So I'm not sure what you mean by "the debug on the kernel log is telling 
me it has a higher resolution".



> I know where the 60Hz clocksource might come from, the old Amiga
> platforms have one based on the PSU frequency (50Hz in Europe, 60Hz
> US/Japan). Even a 60Hz clocksource is useful though (on the Amiga, at
> least, it is precisely the vsync clock for synchronizing your display
> output on TV-out, which makes it completely useful for the framebuffer
> driver), but.. you just won't expect to assign it as sched_clock or
> your delay timer. And if anyone does I'd expect they'd know full well
> it'd not run so well.

Yes, in the case I was remembering, the 60HZ was driven by the 
electrical line.

thanks
-john
