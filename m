From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 25 Jan 2016 13:46:22 -0700
Subject: [PATCH V8 20/23] perf tools: making function set_max_cpu_num()
 non static
In-Reply-To: <1452807977-8069-21-git-send-email-mathieu.poirier@linaro.org>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-21-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CANLsYkzmTMi3jmVjwNiNsw6P5pPkZEz6zYWFsVzayy+r2ojTTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2016 at 14:46, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> For memory allocation purposes, code located in other places
> then util/cpumap.c may want to know how many CPUs the system has.
>
> This patch is making function set_max_cpu_num() available to
> other parts of the perf tool so that global variable
> 'max_cpu_num' gets the right value when referenced by cpu__max_cpu().
>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/perf/util/cpumap.c | 2 +-
>  tools/perf/util/cpumap.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 10af1e7524fb..ae179320c0c0 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -380,7 +380,7 @@ out:
>  }
>
>  /* Determine highest possible cpu in the system for sparse allocation */
> -static void set_max_cpu_num(void)
> +void set_max_cpu_num(void)
>  {
>         const char *mnt;
>         char path[PATH_MAX];
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 85f7772457fa..45fa963345eb 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -14,6 +14,7 @@ struct cpu_map {
>         int map[];
>  };
>
> +void set_max_cpu_num(void);
>  struct cpu_map *cpu_map__new(const char *cpu_list);
>  struct cpu_map *cpu_map__empty_new(int nr);
>  struct cpu_map *cpu_map__dummy_new(void);
> --
> 2.1.4
>

Arnaldo,

I can't queue this patch for 4.6 without at least a reviewed by from you.

It has been rebased to 4.5-rc1 here [1] for your convenience.  I will
be happy to use another baseline should that be more adequate for you.
The same goes for [2]

Thanks,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/shortlog/refs/heads/perf-v4.5-rc1-V8
