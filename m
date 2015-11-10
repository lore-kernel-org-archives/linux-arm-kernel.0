From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 10 Nov 2015 09:25:01 -0500
Subject: [PATCH, REPORT] bpf_trace: build error without PERF_EVENTS
In-Reply-To: <5641F1BA.6040701@iogearbox.net>
References: <4525348.Aq9YoXkChv@wuerfel>
	<5641F1BA.6040701@iogearbox.net>
Message-ID: <20151110092501.0bc676c9@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Nov 2015 14:31:38 +0100
Daniel Borkmann <daniel@iogearbox.net> wrote:

> On 11/10/2015 01:55 PM, Arnd Bergmann wrote:
> > In my ARM randconfig tests, I'm getting a build error for
> > newly added code in bpf_perf_event_read and bpf_perf_event_output
> > whenever CONFIG_PERF_EVENTS is disabled:
> >
> > kernel/trace/bpf_trace.c: In function 'bpf_perf_event_read':
> > kernel/trace/bpf_trace.c:203:11: error: 'struct perf_event' has no member named 'oncpu'
> > if (event->oncpu != smp_processor_id() ||
> >           ^
> > kernel/trace/bpf_trace.c:204:11: error: 'struct perf_event' has no member named 'pmu'
> >        event->pmu->count)
> >
> > This can happen when UPROBE_EVENT is enabled but KPROBE_EVENT
> > is disabled. I'm not sure if that is a configuration we care
> > about, otherwise we could prevent this case from occuring by
> > adding Kconfig dependencies.  
> 
> I think that seems better than spreading #if IS_ENABLEDs into the code.
> Probably enough to add a 'depends on PERF_EVENTS' to config BPF_EVENTS,
> so it's also explicitly documented.
> 

So just do the following then?

-- Steve

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8d6363f42169..f5aecff2d243 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -434,7 +434,7 @@ config UPROBE_EVENT
 
 config BPF_EVENTS
 	depends on BPF_SYSCALL
-	depends on KPROBE_EVENT || UPROBE_EVENT
+	depends on KPROBE_EVENT && UPROBE_EVENT
 	bool
 	default y
 	help
