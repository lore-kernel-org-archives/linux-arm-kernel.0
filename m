From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 24 Jun 2015 12:42:27 -0400
Subject: [PATCH V3] trace/events: add chip name and hwirq to irq entry
 tracepoint
In-Reply-To: <1435162650-32266-1-git-send-email-ankgupta@codeaurora.org>
References: <1435162650-32266-1-git-send-email-ankgupta@codeaurora.org>
Message-ID: <20150624124227.1cddbbac@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jun 2015 10:17:30 -0600
Ankit Gupta <ankgupta@codeaurora.org> wrote:

> Add chip name and hw-irq number to the trace_irq_handler_entry()
> tracepoint. When tracing interrupt events the chip-name and hw-irq
> numbers are stable and known in advance. This makes them a better
> choice as a filtering criteria for the trace buffer dump. On the
> flipside, the os-irq numbers are dynamically allocated which makes
> them difficult to use for the same purpose.
> 
> Dump messages will look like:
> ...irq_handler_entry: irq=22 name=msm_serial0 chip_name=GIC hwirq=140
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Reviewed-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Gilad Avidov <gavidov@codeaurora.org>
> Signed-off-by: Ankit Gupta <ankgupta@codeaurora.org>
> ---
> Changes since V2:
> - fixed dump message in commit text to reflect Chip name
>   instead of domain.
> ---
> Changes since V1:
> - added reviewed by Andy Gross
> ---
>  include/trace/events/irq.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
> index 3608beb..5370075 100644
> --- a/include/trace/events/irq.h
> +++ b/include/trace/events/irq.h
> @@ -23,6 +23,17 @@ struct softirq_action;
>  			 softirq_name(HRTIMER),		\
>  			 softirq_name(RCU))
>  
> +
> +#define show_chip_name(irq)					\
> +	(irq_get_irq_data(irq)					\
> +			 ? irq_get_irq_data(irq)->chip->name	\
> +			 : "NULL")
> +
> +#define show_hwirq(irq)						\
> +	(irq_get_irq_data(irq)					\
> +			 ? irq_get_irq_data(irq)->hwirq		\
> +			 : -ENODEV)

Note these magic functions will only be useful for the tracefs reads of
the trace files. Userspace tools that extract the data (like perf and
trace-cmd), will have no idea of how to parse it.

I'm not against doing this, but I'm just letting you know what the
effect of this change will be.

-- Steve

> +
>  /**
>   * irq_handler_entry - called immediately before the irq action handler
>   * @irq: irq number
> @@ -50,7 +61,9 @@ TRACE_EVENT(irq_handler_entry,
>  		__assign_str(name, action->name);
>  	),
>  
> -	TP_printk("irq=%d name=%s", __entry->irq, __get_str(name))
> +	TP_printk("irq=%d name=%s chip_name=%s hwirq=%ld", __entry->irq,
> +	  __get_str(name), show_chip_name(__entry->irq),
> +	  show_hwirq(__entry->irq))
>  );
>  
>  /**
