From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 29 Jan 2016 12:14:19 +0200
Subject: [PATCH V8 21/23] perf tools: adding perf_evlist to
 *info_priv_size()
In-Reply-To: <56A78268.7020102@intel.com>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-22-git-send-email-mathieu.poirier@linaro.org>
 <CANLsYkyc85famRPpfZk+O3iHXdbULV8-a=izUq=GbgMeiGw=Og@mail.gmail.com>
 <20160125210858.GC22501@kernel.org> <56A78268.7020102@intel.com>
Message-ID: <56AB3B7B.7050906@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/16 16:27, Adrian Hunter wrote:
> On 25/01/16 23:08, Arnaldo Carvalho de Melo wrote:
>> Em Mon, Jan 25, 2016 at 01:48:28PM -0700, Mathieu Poirier escreveu:
>>> On 14 January 2016 at 14:46, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>>>> On some architecture the size of the private header may
>>>> be dependent on the number of tracers used in the session.  As
>>>> such adding a "struct perf_evlist *" parameter, which should
>>>> contain all the required information.
>>>>
>>>> Also adjusting the existing client of the interface to take
>>>> the new parameter into account.
>>>>
>>>> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> ---
>>>>  tools/perf/arch/x86/util/intel-bts.c | 4 +++-
>>>>  tools/perf/arch/x86/util/intel-pt.c  | 4 +++-
>>>>  tools/perf/util/auxtrace.c           | 7 ++++---
>>>>  tools/perf/util/auxtrace.h           | 6 ++++--
>>>>  4 files changed, 14 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
>>>> index 9b94ce520917..4685a40777cc 100644
>>>> --- a/tools/perf/arch/x86/util/intel-bts.c
>>>> +++ b/tools/perf/arch/x86/util/intel-bts.c
>>>> @@ -60,7 +60,9 @@ struct branch {
>>>>         u64 misc;
>>>>  };
>>>>
>>>> -static size_t intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused)
>>>> +static size_t
>>>> +intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>>>> +                        struct perf_evlist *evlist __maybe_unused)
>>>>  {
>>>>         return INTEL_BTS_AUXTRACE_PRIV_SIZE;
>>>>  }
>>>> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
>>>> index b02af064f0f9..e5c1f2e21f87 100644
>>>> --- a/tools/perf/arch/x86/util/intel-pt.c
>>>> +++ b/tools/perf/arch/x86/util/intel-pt.c
>>>> @@ -273,7 +273,9 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
>>>>         return attr;
>>>>  }
>>>>
>>>> -static size_t intel_pt_info_priv_size(struct auxtrace_record *itr __maybe_unused)
>>>> +static size_t
>>>> +intel_pt_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>>>> +                       struct perf_evlist *evlist __maybe_unused)
>>>>  {
>>>>         return INTEL_PT_AUXTRACE_PRIV_SIZE;
>>>>  }
>>>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>>>> index 7f10430af39c..cc1c9ce5cc56 100644
>>>> --- a/tools/perf/util/auxtrace.c
>>>> +++ b/tools/perf/util/auxtrace.c
>>>> @@ -478,10 +478,11 @@ void auxtrace_heap__pop(struct auxtrace_heap *heap)
>>>>                          heap_array[last].ordinal);
>>>>  }
>>>>
>>>> -size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr)
>>>> +size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
>>>> +                                      struct perf_evlist *evlist)
>>>>  {
>>>>         if (itr)
>>>> -               return itr->info_priv_size(itr);
>>>> +               return itr->info_priv_size(itr, evlist);
>>>>         return 0;
>>>>  }
>>>>
>>>> @@ -852,7 +853,7 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
>>>>         int err;
>>>>
>>>>         pr_debug2("Synthesizing auxtrace information\n");
>>>> -       priv_size = auxtrace_record__info_priv_size(itr);
>>>> +       priv_size = auxtrace_record__info_priv_size(itr, session->evlist);
>>>>         ev = zalloc(sizeof(struct auxtrace_info_event) + priv_size);
>>>>         if (!ev)
>>>>                 return -ENOMEM;
>>>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>>>> index b86f90db1352..e5a8e2d4f2af 100644
>>>> --- a/tools/perf/util/auxtrace.h
>>>> +++ b/tools/perf/util/auxtrace.h
>>>> @@ -293,7 +293,8 @@ struct auxtrace_record {
>>>>         int (*recording_options)(struct auxtrace_record *itr,
>>>>                                  struct perf_evlist *evlist,
>>>>                                  struct record_opts *opts);
>>>> -       size_t (*info_priv_size)(struct auxtrace_record *itr);
>>>> +       size_t (*info_priv_size)(struct auxtrace_record *itr,
>>>> +                                struct perf_evlist *evlist);
>>>>         int (*info_fill)(struct auxtrace_record *itr,
>>>>                          struct perf_session *session,
>>>>                          struct auxtrace_info_event *auxtrace_info,
>>>> @@ -429,7 +430,8 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>>>>  int auxtrace_record__options(struct auxtrace_record *itr,
>>>>                              struct perf_evlist *evlist,
>>>>                              struct record_opts *opts);
>>>> -size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr);
>>>> +size_t auxtrace_record__info_priv_size(struct auxtrace_record *itr,
>>>> +                                      struct perf_evlist *evlist);
>>>>  int auxtrace_record__info_fill(struct auxtrace_record *itr,
>>>>                                struct perf_session *session,
>>>>                                struct auxtrace_info_event *auxtrace_info,
>>>> --
>>>> 2.1.4
>>>>
>>>
>>> Arnaldo,
>>>
>>> As with my previous email, I can't queue this patch for 4.6 without at
>>> least a reviewed by from you.
>>>
>>> It has been rebased to 4.5-rc1 here [1] for your convenience.  I will
>>> be happy to use another baseline should that be more adequate for you.
>>
>> Adrian, are you ok with this?
> 
> I will try to look at this and the others in the next day or two.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
