From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sat, 17 Sep 2016 22:33:11 +0900
Subject: [PATCH V5] perf tools: adding support for address filters
In-Reply-To: <CANLsYkwRUps0Mtc_yQfNOW+qsmOXT8yaGrDj4566LPPTrLsUxg@mail.gmail.com>
References: <1473702794-8493-1-git-send-email-mathieu.poirier@linaro.org>
 <cd7b9dc9-686c-813e-ff9f-97faba377799@intel.com>
 <CANLsYkz_rQ5uhJQ0x9EDi6vcx4xHrbjjSdwxA=X1ssHq4ucALQ@mail.gmail.com>
 <20160914082535.3304d51a1a6a085234f77529@kernel.org>
 <CANLsYkwRUps0Mtc_yQfNOW+qsmOXT8yaGrDj4566LPPTrLsUxg@mail.gmail.com>
Message-ID: <20160917223311.19dac50f03da4f40fd5cc844@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Sep 2016 09:32:43 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> On 13 September 2016 at 17:25, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Tue, 13 Sep 2016 08:18:10 -0600
> > Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> >> On 13 September 2016 at 04:01, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> > On 12/09/16 20:53, Mathieu Poirier wrote:
> >> >> This patch makes it possible to use the current filter
> >> >> framework with address filters.  That way address filters for
> >> >> HW tracers such as CoreSight and IntelPT can be communicated
> >> >> to the kernel drivers.
> >> >>
> >> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> >>
> >> >> ---
> >> >> Changes for V5:
> >> >>  - Modified perf_evsel__append_filter() to take a string format
> >> >>    rather than an operation.
> >> >
> >> > Hope I'm not being a pain, but aren't there other places calling
> >> > perf_evsel__append_filter() that need to be changed.  Might make
> >> > sense as a separate patch.
> >>
> >> No no, you're right - I completely overlooked that.
> >>
> >> But shouldn't it be in the same patch?  That way a git bisect would
> >> stay consistent...
> >
> > You're right. Caller and callee should be changed in atomic.
> >
> > BTW, could you add document updates how the perf command line
> > will be changed, and also show the result in the patch description?
> 
> This patch does not change anything on the perf command line.  It
> simply allows current options to succeed (as they should) rather than
> fail.

Yes, and it will make perf acceptable to pass --filter to CoreSight or
Intel PT events, or am I misunderstand?
If it is correct, could you give us an example how to pass it, since
tools/perf/Documentation/perf-record.txt says it is only for tracepoints?

Thank you,


