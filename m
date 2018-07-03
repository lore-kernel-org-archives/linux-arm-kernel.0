From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 3 Jul 2018 11:47:00 -0600
Subject: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
In-Reply-To: <20180703134026.GA3728@krava>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
 <20180703134026.GA3728@krava>
Message-ID: <CANLsYkyAcJ3yPmdtRWnktOTLcirzxz0G2kwRjwtfhYvorXOs0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jul 2018 at 07:40, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
>
> SNIP
>
> > +static int
> > +perf_event_process_drv_config(struct perf_event *event, char *config_str)
> > +{
> > +     int ret = -EINVAL;
> > +     void *drv_data;
> > +
> > +     /* Make sure ctx.mutex it held */
> > +     lockdep_assert_held(&event->ctx->mutex);
> > +
> > +     /* Children take their configuration from their parent */
> > +     if (WARN_ON_ONCE(event->parent))
> > +             goto out;
> > +
> > +     drv_data = event->pmu->drv_config_validate(event, config_str);
> > +     if (!drv_data)
> > +             goto out;
>
> what's this check for? doc does not mention that,
> also the coresight callback does not return NULL
>

Very true - thanks for pointing this out.

Mathieu

> jirka
