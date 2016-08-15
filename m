From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 15 Aug 2016 10:28:26 -0400
Subject: [PATCH V4 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <1471261803-1186-2-git-send-email-zhang.chunyan@linaro.org>
References: <1471261803-1186-1-git-send-email-zhang.chunyan@linaro.org>
 <1471261803-1186-2-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <20160815102826.667318b6@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Aug 2016 19:50:01 +0800
Chunyan Zhang <zhang.chunyan@linaro.org> wrote:

> +int register_trace_export(struct trace_export *export);
> +int unregister_trace_export(struct trace_export *export);
> +
> +#endif	/* CONFIG_TRACING */
> +
> +#endif	/* _LINUX_TRACE_H */
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index dade4c9..0247ac2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -40,6 +40,7 @@
>  #include <linux/poll.h>
>  #include <linux/nmi.h>
>  #include <linux/fs.h>
> +#include <linux/trace.h>
>  #include <linux/sched/rt.h>
>  
>  #include "trace.h"
> @@ -2128,6 +2129,127 @@ void trace_buffer_unlock_commit_regs(struct trace_array *tr,
>  	ftrace_trace_userstack(buffer, flags, pc);
>  }
>  
> +static inline void
> +trace_generic_commit(struct trace_array *tr,
> +	       struct ring_buffer_event *event)

Why is this marked inline? It is never called directly here.

> +{
> +	struct trace_entry *entry;
> +	struct trace_export *export = tr->export;
> +	unsigned int size = 0;
> +
> +	entry = ring_buffer_event_data(event);
> +
> +	trace_entry_size(size, entry->type);
> +	if (!size)
> +		return;
> +
> +	if (export->write)
> +		export->write((char *)entry, size);
> +}
> +
> +static inline void

Same here.

> +trace_rb_commit(struct trace_array *tr,
> +	       struct ring_buffer_event *event)
> +{
> +	__buffer_unlock_commit(tr->trace_buffer.buffer, event);
> +}
> +
> +static DEFINE_MUTEX(trace_export_lock);
> +
> +static struct trace_export trace_export_rb __read_mostly = {
> +	.name		= "rb",
> +	.commit	= trace_rb_commit,

Make sure equal signs are lined up.

> +	.next		= NULL,
> +};
> +static struct trace_export *trace_exports_list __read_mostly = &trace_export_rb;

trace_exports_list needs to be annotated as rcu, if you are going to
dereference it via rcu_dereference. That was the kbuild warning you
received.



> +
> +inline void
> +trace_exports(struct trace_array *tr, struct ring_buffer_event *event)
> +{
> +	struct trace_export *export;
> +
> +	preempt_disable_notrace();
> +
> +	for (export = rcu_dereference_raw_notrace(trace_exports_list);
> +	     export && export->commit;
> +	     export = rcu_dereference_raw_notrace(export->next)) {
> +		tr->export = export;
> +		export->commit(tr, event);
> +	}
> +
> +	preempt_enable_notrace();
> +}

I'm not too happy about the added overhead to normal function tracing
(it will be noticeable), but I can fix that later.

> +
> +static void
> +add_trace_export(struct trace_export **list, struct trace_export *export)
> +{
> +	export->next = *list;

As export->next will most likely need to be marked __rcu as well, this
may need an rcu_assign_pointer() too.

> +	/*
> +	 * We are entering export into the list but another
> +	 * CPU might be walking that list. We need to make sure
> +	 * the export->next pointer is valid before another CPU sees
> +	 * the export pointer included into the list.
> +	 */
> +	rcu_assign_pointer(*list, export);
> +
> +}
> +
> +static int
> +rm_trace_export(struct trace_export **list, struct trace_export *export)
> +{
> +	struct trace_export **p;
> +
> +	for (p = list; *p != &trace_export_rb; p = &(*p)->next)
> +		if (*p == export)
> +			break;
> +
> +	if (*p != export)
> +		return -1;
> +
> +	*p = (*p)->next;

I believe this requires an rcu_assign_pointer() as well.

> +
> +	return 0;
> +}
> +
> +int register_trace_export(struct trace_export *export)
> +{
> +	if (!export->write) {
> +		pr_warn("trace_export must have the write() call back.\n");

Probably should be a "WARN_ON_ONCE()".

> +		return -1;
> +	}
> +
> +	if (!export->name) {
> +		pr_warn("trace_export must have a name.\n");
> +		return -1;
> +	}

If name isn't used don't add it till it is. That is, this patch should
not have "name" in the structure. It's confusing, because I don't see a
purpose for it.

> +
> +	mutex_lock(&trace_export_lock);
> +
> +	export->tr = trace_exports_list->tr;

I don't see where tr is ever assigned.

> +	export->commit = trace_generic_commit;

Shouldn't the caller pass in the commit function too?

> +
> +	add_trace_export(&trace_exports_list, export);
> +
> +	mutex_unlock(&trace_export_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(register_trace_export);
> +
> +int unregister_trace_export(struct trace_export *export)
> +{
> +	int ret;
> +
> +	mutex_lock(&trace_export_lock);
> +
> +	ret = rm_trace_export(&trace_exports_list, export);
> +
> +	mutex_unlock(&trace_export_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(unregister_trace_export);
> +
>  void
>  trace_function(struct trace_array *tr,
>  	       unsigned long ip, unsigned long parent_ip, unsigned long flags,
> @@ -2147,7 +2269,7 @@ trace_function(struct trace_array *tr,
>  	entry->parent_ip		= parent_ip;
>  
>  	if (!call_filter_check_discard(call, entry, buffer, event))

How do you handle the discard? If the entry doesn't match the filter,
it will try to discard the event. I don't see how the "trace_exports"
handle that.


> -		__buffer_unlock_commit(buffer, event);
> +		trace_exports(tr, event);
>  }
>  
>  #ifdef CONFIG_STACKTRACE
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index f783df4..a40f07c 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -260,6 +260,7 @@ struct trace_array {
>  	/* function tracing enabled */
>  	int			function_enabled;
>  #endif
> +	struct trace_export	*export;
>  };
>  
>  enum {
> @@ -301,6 +302,13 @@ static inline struct trace_array *top_trace_array(void)
>  		break;					\
>  	}
>  
> +#undef IF_SIZE
> +#define IF_SIZE(size, var, etype, id)		\
> +		if (var == id) {		\
> +			size = (sizeof(etype));	\
> +			break;			\
> +		}
> +
>  /* Will cause compile errors if type is not found. */
>  extern void __ftrace_bad_type(void);
>  
> @@ -339,6 +347,29 @@ extern void __ftrace_bad_type(void);
>  	} while (0)
>  
>  /*
> + * The trace_entry_size return the size of specific trace type
> + *
> + * IF_SIZE(size, var);
> + *
> + * Where "var" is just the given trace type.
> + */
> +#define trace_entry_size(size, var)					\
> +	do {								\
> +		IF_SIZE(size, var, struct ftrace_entry, TRACE_FN);	\
> +		IF_SIZE(size, var, struct stack_entry, TRACE_STACK);	\
> +		IF_SIZE(size, var, struct userstack_entry,		\
> +			TRACE_USER_STACK);				\
> +		IF_SIZE(size, var, struct print_entry, TRACE_PRINT);	\
> +		IF_SIZE(size, var, struct bprint_entry, TRACE_BPRINT);	\
> +		IF_SIZE(size, var, struct bputs_entry, TRACE_BPUTS);	\
> +		IF_SIZE(size, var, struct trace_branch, TRACE_BRANCH);	\
> +		IF_SIZE(size, var, struct ftrace_graph_ent_entry,	\
> +			TRACE_GRAPH_ENT);				\
> +		IF_SIZE(size, var, struct ftrace_graph_ret_entry,	\
> +			TRACE_GRAPH_RET);				\

I really really dislike this. This is a big if statement that all
needs to go down one by one. Very inefficient!

-- Steve

> +	} while (0)
> +
> +/*
>   * An option specific to a tracer. This is a boolean value.
>   * The bit is the bit index that sets its value on the
>   * flags value in struct tracer_flags.
