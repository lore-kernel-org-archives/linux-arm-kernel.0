From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 18 Nov 2015 16:55:10 -0500 (EST)
Subject: [PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <20151118184736.GM1588@arm.com>
References: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
 <20151118184736.GM1588@arm.com>
Message-ID: <alpine.LFD.2.20.1511181646090.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2015, Will Deacon wrote:

> Hello,
> 
> On Wed, Nov 18, 2015 at 10:15:05AM -0800, Yang Shi wrote:
> > As what Pavel Machek reported [1], some userspace applications depend on
> > bogomips showed by /proc/cpuinfo.
> > 
> > Although there is much less legacy impact on aarch64 than arm, but it does
> > break libvirt.
> > 
> > Basically, this patch reverts commit 326b16db9f69fd0d279be873c6c00f88c0a4aad5
> > ("arm64: delay: don't bother reporting bogomips in /proc/cpuinfo"), but with
> > some tweak due to context change.
> > 
> > [1] https://lkml.org/lkml/2015/1/4/132
> 
> I lost this argument last time around, so I won't re-tread that path this
> time around.

No kidding.  ;-)

> I do, however, have some comments on the patch.
> 
> > 
> > Signed-off-by: Yang Shi <yang.shi@linaro.org>
> > ---
> >  arch/arm64/kernel/cpuinfo.c | 5 +++++
> >  arch/arm64/kernel/smp.c     | 7 ++++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> > index 706679d..8d4ba77 100644
> > --- a/arch/arm64/kernel/cpuinfo.c
> > +++ b/arch/arm64/kernel/cpuinfo.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/sched.h>
> >  #include <linux/smp.h>
> > +#include <linux/delay.h>
> >  
> >  /*
> >   * In case the boot CPU is hotpluggable, we record its initial state and
> > @@ -112,6 +113,10 @@ static int c_show(struct seq_file *m, void *v)
> >  		 */
> >  		seq_printf(m, "processor\t: %d\n", i);
> >  
> > +		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n\n",
> 
> This double newline makes /proc/cpuinfo looks really odd. Can we just
> have one, please?
> 
> > +			   loops_per_jiffy / (500000UL/HZ),
> > +			   loops_per_jiffy / (5000UL/HZ) % 100);

Also, given nobody ever relied on any prior value here, can we at least 
print something here with some semblance of a meaning i.e. something 
related to the actual CPU speed and not some separate useless constant 
timer clock please?


Nicolas
