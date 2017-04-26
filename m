From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 26 Apr 2017 23:49:46 +0530
Subject: [PATCH] perf evsel: Fix to perf-stat malloc corruption on arm64
 platforms
In-Reply-To: <20170426171208.GC23669@leverpostej>
References: <1493198780-25415-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170426145057.GK27156@leverpostej> <20170426171208.GC23669@leverpostej>
Message-ID: <CAFpQJXX7HaKQ8t85mB2Fqn-6wHhb_GR+2sOi23HQZnRgUw-Y4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Apr 26, 2017 at 10:42 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Apr 26, 2017 at 03:50:57PM +0100, Mark Rutland wrote:
>> Hi Ganapatrao,
>>
>> Thanks for tracking this down.
>>
>> On Wed, Apr 26, 2017 at 02:56:20PM +0530, Ganapatrao Kulkarni wrote:
>> > In some cases, ncpus used for perf_evsel__alloc_fd and for
>> > perf_evsel__close are not the same, this is causing memory
>> > overwrite/corruption.
>>
>> It would be good if we could enumerate when this occurs.
>>
>> From what I can tell, the problem occurs when opening a thread-bound
>> event on PMU with a cpus/cpumask in sysfs.
>>
>> For perf-stat we create events using create_perf_stat_counter(). There
>> we see !target_has_cpu(), so we call perf_evsel__open_per_thread(). Thus
>> perf_evsel__open() is passed NULL cpus, and creates an empty cpu_map. As
>> cpus->nr = 1, we get 1 * nthreads fds allocated, and open events for
>> each of these.
>>
>> Later, we try to close events using perf_evlist__close(). This doesn't
>> take target_has_cpu() into account, but sees evsel->cpus is non-NULL
>> (since the PMU had a cpus/cpumask file), and tries to close events for
>> cpus->nr * nthreads, and goes out-of-bounds of the fd array.
>
> Looking further, I introduced this inconsistency in commit:
>
>   3df33eff2ba96be4 ("perf stat: Avoid skew when reading events ")
>
> To fix that, perf-stat needs to control the closing of its events, to
> match what it does when opening them. I've spun the below to do that,
> introducing new helpers to make it clear.
>
> Does that work for you?
>
> Thanks,
> Mark.
>
> ---->8----
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 13b5499..638aefa 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -346,6 +346,28 @@ static void read_counters(void)
>         }
>  }
>
> +/*
> + * Close all evnt FDs we open in __run_perf_stat() and
> + * create_perf_stat_counter(), taking care to match the number of threads and CPUs.
> + *
> + * Note that perf_evlist__close(evsel_list) is not equivalent, as it doesn't
> + * take the target into account.
> + */
> +static void close_counters(void)
> +{
> +       bool per_cpu = target__has_cpu(&target);
> +       struct perf_evsel *evsel;
> +
> +       evlist__for_each_entry(evsel_list, evsel) {
> +               if (per_cpu)
> +                       perf_evsel__close_per_cpu(evsel,
> +                                                 perf_evsel__cpus(evsel));
> +               else
> +                       perf_evsel__close_per_thread(evsel,
> +                                                    evsel_list->threads);
> +       }
> +}
> +
>  static void process_interval(void)
>  {
>         struct timespec ts, rs;
> @@ -686,7 +708,7 @@ static int __run_perf_stat(int argc, const char **argv)
>          * group leaders.
>          */
>         read_counters();
> -       perf_evlist__close(evsel_list);
> +       close_counters();
>
>         return WEXITSTATUS(status);
>  }
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ac59710..726ceca 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1670,6 +1670,18 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>         return err;
>  }
>
> +int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
> +                            struct cpu_map *cpus)
> +{
> +       return perf_evsel__open(evsel, cpus, NULL);
> +}
> +
> +int perf_evsel__open_per_thread(struct perf_evsel *evsel,
> +                               struct thread_map *threads)
> +{
> +       return perf_evsel__open(evsel, NULL, threads);
> +}
> +
>  void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads)
>  {
>         if (evsel->fd == NULL)
> @@ -1679,16 +1691,18 @@ void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads)
>         perf_evsel__free_fd(evsel);
>  }
>
> -int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
> -                            struct cpu_map *cpus)
> +void perf_evsel__close_per_cpu(struct perf_evsel *evsel,
> +                              struct cpu_map *cpus)
>  {
> -       return perf_evsel__open(evsel, cpus, NULL);
> +       int ncpus = cpus ? cpus->nr : 1;
> +       perf_evsel__close(evsel, ncpus, 1);
>  }
>
> -int perf_evsel__open_per_thread(struct perf_evsel *evsel,
> -                               struct thread_map *threads)
> +void perf_evsel__close_per_thread(struct perf_evsel *evsel,
> +                                 struct thread_map *threads)
>  {
> -       return perf_evsel__open(evsel, NULL, threads);
> +       int nthreads = threads ? threads->nr : 1;
> +       perf_evsel__close(evsel, 1, nthreads);
>  }
>
>  static int perf_evsel__parse_id_sample(const struct perf_evsel *evsel,
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 06ef6f2..02bea43 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -252,6 +252,10 @@ int perf_evsel__open_per_thread(struct perf_evsel *evsel,
>                                 struct thread_map *threads);
>  int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>                      struct thread_map *threads);
> +void perf_evsel__close_per_cpu(struct perf_evsel *evsel,
> +                              struct cpu_map *cpus);
> +void perf_evsel__close_per_thread(struct perf_evsel *evsel,
> +                                 struct thread_map *threads);
>  void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads);
>
>  struct perf_sample;

this diff looks to me doing same as mine.
i think below diff should be more appropriate fix to this issue?

when open allocates and uses dummy cpus, there is no point in holding
old unused one.
instead it should free and link to dummy cpus which is created with 1 CPU.
same will be used by close.

i did quick testing on both x86 and arm64.
testing looks ok, may need more testing!

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac59710..b1aab0a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1466,9 +1466,13 @@ int perf_evsel__open(struct perf_evsel *evsel,
struct cpu_map *cpus,
                        empty_cpu_map = cpu_map__dummy_new();
                        if (empty_cpu_map == NULL)
                                return -ENOMEM;
+               } else {
+                       cpu_map__get(empty_cpu_map);
                }

                cpus = empty_cpu_map;
+               cpu_map__put(evsel->cpus);
+               evsel->cpus = cpus;
        }

        if (threads == NULL) {
gkulkarni at localhost>perf>>

thanks
Ganapat
