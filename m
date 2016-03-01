From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 01 Mar 2016 02:56:21 +0000
Subject: [PATCH] drivers/hwtracing: make coresight-etm-perf.c explicitly
 non-modular
In-Reply-To: <CANLsYkw7jVkE3KcuOz0w4ETGhRpGs_wzu6c+_MY+i0uzaXFhag@mail.gmail.com>
References: <1456604507-4728-1-git-send-email-paul.gortmaker@windriver.com>
 <CANLsYkw7jVkE3KcuOz0w4ETGhRpGs_wzu6c+_MY+i0uzaXFhag@mail.gmail.com>
Message-ID: <20160301025620.GA17542@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 09:10:06AM -0700, Mathieu Poirier wrote:
> On 27 February 2016 at 13:21, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > In commit 941943cf519f7cacbbcecee5c4ef4b77b466bd5c ("drivers/hwtracing:
> > make coresight-* explicitly non-modular") we removed all uses of
> > modular functions/macros in favour of their built-in equivlents in
> > this subsystem.
> >
> > However that commit and commit 0bcbf2e30ff2271b54f54c8697a185f7d86ec6e4
> > ("coresight: etm-perf: new PMU driver for ETM tracers") were in flight
> > at the same time, and hence one new non-modular user of module_init
> > crept back in.  Fix it up like we did all the others.
> >
> > Since module_init translates to device_initcall in the non-modular
> > case, the init ordering remains unchanged with this commit.
> >
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index 36153a77e982..755125f7917f 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -21,7 +21,7 @@
> >  #include <linux/device.h>
> >  #include <linux/list.h>
> >  #include <linux/mm.h>
> > -#include <linux/module.h>
> > +#include <linux/init.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> > @@ -390,4 +390,4 @@ static int __init etm_perf_init(void)
> >
> >         return ret;
> >  }
> > -module_init(etm_perf_init);
> > +device_initcall(etm_perf_init);
> 
> Yes of course - Applied.
> 
> Greg, given the triviality of the changes, can you still pick this up
> for the next merge window?

Yes, want me to take it directly, or do you have more patches to send
me?

thanks,

greg k-h
