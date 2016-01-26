From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 26 Jan 2016 10:08:21 -0700
Subject: [PATCH V8 20/23] perf tools: making function set_max_cpu_num()
 non static
In-Reply-To: <20160125212955.GG22501@kernel.org>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-21-git-send-email-mathieu.poirier@linaro.org>
 <CANLsYkzmTMi3jmVjwNiNsw6P5pPkZEz6zYWFsVzayy+r2ojTTA@mail.gmail.com>
 <20160125211242.GF22501@kernel.org>
 <20160125212955.GG22501@kernel.org>
Message-ID: <CANLsYkwbBCwT0B4NV0pGo+avyyX9kiPzYZK5WtmfHaqnW8Q6uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 January 2016 at 14:29, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Em Mon, Jan 25, 2016 at 06:12:42PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jan 25, 2016 at 01:46:22PM -0700, Mathieu Poirier escreveu:
>> > On 14 January 2016 at 14:46, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>> > > For memory allocation purposes, code located in other places
>> > > then util/cpumap.c may want to know how many CPUs the system has.
>> > >
>> > > This patch is making function set_max_cpu_num() available to
>> > > other parts of the perf tool so that global variable
>> > > 'max_cpu_num' gets the right value when referenced by cpu__max_cpu().
>> > >
>> > > Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
>> > > Cc: Ingo Molnar <mingo@redhat.com>
>> > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> > > ---
>> > >  tools/perf/util/cpumap.c | 2 +-
>> > >  tools/perf/util/cpumap.h | 1 +
>> > >  2 files changed, 2 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
>> > > index 10af1e7524fb..ae179320c0c0 100644
>> > > --- a/tools/perf/util/cpumap.c
>> > > +++ b/tools/perf/util/cpumap.c
>> > > @@ -380,7 +380,7 @@ out:
>> > >  }
>> > >
>> > >  /* Determine highest possible cpu in the system for sparse allocation */
>> > > -static void set_max_cpu_num(void)
>> > > +void set_max_cpu_num(void)
>> > >  {
>> > >         const char *mnt;
>> > >         char path[PATH_MAX];
>> > > diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
>> > > index 85f7772457fa..45fa963345eb 100644
>> > > --- a/tools/perf/util/cpumap.h
>> > > +++ b/tools/perf/util/cpumap.h
>> > > @@ -14,6 +14,7 @@ struct cpu_map {
>> > >         int map[];
>> > >  };
>> > >
>> > > +void set_max_cpu_num(void);
>> > >  struct cpu_map *cpu_map__new(const char *cpu_list);
>> > >  struct cpu_map *cpu_map__empty_new(int nr);
>> > >  struct cpu_map *cpu_map__dummy_new(void);
>> > > --
>> > > 2.1.4
>> > >
>> >
>> > Arnaldo,
>> >
>> > I can't queue this patch for 4.6 without at least a reviewed by from you.
>>
>> This one I remember, looks ugly, the name set_max_cpu_num() looks
>> strange, when that was restricted (static) to that cpumap.c file, it
>> wasn't a problem, exporting it for wider usage looks bad.
>>
>> You've been waiting for this for quite a while, it seems, lemme stop
>> what I am doing to check this...
>
> So, please check the patch below, what you need then is just to use
> cpu__max_cpu().

I like your approach - thanks for the review.  I will spin V9 when I
have received Adrian's comments.

Mathieu

>
> - Arnaldo
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index fa935093a599..9bcf2bed3a6d 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -8,6 +8,10 @@
>  #include <linux/bitmap.h>
>  #include "asm/bug.h"
>
> +static int max_cpu_num;
> +static int max_node_num;
> +static int *cpunode_map;
> +
>  static struct cpu_map *cpu_map__default_new(void)
>  {
>         struct cpu_map *cpus;
> @@ -486,6 +490,32 @@ out:
>                 pr_err("Failed to read max nodes, using default of %d\n", max_node_num);
>  }
>
> +int cpu__max_node(void)
> +{
> +       if (unlikely(!max_node_num))
> +               set_max_node_num();
> +
> +       return max_node_num;
> +}
> +
> +int cpu__max_cpu(void)
> +{
> +       if (unlikely(!max_cpu_num))
> +               set_max_cpu_num();
> +
> +       return max_cpu_num;
> +}
> +
> +int cpu__get_node(int cpu)
> +{
> +       if (unlikely(cpunode_map == NULL)) {
> +               pr_debug("cpu_map not initialized\n");
> +               return -1;
> +       }
> +
> +       return cpunode_map[cpu];
> +}
> +
>  static int init_cpunode_map(void)
>  {
>         int i;
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 71c41b9efabb..81a2562aaa2b 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -57,37 +57,11 @@ static inline bool cpu_map__empty(const struct cpu_map *map)
>         return map ? map->map[0] == -1 : true;
>  }
>
> -int max_cpu_num;
> -int max_node_num;
> -int *cpunode_map;
> -
>  int cpu__setup_cpunode_map(void);
>
> -static inline int cpu__max_node(void)
> -{
> -       if (unlikely(!max_node_num))
> -               pr_debug("cpu_map not initialized\n");
> -
> -       return max_node_num;
> -}
> -
> -static inline int cpu__max_cpu(void)
> -{
> -       if (unlikely(!max_cpu_num))
> -               pr_debug("cpu_map not initialized\n");
> -
> -       return max_cpu_num;
> -}
> -
> -static inline int cpu__get_node(int cpu)
> -{
> -       if (unlikely(cpunode_map == NULL)) {
> -               pr_debug("cpu_map not initialized\n");
> -               return -1;
> -       }
> -
> -       return cpunode_map[cpu];
> -}
> +int cpu__max_node(void);
> +int cpu__max_cpu(void);
> +int cpu__get_node(int cpu);
>
>  int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
>                        int (*f)(struct cpu_map *map, int cpu, void *data),
