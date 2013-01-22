From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 21 Jan 2013 19:06:59 -0600
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <50FDE2AE.8030608@linaro.org>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de> <50FDAC5F.4040605@linaro.org>
 <CAKGA1b=D5CNikijoOAk5xP6TC-nB_gEGtS05ncrPR68sQTMrxw@mail.gmail.com>
 <50FDC2DD.7090406@linaro.org>
 <CAKGA1bmtTH1N8nx79MGiMighdQROpNtpvAZXhHKT+mT3kcazBQ@mail.gmail.com>
 <50FDE2AE.8030608@linaro.org>
Message-ID: <CAKGA1bkXx2qn+c6sKqXsty-aFe1r-W79uyem0O8p6JNeeq6zxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 6:51 PM, John Stultz <john.stultz@linaro.org> wrote:
> On 01/21/2013 02:54 PM, Matt Sealey wrote:
>>
>> On Mon, Jan 21, 2013 at 4:36 PM, John Stultz <john.stultz@linaro.org>
>> wrote:
>>>
>>> On 01/21/2013 01:14 PM, Matt Sealey wrote:
>
> As far as jiffies rating, from jiffies.c:
>     .rating        = 1, /* lowest valid rating*/
>
> So I'm not sure what you mean by "the debug on the kernel log is telling me
> it has a higher resolution".

Oh, it is just if I actually don't run setup_sched_clock on my
platform, it gives a little message (with #define DEBUG 1 in
sched_clock.c) about who setup the last sched_clock. Since you only
get one chance, and I was fiddling with setup_sched_clock being probed
from multiple possible timers from device tree (i.MX3 has a crapload
of valid timers, which one you use right now is basically forced by
the not-quite-fully-DT-only code and some funky iomap tricks).

And what I got was, if I use the real hardware timer, it runs at 66MHz
and says it has 15ns resolution and wraps every 500 seconds or so. The
jiffies timer says it's 750MHz, with a 2ns resoluton.. you get the
drift. The generic reporting of how "good" the sched_clock source is
kind of glosses over the quality rating of the clock source and at
first glance (if you're not paying that much attention), it is a
little bit misleading..

> Yes, in the case I was remembering, the 60HZ was driven by the electrical
> line.

While I have your attention, what would be the minimum "good" speed to
run the sched_clock or delay timer implementation from? My rudimentary
scribblings in my notebook give me a value of "don't bother" with less
than 10KHz based on HZ=100, so I'm wondering if a direct 32.768KHz
clock would do (i.MX osc clock input if I can supply it to one of the
above myriad timers) since this would be low-power compared to a 66MHz
one (by a couple mA anyway). I also have a bunch of questions about
the delay timer requirements.. I might mail you personally.. or would
you prefer on-list?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
