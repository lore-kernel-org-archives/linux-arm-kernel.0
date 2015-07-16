From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 16 Jul 2015 12:16:58 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150716113115.45a17f17@gandalf.local.home>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
 <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
Message-ID: <20150716121658.7982fdf5@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015 11:31:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > In case of the number of entries, the following diff might be needed
> > as I suggested in the previous reply. ;)
> > 
> > ----8<----
> > 
> > @@ -330,7 +333,7 @@ static int t_show(struct seq_file *m, void *v)
> >  		seq_printf(m, "        Depth    Size   Location"
> >  			   "    (%d entries)\n"
> >  			   "        -----    ----   --------\n",
> > -			   max_stack_trace.nr_entries - 1);
> > +			   max_stack_trace.nr_entries);
> 
> This would break x86.

Nope, you were correct. But it was also missing another change:

-- Steve

Index: linux-trace.git/kernel/trace/trace_stack.c
===================================================================
--- linux-trace.git.orig/kernel/trace/trace_stack.c	2015-07-16 11:45:17.816249113 -0400
+++ linux-trace.git/kernel/trace/trace_stack.c	2015-07-16 12:01:51.051403333 -0400
@@ -284,7 +260,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n >= max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n > max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
 		return NULL;
 
 	m->private = (void *)n;
@@ -354,7 +330,7 @@ static int t_show(struct seq_file *m, vo
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   max_stack_trace.nr_entries - 1);
+			   max_stack_trace.nr_entries);
 
 		if (!stack_tracer_enabled && !max_stack_size)
 			print_disabled(m);
