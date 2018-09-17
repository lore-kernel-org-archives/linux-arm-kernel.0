From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 17 Sep 2018 10:38:20 -0700
Subject: [PATCH 2/6] pstore: Add event tracing support
In-Reply-To: <444d7b13-2653-ba0e-e9e6-a448fded2a77@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <444d7b13-2653-ba0e-e9e6-a448fded2a77@codeaurora.org>
Message-ID: <153720590027.119890.15984895820368075914@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sai Prakash Ranjan (2018-09-11 03:46:01)
> On 9/9/2018 1:57 AM, Sai Prakash Ranjan wrote:
> > +void notrace pstore_event_call(struct trace_event_buffer *fbuffer)
> > +{
> > +     struct trace_iterator *iter;
> > +     struct trace_seq *s;
> > +     struct trace_event_call *event_call;
> > +     struct pstore_record record;
> > +     struct trace_event *event;
> > +     struct seq_buf *seq;
> > +     unsigned long flags;
> > +
> > +     if (!psinfo)
> > +             return;
> > +
> > +     if (unlikely(oops_in_progress))
> > +             return;
> > +
> > +     pstore_record_init(&record, psinfo);
> > +     record.type = PSTORE_TYPE_EVENT;
> > +
> > +     iter = kmalloc(sizeof(*iter), GFP_KERNEL);
> > +     if (!iter)
> > +             return;
> > +
> > +     event_call = fbuffer->trace_file->event_call;
> > +     if (!event_call || !event_call->event.funcs ||
> > +         !event_call->event.funcs->trace)
> > +             goto fail_event;
> > +
> > +     event = &fbuffer->trace_file->event_call->event;
> > +
> > +     spin_lock_irqsave(&psinfo->buf_lock, flags);
> > +
> > +     trace_seq_init(&iter->seq);
> > +     iter->ent = fbuffer->entry;
> > +     event_call->event.funcs->trace(iter, 0, event);
> > +     trace_seq_putc(&iter->seq, 0);
> > +
> > +     if (seq->size > psinfo->bufsize)
> > +             seq->size = psinfo->bufsize;
> > +
> > +     s = &iter->seq;
> > +     seq = &s->seq;
> > +
> > +     record.buf = (char *)(seq->buffer);
> > +     record.size = seq->len;
> > +     psinfo->write(&record);
> > +
> > +     spin_unlock_irqrestore(&psinfo->buf_lock, flags);
> > +
> > +fail_event:
> > +     kfree(iter);
> > +}
> > +
> > 
> 
> When tracing sched events on sdm845 mtp, I hit below bug repeatedly.
> Seems like pstore_event_call can be called in atomic context.
> I will respin the below fix in next version of the patch.
> Reviews on other parts would be appreciated, thanks.
> 
> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> index d47dc93ac098..a497cf782ee8 100644
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -73,6 +73,7 @@ void notrace pstore_event_call(struct 
> trace_event_buffer *fbuffer)
>          struct trace_event *event;
>          struct seq_buf *seq;
>          unsigned long flags;
> +       gfp_t gfpflags;
> 
>          if (!psinfo)
>                  return;
> @@ -83,7 +84,9 @@ void notrace pstore_event_call(struct 
> trace_event_buffer *fbuffer)
>          pstore_record_init(&record, psinfo);
>          record.type = PSTORE_TYPE_EVENT;
> 
> -       iter = kmalloc(sizeof(*iter), GFP_KERNEL);
> +       gfpflags = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : 
> GFP_KERNEL;
> +

Do you need to allocate at all? Can you throw the iter on the stack?

Using in_atomic() and irqs_disabled() to figure out if an atomic or a
non-atomic allocation should be used is not a good solution.
