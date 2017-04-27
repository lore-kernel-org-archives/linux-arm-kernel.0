From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 27 Apr 2017 22:54:42 +0530
Subject: [PATCH] perf evsel: Fix to perf-stat malloc corruption on arm64
 platforms
In-Reply-To: <20170427155221.GB6646@leverpostej>
References: <1493198780-25415-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170426145057.GK27156@leverpostej> <20170426171208.GC23669@leverpostej>
 <CAFpQJXX7HaKQ8t85mB2Fqn-6wHhb_GR+2sOi23HQZnRgUw-Y4g@mail.gmail.com>
 <20170427143438.GE31337@leverpostej>
 <CAFpQJXWjx3uVG-6UNiJzmdc4FFw8kea2A5aJZquxVRXq8BR1VQ@mail.gmail.com>
 <20170427155221.GB6646@leverpostej>
Message-ID: <CAFpQJXXqbeJ8+g-HcKPMUJroosb7NS79zd2zr6O0GJozbVZY_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 9:22 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Apr 27, 2017 at 09:16:41PM +0530, Ganapatrao Kulkarni wrote:
>> > Could you please give my diff a go?
>>
>> i tried your diff, and testing looks ok.
>
> Can I take that as a Tested-by when I post this as a proper patch?

sure.

>
>> below is the cleanly merged diff on top of latest commit
>> f832460 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc
>
> Thanks for the rebase.
>
> Mark.
>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 13b5499..4be2980 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -346,6 +346,28 @@ static void read_counters(void)
>>   }
>>  }
>>
>> +/*
>> + * Close all evnt FDs we open in __run_perf_stat() and
>> + * create_perf_stat_counter(), taking care to match the number of
>> threads and CPUs.
>> + *
>> + * Note that perf_evlist__close(evsel_list) is not equivalent, as it doesn't
>> + * take the target into account.
>> + */
>> +static void close_counters(void)
>> +{
>> +       bool per_cpu = target__has_cpu(&target);
>> +       struct perf_evsel *evsel;
>> +
>> +       evlist__for_each_entry(evsel_list, evsel) {
>> +               if (per_cpu)
>> +                       perf_evsel__close_per_cpu(evsel,
>> +                                                 perf_evsel__cpus(evsel));
>> +               else
>> +                       perf_evsel__close_per_thread(evsel,
>> +                                                    evsel_list->threads);
>> +       }
>> +}
>> +
>>  static void process_interval(void)
>>  {
>>   struct timespec ts, rs;
>> @@ -686,7 +708,7 @@ static int __run_perf_stat(int argc, const char **argv)
>>   * group leaders.
>>   */
>>   read_counters();
>> - perf_evlist__close(evsel_list);
>> + close_counters();
>>
>>   return WEXITSTATUS(status);
>>  }
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index ac59710..ecd9778 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1691,6 +1691,20 @@ int perf_evsel__open_per_thread(struct perf_evsel *evsel,
>>   return perf_evsel__open(evsel, NULL, threads);
>>  }
>>
>> +void perf_evsel__close_per_cpu(struct perf_evsel *evsel,
>> +                              struct cpu_map *cpus)
>> + {
>> +       int ncpus = cpus ? cpus->nr : 1;
>> +       perf_evsel__close(evsel, ncpus, 1);
>> + }
>> +
>> +void perf_evsel__close_per_thread(struct perf_evsel *evsel,
>> +                                 struct thread_map *threads)
>> + {
>> +       int nthreads = threads ? threads->nr : 1;
>> +       perf_evsel__close(evsel, 1, nthreads);
>> + }
>> +
>>  static int perf_evsel__parse_id_sample(const struct perf_evsel *evsel,
>>         const union perf_event *event,
>>         struct perf_sample *sample)
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 06ef6f2..6779bd2 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -250,6 +250,10 @@ int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
>>       struct cpu_map *cpus);
>>  int perf_evsel__open_per_thread(struct perf_evsel *evsel,
>>   struct thread_map *threads);
>> +void perf_evsel__close_per_cpu(struct perf_evsel *evsel,
>> +                              struct cpu_map *cpus);
>> +void perf_evsel__close_per_thread(struct perf_evsel *evsel,
>> +                                 struct thread_map *threads);
>>  int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>>       struct thread_map *threads);
>>  void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads);
