From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 30 Oct 2018 12:45:52 -0300
Subject: [PATCH] perf cs-etm: Correct CPU mode for samples
In-Reply-To: <b00357d2-10ab-e75e-6748-13341641f107@intel.com>
References: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
 <20181030143226.GA23310@kernel.org>
 <20181030150449.GB8344@leoy-ThinkPad-X240s>
 <20181030151137.GF23310@kernel.org>
 <b00357d2-10ab-e75e-6748-13341641f107@intel.com>
Message-ID: <20181030154552.GH23310@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Oct 30, 2018 at 05:30:55PM +0200, Adrian Hunter escreveu:
> On 30/10/18 5:11 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 30, 2018 at 11:04:49PM +0800, leo.yan at linaro.org escreveu:
> >> Hi Arnaldo,
> >>
> >> On Tue, Oct 30, 2018 at 11:32:26AM -0300, Arnaldo Carvalho de Melo wrote:
> >>> Em Tue, Oct 30, 2018 at 03:18:28PM +0800, Leo Yan escreveu:
> >>>> Since commit 9042f5e3539e ("perf tools: Stop fallbacking to kallsyms
> >>>> for vdso symbols lookup"), the kernel address cannot be properly parsed
> >>>> to kernel symbol with command 'perf script -k vmlinux'.  The reason is
> >>>> CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
> >>>> thus it fails to find corresponding map/dso in below flows:
> >>>>
> >>>>   process_sample_event()
> >>>>     `-> machine__resolve()
> >>>> 	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);
> >>>>
> >>>> In this flow it needs to pass argument 'sample->cpumode' to tell what's
> >>>> the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
> >>>> any failure until the commit 9042f5e3539e ("perf tools: Stop fallbacking
> >>>> to kallsyms for vdso symbols lookup") has been merged.  The reason is
> >>>> even with the wrong CPU mode the function thread__find_map() firstly
> >>>> fails to find map but it will rollback to find kernel map for vdso
> >>>> symbols lookup.  In the latest code it has removed the fallback code,
> >>>> thus if CPU mode is PERF_RECORD_MISC_USER then it cannot find map
> >>>> anymore with kernel address.
> >>>>
> >>>> This patch is to correct samples CPU mode setting, it creates a new
> >>>> helper function cs_etm__cpu_mode() to tell what's the CPU mode based on
> >>>> the address with the info from machine structure; this patch has a bit
> >>>> extension to check not only kernel and user mode, but also check for
> >>>> host/guest and hypervisor mode.  Finally this patch uses the function
> >>>> in instruction and branch samples and also apply in cs_etm__mem_access()
> >>>> for a minor polishing.
> >>>
> >>> Mathieu, can I have your Acked-by, please? Leo, thanks for acting so
> >>> quickly on this one! 
> >>
> >> Thanks for reivewing.  Yeah, let's wait for Mathieu reviewing as well,
> >> as I know he is travelling so might be delay a bit.
> > 
> > I'm tentatively applying the patch, as this needs fixing ASAP, and I
> > take that you have tested it and it cured the problem for you, so should
> > be a good indication for the acceptance of the patch.
> > 
> > We can always fix some detail later.
> >  
> >> Just remind, we might need the similiar change for util/intel-pt.c and
> >> util/intel-bts.c when generate samples, otherwise they might have the
> >> same regression for kernel symbols.  I am not the best person to change
> >> these two files, but bring up this for attention.
 
> > Right, I think Adrian is working on it, Adrian?
 
> Yes although I am more concerned with branches from user space to kernel
> space and vice versa, which this patch doesn't deal with.  Also there are
> many cpumode issues in perf tools, and really the only way to deal with
> them simply at the moment is to put back the fallback for arches other
> than sparc i.e.

We can do that, sure, but the opportunity to fix at least some of those
problems and then make this fallback not to take place looks reasonable,
for instance, I have this patch now in my local tree, from David, that
posted just as a way to show part of the problem, parts of the commit
message I wrote, parts are from David:

commit 54ac9007e6cb77c37ebf4f5e3debb23075cc90f0
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Oct 30 12:12:26 2018 -0300

    perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}
    
    When processing using 'perf report -g caller', which is the default, we
    ended up reverting the callchain entries received from the kernel, but
    simply reverting trows away the information that tells that from a point
    onwards the addresses are for userspace, kernel, guest kernel, guest
    user, hypervisor.
    
    The idea is that if we are walking backwards, for each cluster of
    non-cpumode entries we have to first scan backwards for the next one and
    use that for the cluster.
    
    This seems silly and more expensive than it needs to be but it is enough
    for a initial fix.
    
    The code here is really complicated because it is intimately intertwined
    with the lbr and branch handling, as well as this callchain order,
    further fixes will be needed to properly take into account the cpumode
    in those cases.
    
    Another problem with ORDER_CALLER is that the NULL "0" IP that is at the
    end of most callchains shows up at the top of the histogram because
    every callchain contains it and with ORDER_CALLER it is the first entry.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Souvik Banerjee <souvik1997@gmail.com>
    Cc: Wang Nan <wangnan0@huawei.com>
    Cc: stable at vger.kernel.org # 4.19
    Link: https://lkml.kernel.org/n/tip-2wt3ayp6j2y2f2xowixa8y6y at git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..8ee8ab39d8ac 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2140,6 +2140,27 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	return 0;
 }
 
+static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
+			     struct callchain_cursor *cursor,
+			     struct symbol **parent,
+			     struct addr_location *root_al,
+			     u8 *cpumode, int ent)
+{
+	int err = 0;
+
+	while (--ent >= 0) {
+		u64 ip = chain->ips[ent];
+
+		if (ip >= PERF_CONTEXT_MAX) {
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, cpumode, ip,
+					       false, NULL, NULL, 0);
+			break;
+		}
+	}
+	return err;
+}
+
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct perf_evsel *evsel,
@@ -2246,6 +2267,12 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	}
 
 check_calls:
+	if (callchain_param.order != ORDER_CALLEE) {
+		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
+					&cpumode, chain->nr - first_call);
+		if (err)
+			return (err < 0) ? err : 0;
+	}
 	for (i = first_call, nr_entries = 0;
 	     i < chain_nr && nr_entries < max_stack; i++) {
 		u64 ip;
@@ -2260,9 +2287,15 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 #endif
 		ip = chain->ips[j];
-
 		if (ip < PERF_CONTEXT_MAX)
                        ++nr_entries;
+		else if (callchain_param.order != ORDER_CALLEE) {
+			err = find_prev_cpumode(chain, thread, cursor, parent,
+						root_al, &cpumode, j);
+			if (err)
+				return (err < 0) ? err : 0;
+			continue;
+		}
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
