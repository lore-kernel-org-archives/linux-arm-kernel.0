From: ankgupta@codeaurora.org (Ankit Gupta)
Date: Wed, 8 Jul 2015 11:56:33 -0600
Subject: [PATCH V3] trace/events: add chip name and hwirq to irq entry
 tracepoint
In-Reply-To: <alpine.DEB.2.11.1507052326100.3916@nanos>
References: <1435162650-32266-1-git-send-email-ankgupta@codeaurora.org>
 <20150624124227.1cddbbac@gandalf.local.home>
 <alpine.DEB.2.11.1507052326100.3916@nanos>
Message-ID: <2686ba70b03b3e16c94f93052aa56703.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 24 Jun 2015, Steven Rostedt wrote:
>> > +
>> > +#define show_chip_name(irq)					\
>> > +	(irq_get_irq_data(irq)					\
>> > +			 ? irq_get_irq_data(irq)->chip->name	\
>> > +			 : "NULL")
>> > +
>> > +#define show_hwirq(irq)						\
>> > +	(irq_get_irq_data(irq)					\
>> > +			 ? irq_get_irq_data(irq)->hwirq		\
>> > +			 : -ENODEV)
>>
>> Note these magic functions will only be useful for the tracefs reads of
>> the trace files. Userspace tools that extract the data (like perf and
>> trace-cmd), will have no idea of how to parse it.
>>
>> I'm not against doing this, but I'm just letting you know what the
>> effect of this change will be.
>
> What's worse is, that they are racy against a concurrent teardown of
> the interrupt. Not a good idea ...
>

Agree, I'll save the chip-name and hwirq in the struct. This technique
using the same macros to save the chip-name and hwirq in the struct also
works well with trace-cmd.

Thanks,
Ankit and Gilad

> Thanks,
>
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
