From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 3 Jul 2018 11:37:17 -0600
Subject: [PATCH 4/6] perf/aux: Make perf_event accessible to setup_aux()
In-Reply-To: <20180703073142.GA4581@linux.ibm.com>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
 <20180703073142.GA4581@linux.ibm.com>
Message-ID: <CANLsYkxHws7JRCU9EfGsK3wQxugP5w8aVTTja=fBRn1=TqETMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jul 2018 at 01:31, Hendrik Brueckner <brueckner@linux.ibm.com> wrote:
>
> On Mon, Jul 02, 2018 at 04:33:28PM -0600, Mathieu Poirier wrote:
> > It can be advantagous to have access to all the information conveyed by
> > a perf_event when setting up the AUX buffer, as it is the case when
> > dealing with PMU specific driver configuration communicated to the kernel
> > using an ioctl() call.
> >
> > As such simply replace the cpu information by the complete perf_event
> > structure and change all affected customers.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  arch/s390/kernel/perf_cpum_sf.c                  | 4 ++--
> >  arch/x86/events/intel/bts.c                      | 4 +++-
> >  arch/x86/events/intel/pt.c                       | 5 +++--
> >  drivers/hwtracing/coresight/coresight-etm-perf.c | 6 +++---
> >  drivers/perf/arm_spe_pmu.c                       | 6 +++---
> >  include/linux/perf_event.h                       | 2 +-
> >  kernel/events/ring_buffer.c                      | 2 +-
> >  7 files changed, 16 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> > index 0292d68e7dde..e06daaa08894 100644
> > --- a/arch/s390/kernel/perf_cpum_sf.c
> > +++ b/arch/s390/kernel/perf_cpum_sf.c
> > @@ -1601,8 +1601,8 @@ static void aux_buffer_free(void *data)
> >   *
> >   * Return the private AUX buffer structure if success or NULL if fails.
> >   */
> > -static void *aux_buffer_setup(int cpu, void **pages, int nr_pages,
> > -                           bool snapshot)
> > +static void *aux_buffer_setup(struct perf_event *event, void **pages,
> > +                           int nr_pages, bool snapshot);
>
> Please remove the trailing semi-colon (;) in the function definition causing
> the kbuild error.  Also, it would be great if you also could update the
> function comment and replace the @cpu by the @event.

Had I realised it was just as easy to compile for s390 as it is for
ARM64, I would have done so ahead of time.  Well done on that front.
All fixed now.

Thanks,
Mathieu

>
> Many thanks.
>
