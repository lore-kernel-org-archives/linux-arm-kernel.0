From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Jan 2013 01:18:08 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <CAKGA1bkXx2qn+c6sKqXsty-aFe1r-W79uyem0O8p6JNeeq6zxQ@mail.gmail.com>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de> <50FDAC5F.4040605@linaro.org>
 <CAKGA1b=D5CNikijoOAk5xP6TC-nB_gEGtS05ncrPR68sQTMrxw@mail.gmail.com>
 <50FDC2DD.7090406@linaro.org>
 <CAKGA1bmtTH1N8nx79MGiMighdQROpNtpvAZXhHKT+mT3kcazBQ@mail.gmail.com>
 <50FDE2AE.8030608@linaro.org>
 <CAKGA1bkXx2qn+c6sKqXsty-aFe1r-W79uyem0O8p6JNeeq6zxQ@mail.gmail.com>
Message-ID: <20130122011808.GF23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 07:06:59PM -0600, Matt Sealey wrote:
> On Mon, Jan 21, 2013 at 6:51 PM, John Stultz <john.stultz@linaro.org> wrote:
> > On 01/21/2013 02:54 PM, Matt Sealey wrote:
> >>
> >> On Mon, Jan 21, 2013 at 4:36 PM, John Stultz <john.stultz@linaro.org>
> >> wrote:
> >>>
> >>> On 01/21/2013 01:14 PM, Matt Sealey wrote:
> >
> > As far as jiffies rating, from jiffies.c:
> >     .rating        = 1, /* lowest valid rating*/
> >
> > So I'm not sure what you mean by "the debug on the kernel log is telling me
> > it has a higher resolution".
> 
> Oh, it is just if I actually don't run setup_sched_clock on my
> platform, it gives a little message (with #define DEBUG 1 in
> sched_clock.c)

sched_clock() has nothing to do with time keeping, and that
HZ/NO_HZ/HRTIMERS don't affect it (when it isn't being derived from
jiffies).

Now, sched_clock() is there to give the scheduler a _fast_ to access,
higher resolution clock than is available from other sources, so that
there's ways of accurately measuring the amount of time processes run
for, and other such measurements - and it uses that to determine how
to schedule a particular task and when to preempt it.

Not providing it means you get those measurements at HZ-based resolution,
which is suboptimal for tasks which run often for sub-HZ periods (which
can end up accumulating zero run time.)
