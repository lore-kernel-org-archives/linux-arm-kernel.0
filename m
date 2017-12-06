From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Wed, 6 Dec 2017 10:47:02 -0300
Subject: [PATCH v9 3/5] perf utils: use pmu->is_uncore to detect PMU
 UNCORE devices
In-Reply-To: <71db0255-af9b-968a-7baa-238d7146f069@linux.intel.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
 <20171016183222.25750-4-ganapatrao.kulkarni@cavium.com>
 <6fdad34d-1612-0447-e58e-5c748f92668d@linux.intel.com>
 <CAKTKpr7oM4h_gxj1P=r_J_T5L_Mmtqqj_Uvji-fARKnQRnCP1w@mail.gmail.com>
 <d576d4c6-663c-dfc1-5618-3fa7c5102e7a@linux.intel.com>
 <1f79aa3c-a061-7c55-5d3e-f13638be01ad@linux.intel.com>
 <20171205184242.GA19952@kernel.org>
 <71db0255-af9b-968a-7baa-238d7146f069@linux.intel.com>
Message-ID: <20171206134702.GA12234@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, Dec 06, 2017 at 08:30:37AM +0800, Jin, Yao escreveu:
> 
> 
> On 12/6/2017 2:42 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 05, 2017 at 08:35:22PM +0800, Jin, Yao escreveu:
> > > A quick test with the new patch 'fix_json_v9_2.patch' shows it working.
> > 
> > I'll take this as a Tested-by: you, ok?
> 
> Hi Arnaldo,
> 
> I didn't do a full test for this patch and for the whole patch series.
> 
> I just do a quick test and it shows that the regression issue which was
> found in 'perf stat --per-thread' test case is disappear.
> 
> If you think it's enough for adding Tested-by, that's fine for me. :)

I guess this addresses at least your previous regression report, so I
think it is warranted, thanks!

- arnaldo
 
> Thanks
> Jin Yao
> 
> > > See the log:
> > > 
> > > root at skl:/tmp# perf stat --per-thread -p 10322 -M CPI,IPC
> > > ^C
> > >   Performance counter stats for process id '10322':
> > > 
> > >            vmstat-10322             1,879,654      inst_retired.any #
> > > 0.8 CPI
> > >            vmstat-10322             1,565,807      cycles
> > >            vmstat-10322             1,879,654      inst_retired.any #
> > > 1.2 IPC
> > >            vmstat-10322             1,565,807      cpu_clk_unhalted.thread
> > > 
> > >         2.850291804 seconds time elapsed
> > > 
> > > Thanks for fixing it quickly.
> > > 
> > > Thanks
> > > Jin Yao
> > > 
> > > On 12/5/2017 3:23 PM, Jin, Yao wrote:
> > > > Hi,
> > > > 
> > > > I applied the diff but it's failed.
> > > > 
> > > > jinyao at skl:~/skl-ws/perf-dev/lck-4594/src$ patch -p1 < 1.pat
> > > > patching file tools/perf/util/pmu.c
> > > > patch: **** malformed patch at line 41: *head, struct perf_pmu *pmu)
> > > > 
> > > > Could you send the patch as attachment to me in another mail thread?
> > > > 
> > > > to yao.jin at linux.intel.com
> > > > cc yao.jin at intel.com
> > > > 
> > > > Thanks
> > > > Jin Yao
> > > > 
> > > > On 12/5/2017 3:12 PM, Ganapatrao Kulkarni wrote:
> > > > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > > > index 5ad8a18..57e38fd 100644
> > > > > --- a/tools/perf/util/pmu.c
> > > > > +++ b/tools/perf/util/pmu.c
> > > > > @@ -538,6 +538,34 @@ static bool pmu_is_uncore(const char *name)
> > > > >  ? }
> > > > > 
> > > > >  ? /*
> > > > > + *? PMU CORE devices have different name other than cpu in sysfs on some
> > > > > + *? platforms. looking for possible sysfs files to identify as core
> > > > > device.
> > > > > + */
> > > > > +static int is_pmu_core(const char *name)
> > > > > +{
> > > > > + struct stat st;
> > > > > + char path[PATH_MAX];
> > > > > + const char *sysfs = sysfs__mountpoint();
> > > > > +
> > > > > + if (!sysfs)
> > > > > + return 0;
> > > > > +
> > > > > + /* Look for cpu sysfs (x86 and others) */
> > > > > + scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu", sysfs);
> > > > > + if ((stat(path, &st) == 0) &&
> > > > > + (strncmp(name, "cpu", strlen("cpu")) == 0))
> > > > > + return 1;
> > > > > +
> > > > > + /* Look for cpu sysfs (specific to arm) */
> > > > > + scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
> > > > > + sysfs, name);
> > > > > + if (stat(path, &st) == 0)
> > > > > + return 1;
> > > > > +
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > >  ?? * Return the CPU id as a raw string.
> > > > >  ?? *
> > > > >  ?? * Each architecture should provide a more precise id string that
> > > > > @@ -641,7 +669,7 @@ static void pmu_add_cpu_aliases(struct list_head
> > > > > *head, struct perf_pmu *pmu)
> > > > >  ?? break;
> > > > >  ?? }
> > > > > 
> > > > > - if (pmu->is_uncore) {
> > > > > + if (!is_pmu_core(name)) {
> > > > >  ?? /* check for uncore devices */
> > > > >  ?? if (pe->pmu == NULL)
> > > > >  ?? continue;