> 
> Thanks,
> Mathieu
> 
> >
> > Thank you,
> >
> >>
> >> >
> >> >>
> >> >> Changes for V4:
> >> >>  - Added support for address filters over more than one
> >> >>    nibble.
> >> >>  - Removed Jiri's ack, this version is too different from
> >> >>    what was reviewed.
> >> >>
> >> >> Changes for V3:
> >> >>  - Added Jiri's ack.
> >> >>  - Rebased to v4.8-rc5.
> >> >>
> >> >> Changes for V2:
> >> >>  - Rebased to v4.8-rc4.
> >> >>  - Revisited error path.
> >> >>
> >> >>
> >> >>  tools/perf/util/evsel.c        |  4 ++--
> >> >>  tools/perf/util/evsel.h        |  2 +-
> >> >>  tools/perf/util/parse-events.c | 40 +++++++++++++++++++++++++++++++++++-----
> >> >>  3 files changed, 38 insertions(+), 8 deletions(-)
> >> >>
> >> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> >> index d40f852d2de2..a9bb277f221f 100644
> >> >> --- a/tools/perf/util/evsel.c
> >> >> +++ b/tools/perf/util/evsel.c
> >> >> @@ -1047,14 +1047,14 @@ int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter)
> >> >>  }
> >> >>
> >> >>  int perf_evsel__append_filter(struct perf_evsel *evsel,
> >> >> -                           const char *op, const char *filter)
> >> >> +                           const char *fmt, const char *filter)
> >> >>  {
> >> >>       char *new_filter;
> >> >>
> >> >>       if (evsel->filter == NULL)
> >> >>               return perf_evsel__set_filter(evsel, filter);
> >> >>
> >> >> -     if (asprintf(&new_filter,"(%s) %s (%s)", evsel->filter, op, filter) > 0) {
> >> >> +     if (asprintf(&new_filter, fmt, evsel->filter, filter) > 0) {
> >> >>               free(evsel->filter);
> >> >>               evsel->filter = new_filter;
> >> >>               return 0;
> >> >> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> >> >> index 8ceb7ebb51f5..50595c8c7207 100644
> >> >> --- a/tools/perf/util/evsel.h
> >> >> +++ b/tools/perf/util/evsel.h
> >> >> @@ -236,7 +236,7 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
> >> >>
> >> >>  int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
> >> >>  int perf_evsel__append_filter(struct perf_evsel *evsel,
> >> >> -                           const char *op, const char *filter);
> >> >> +                           const char *fmt, const char *filter);
> >> >>  int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
> >> >>                            const char *filter);
> >> >>  int perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
> >> >> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> >> >> index 2eb8b1ed4cc8..8e683979ccd8 100644
> >> >> --- a/tools/perf/util/parse-events.c
> >> >> +++ b/tools/perf/util/parse-events.c
> >> >> @@ -1760,20 +1760,50 @@ foreach_evsel_in_last_glob(struct perf_evlist *evlist,
> >> >>  static int set_filter(struct perf_evsel *evsel, const void *arg)
> >> >>  {
> >> >>       const char *str = arg;
> >> >> +     bool found = false;
> >> >> +     int nr_addr_filters = 0;
> >> >> +     struct perf_pmu *pmu = NULL;
> >> >>
> >> >> -     if (evsel == NULL || evsel->attr.type != PERF_TYPE_TRACEPOINT) {
> >> >> -             fprintf(stderr,
> >> >> -                     "--filter option should follow a -e tracepoint option\n");
> >> >> -             return -1;
> >> >> +     if (evsel == NULL)
> >> >> +             goto err;
> >> >> +
> >> >> +     if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
> >> >> +             if (perf_evsel__append_filter(evsel,
> >> >> +                                           "(%s) && (%s)", str) < 0) {
> >> >> +                     fprintf(stderr,
> >> >> +                             "not enough memory to hold filter string\n");
> >> >> +                     return -1;
> >> >> +             }
> >> >> +
> >> >> +             return 0;
> >> >>       }
> >> >>
> >> >> -     if (perf_evsel__append_filter(evsel, "&&", str) < 0) {
> >> >> +     while ((pmu = perf_pmu__scan(pmu)) != NULL)
> >> >> +             if (pmu->type == evsel->attr.type) {
> >> >> +                     found = true;
> >> >> +                     break;
> >> >> +             }
> >> >> +
> >> >> +     if (found)
> >> >> +             perf_pmu__scan_file(pmu, "nr_addr_filters",
> >> >> +                                 "%d", &nr_addr_filters);
> >> >> +
> >> >> +     if (!nr_addr_filters)
> >> >> +             goto err;
> >> >> +
> >> >> +     if (perf_evsel__append_filter(evsel, "%s,%s", str) < 0) {
> >> >>               fprintf(stderr,
> >> >>                       "not enough memory to hold filter string\n");
> >> >>               return -1;
> >> >>       }
> >> >>
> >> >>       return 0;
> >> >> +
> >> >> +err:
> >> >> +     fprintf(stderr,
> >> >> +             "--filter option should follow a -e tracepoint or HW tracer option\n");
> >> >> +
> >> >> +     return -1;
> >> >>  }
> >> >>
> >> >>  int parse_filter(const struct option *opt, const char *str,
> >> >>
> >> >
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
