From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Apr 2017 15:34:39 +0100
Subject: [PATCH] perf evsel: Fix to perf-stat malloc corruption on arm64
 platforms
In-Reply-To: <CAFpQJXX7HaKQ8t85mB2Fqn-6wHhb_GR+2sOi23HQZnRgUw-Y4g@mail.gmail.com>
References: <1493198780-25415-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170426145057.GK27156@leverpostej>
 <20170426171208.GC23669@leverpostej>
 <CAFpQJXX7HaKQ8t85mB2Fqn-6wHhb_GR+2sOi23HQZnRgUw-Y4g@mail.gmail.com>
Message-ID: <20170427143438.GE31337@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 11:49:46PM +0530, Ganapatrao Kulkarni wrote:
> On Wed, Apr 26, 2017 at 10:42 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 13b5499..638aefa 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -346,6 +346,28 @@ static void read_counters(void)
> >         }
> >  }
> >
> > +/*
> > + * Close all evnt FDs we open in __run_perf_stat() and
> > + * create_perf_stat_counter(), taking care to match the number of threads and CPUs.
> > + *
> > + * Note that perf_evlist__close(evsel_list) is not equivalent, as it doesn't
> > + * take the target into account.
> > + */
> > +static void close_counters(void)
> > +{
> > +       bool per_cpu = target__has_cpu(&target);
> > +       struct perf_evsel *evsel;
> > +
> > +       evlist__for_each_entry(evsel_list, evsel) {
> > +               if (per_cpu)
> > +                       perf_evsel__close_per_cpu(evsel,
> > +                                                 perf_evsel__cpus(evsel));
> > +               else
> > +                       perf_evsel__close_per_thread(evsel,
> > +                                                    evsel_list->threads);
> > +       }
> > +}
> > +
> >  static void process_interval(void)
> >  {
> >         struct timespec ts, rs;
> > @@ -686,7 +708,7 @@ static int __run_perf_stat(int argc, const char **argv)
> >          * group leaders.
> >          */
> >         read_counters();
> > -       perf_evlist__close(evsel_list);
> > +       close_counters();
> >
> >         return WEXITSTATUS(status);
> >  }
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index ac59710..726ceca 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1670,6 +1670,18 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
> >         return err;
> >  }
> >
> > +int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
> > +                            struct cpu_map *cpus)
> > +{
> > +       return perf_evsel__open(evsel, cpus, NULL);
> > +}
> > +
> > +int perf_evsel__open_per_thread(struct perf_evsel *evsel,
> > +                               struct thread_map *threads)
> > +{
> > +       return perf_evsel__open(evsel, NULL, threads);
> > +}
> > +
> >  void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads)
> >  {
> >         if (evsel->fd == NULL)
> > @@ -1679,16 +1691,18 @@ void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads)
> >         perf_evsel__free_fd(evsel);
> >  }
> >
> > -int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
> > -                            struct cpu_map *cpus)
> > +void perf_evsel__close_per_cpu(struct perf_evsel *evsel,
> > +                              struct cpu_map *cpus)
> >  {
> > -       return perf_evsel__open(evsel, cpus, NULL);
> > +       int ncpus = cpus ? cpus->nr : 1;
> > +       perf_evsel__close(evsel, ncpus, 1);
> >  }
> >
> > -int perf_evsel__open_per_thread(struct perf_evsel *evsel,
> > -                               struct thread_map *threads)
> > +void perf_evsel__close_per_thread(struct perf_evsel *evsel,
> > +                                 struct thread_map *threads)
> >  {
> > -       return perf_evsel__open(evsel, NULL, threads);
> > +       int nthreads = threads ? threads->nr : 1;
> > +       perf_evsel__close(evsel, 1, nthreads);
> >  }
> >
> >  static int perf_evsel__parse_id_sample(const struct perf_evsel *evsel,
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 06ef6f2..02bea43 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -252,6 +252,10 @@ int perf_evsel__open_per_thread(struct perf_evsel *evsel,
> >                                 struct thread_map *threads);
> >  int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
> >                      struct thread_map *threads);
> > +void perf_evsel__close_per_cpu(struct perf_evsel *evsel,
> > +                              struct cpu_map *cpus);
> > +void perf_evsel__close_per_thread(struct perf_evsel *evsel,
> > +                                 struct thread_map *threads);
> >  void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads);
> >
> >  struct perf_sample;
> 
> this diff looks to me doing same as mine.

Be careful when reading the diff above; the open functions have been
moved, but have not changed.

I've only changed the close path, whereas your proposal changed the open
path. Those are not equivalent changes.

> i think below diff should be more appropriate fix to this issue?
> 
> when open allocates and uses dummy cpus, there is no point in holding
> old unused one.  instead it should free and link to dummy cpus which
> is created with 1 CPU.  same will be used by close.
> 
> i did quick testing on both x86 and arm64.  testing looks ok, may need
> more testing!
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ac59710..b1aab0a 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1466,9 +1466,13 @@ int perf_evsel__open(struct perf_evsel *evsel,
> struct cpu_map *cpus,
>                         empty_cpu_map = cpu_map__dummy_new();
>                         if (empty_cpu_map == NULL)
>                                 return -ENOMEM;
> +               } else {
> +                       cpu_map__get(empty_cpu_map);
>                 }
> 
>                 cpus = empty_cpu_map;
> +               cpu_map__put(evsel->cpus);
> +               evsel->cpus = cpus;
>         }
> 
>         if (threads == NULL) {

Unfortunately, I believe that might break the logic added in commit:

  9f21b815be863218 ("perf evlist: Only open events on CPUs an evsel permits")

... since the evsel->cpus would now not represent the PMUs CPUs.

As I'd mentioned in my prior reply, I think in order to use the cpu_maps
consistently we need to do a bigger rework of the way cpu_maps are used,
in order to separate the PMU CPUs from the requested event CPUs, etc.
while taking all of these into account.

Could you please give my diff a go?

Thanks,
Mark.
