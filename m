From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 28 Nov 2017 10:13:11 -0700
Subject: [PATCH v2 1/4] coresight: Support panic dump functionality
In-Reply-To: <20171127015715.GA26822@leoy-linaro>
References: <1511233724-11867-1-git-send-email-leo.yan@linaro.org>
 <1511233724-11867-2-git-send-email-leo.yan@linaro.org>
 <20171122185828.GA17705@xps15> <20171124015408.GB13184@leoy-linaro>
 <CANLsYkwZv2qfP64Cs6Rp10GT4cExTzxp71TA6540qTvc=yXT+A@mail.gmail.com>
 <20171127015715.GA26822@leoy-linaro>
Message-ID: <CANLsYkz8ggOECdExw3dJ+sMN-gVVeQR_MhoD3+5-6079UBcnyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 November 2017 at 18:57, Leo Yan <leo.yan@linaro.org> wrote:
> On Fri, Nov 24, 2017 at 09:29:24AM -0700, Mathieu Poirier wrote:
>
> [...]
>
>> >> > +int coresight_dump_update(struct coresight_device *csdev, char *buf,
>> >> > +                     unsigned int buf_size)
>> >> > +{
>> >> > +   struct coresight_dump_node *node = csdev->dump_node;
>> >> > +
>> >> > +   if (!node) {
>> >> > +           dev_err(&csdev->dev, "Failed to update dump node.\n");
>> >> > +           return -EINVAL;
>> >> > +   }
>> >> > +
>> >> > +   node->buf = buf;
>> >> > +   node->buf_size = buf_size;
>> >>
>> >> How and where does this buffer get communicated to the kdump mechanic?
>> >
>> > Thanks for reviewing, Mathieu.
>> >
>> > Kdump can firstly find list head 'coresight_dump_list' by its global
>> > symbol address; then kdump can iterate every node to retrive buffer
>> > pointer and buffer size.
>>
>> I'd like to understand how the whole solution works - can you point me
>> to where that is done?
>
> Sure, I have sent coresight dump for 'crash' extension [1], you could
> see in function csdump_prepare() it searchs symbol
> 'coresight_dump_list' and then create list for dump nodes:
>
> static int csdump_prepare(void)
> {
>         [...]
>
>         /* Get pointer to dump list */
>         sym_dump_list = symbol_search("coresight_dump_list");
>         if (!sym_dump_list) {
>                 fprintf(fp, "symbol coresight_dump_list is not found\n");
>                 return -1;
>         }
>
>         cs_dump_list_head = (void *)sym_dump_list->value;
>         fprintf(fp, "cs_dump_list_head = 0x%p\n", cs_dump_list_head);
>
>         BZERO(&list_data, sizeof(struct list_data));
>         list_data.start = (ulong)cs_dump_list_head;
>         list_data.end = (ulong)cs_dump_list_head;
>         list_data.flags = LIST_ALLOCATE;
>         instance_count = do_list(&list_data);
>
>         [...]
> }

Thanks for pointing that out - I haven't looked at the user space yet.

>
>> >> > +   return 0;
>> >> > +}
>> >> > +
>> >> > +int coresight_dump_add(struct coresight_device *csdev, int cpu)
>> >> > +{
>> >> > +   struct coresight_dump_node *node;
>> >> > +   coresight_cb_t cb;
>> >> > +   unsigned int type;
>> >>
>> >> Filter on source or sink here, return for anything else.  That way we don't need
>> >> to clog the link structure with a callpack function that will never be used.
>> >> Doing so make sure we properly deal with the LINK_SINK type (based how I did
>> >> things in coresight.c it *may* be OK).
>> >
>> > Will do this.  For LINK_SINK type handling, I have no confidence I have
>> > completely understood your suggestion, do you suggest code as below?
>> >
>> >         if (type == CORESIGHT_DEV_TYPE_LINKSINK)
>> >                 type = (csdev == coresight_get_sink(path)) ?
>> >                                 CORESIGHT_DEV_TYPE_SINK :
>> >                                 CORESIGHT_DEV_TYPE_LINK;
>>
>>
>> Thinking further on this we have a problem.  An ETF can be a link or a
>> sink based on trace scenario specifics and we don't want to have 2
>> different ways to deal with sinks (one for ETB and another one for
>> ETF).  As such I'm suggesting to do the add/remove operation in the
>> sink's enable/disable functions.
>
> Will do this.
>
> Just want to check one thing: for coresight kdump, do we only need to
> dump tracers & sinks and skip to dump links? I want to get clear for
> the requirement, even the ETF is used as a link, should we still dump
> for it?
>

There isn't any useful information conveyed by the links.  If ETF is
used as a sink then it needs to be dump'ed (otherwise were will the
trace data come from).  Nothing needs to be done if used as a link.

>> >> > +
>> >> > +   /* Bail out when callback is NULL */
>> >> > +   cb = coresight_dump_get_cb(csdev);
>> >> > +   if (!cb)
>> >> > +           return 0;
>> >> > +
>> >> > +   node = kzalloc(sizeof(*node), GFP_KERNEL);
>> >> > +   if (!node)
>> >> > +           return -ENOMEM;
>> >> > +
>> >> > +   /*
>> >> > +    * Since source devices are used to save meta data, these devices
>> >> > +    * usually are per-CPU device and after panic happen there has risk
>> >> > +    * for the panic CPU cannot handle IPI and dump log anymore; so
>> >> > +    * register these devices as PRE_PANIC type and their callback are
>> >> > +    * called at late_initcall phase.
>> >> > +    */
>> >> > +   type = (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) ?
>> >> > +           CORESIGHT_DUMP_TYPE_PRE_PANIC :
>> >> > +           CORESIGHT_DUMP_TYPE_PANIC;
>> >> > +
>> >> > +   csdev->dump_node = (void *)node;
>> >> > +   node->cpu = cpu;
>> >> > +   node->type = type;
>> >> > +   node->csdev = csdev;
>> >> > +
>> >> > +   mutex_lock(&coresight_dump_lock);
>> >> > +   list_add_tail(&node->list, &coresight_dump_list);
>> >> > +   mutex_unlock(&coresight_dump_lock);
>> >> > +   return 0;
>> >> > +}
>> >> > +
>> >> > +void coresight_dump_del(struct coresight_device *csdev)
>> >> > +{
>> >> > +   struct coresight_dump_node *node;
>> >> > +   coresight_cb_t cb;
>> >> > +
>> >> > +   /* Bail out when callback is NULL */
>> >> > +   cb = coresight_dump_get_cb(csdev);
>> >> > +   if (!cb)
>> >> > +           return;
>> >> > +
>> >> > +   mutex_lock(&coresight_dump_lock);
>> >> > +   list_for_each_entry(node, &coresight_dump_list, list) {
>> >>
>> >> list_for_each_entry_safe()
>> >
>> > Will fix.
>> >
>> >> > +           if (node->csdev == csdev) {
>> >> > +                   list_del(&node->list);
>> >> > +                   kfree(node);
>> >>
>> >> Just add a 'break' here and remove the error message as it serves little
>> >> purpose.
>> >
>> > Will fix.
>> >
>> >> > +                   mutex_unlock(&coresight_dump_lock);
>> >> > +                   return;
>> >> > +           }
>> >> > +   }
>> >> > +   mutex_unlock(&coresight_dump_lock);
>> >> > +
>> >> > +   dev_err(&csdev->dev, "Failed to find dump node.\n");
>> >> > +}
>> >>
>> >> Addition and delition should be done when a session start and ends, so that
>> >> only the devices involved in this session are taken into account by the dump
>> >> mechanic.
>> >
>> > In this version patch set addition and delition are called from
>> > coresight_register() and coresight_unregister(), and every device
>> > panic callback can check if the device has enabled or disabled. If the
>> > device is disabled then it can skip the panic dump.
>> >
>> > The implementation in patch v2 is following comment from patch set v1 [1],
>> > sorry I sent patch set v2 with very long interval from v1 and I might
>> > misunderstand the comments from you and Suzuki.
>>
>> Right, but this patchset is significantly different than your previous
>> one, as such is it normal that comments from the previous one my not
>> apply fully.  But that's Ok, this is work in progress.
>
> Agree, thanks for clarification.
>
>> > Could you confirm which option is better? One is addition and delition
>> > called from coresight_register() and coresight_unregister()? Another
>> > is from session start and end?
>>
>> Adding a tracer to the list at registration time is useless, see
>> explanation below.
>>
>> >
>> > [1] http://archive.armlinux.org.uk/lurker/message/20170608.181301.8adf6ec5.en.html
>> >
>> >> Speaking of which, would it make sense to replace all the
>> >> coresight_dump_xyz() with coresight_kdump_xyz()?
>> >
>> > I am fine to replace coresight_dump_xyz() with coresight_kdump_xyz().
>> >
>> >> > +
>> >> > +static int coresight_dump_notify(struct notifier_block *nb,
>> >> > +                            unsigned long mode, void *_unused)
>> >> > +{
>> >> > +   return coresight_dump(CORESIGHT_DUMP_TYPE_PANIC);
>> >> > +}
>> >> > +
>> >> > +static int __init coresight_dump_init(void)
>> >> > +{
>> >> > +   int ret;
>> >> > +
>> >> > +   coresight_dump_nb.notifier_call = coresight_dump_notify;
>> >> > +   ret = atomic_notifier_chain_register(&panic_notifier_list,
>> >> > +                                        &coresight_dump_nb);
>> >> > +   if (ret)
>> >> > +           return ret;
>> >> > +
>> >> > +   return coresight_dump(CORESIGHT_DUMP_TYPE_PRE_PANIC);
>> >>
>> >> I'm not sure why we need to dump the information at boot time.  All this work
>> >> has to be done when a panic happens.  That would also give us the advantage of
>> >> not having to carry a 'type'.
>> >
>> > Yes, but if we want to dump ETM per-CPU meta data, it's safe to dump
>> > them before panic, otherwise the panic CPU might cannot handle IPI
>> > when panic happens. This is main reason I add "PRE_PANIC" type.
>> >
>> > Another benefit for "PRE_PANIC" dump is for hang case, if we want to
>> > debug hang case with coresight dump, the "PRE_PANIC" can dump meta
>> > data in system initilization phase and after the system hang we can
>> > rely on system rebooting (like watchdog) + bootloader to dump trace
>> > data (ETB/ETF), finally kdump also can easily extract them out from
>> > 'vmcore' dump file.
>>
>> The problem is that trace data can't be decoded if the tracer
>> configuration (i.e metadata) isn't correct.  At boot time tracers get
>> a default configuration that can later be modified by users to fit
>> trace scenarios.  The real tracer configuration isn't known until the
>> session starts, hence my comment in the ETM dump patch.
>
> Thanks for detailed guidance for this point.
>
> I have read your suggestions fro ETM dump patch in another email, now
> it's more clear for me. I will follow the suggestion for next version
> patch.
>
>> > I saw you have another email for ETM dump patch, will reply for that
>> > email for related discussion.
>> >
>> >> > +}
>> >> > +late_initcall(coresight_dump_init);
>> >> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
>> >> > index f1d0e21d..f268dbc 100644
>> >> > --- a/drivers/hwtracing/coresight/coresight-priv.h
>> >> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
>> >> > @@ -151,4 +151,21 @@ static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
>> >> >  static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
>> >> >  #endif
>> >> >
>> >> > +#define CORESIGHT_DUMP_TYPE_PRE_PANIC      0
>> >> > +#define CORESIGHT_DUMP_TYPE_PANIC  1
>> >> > +
>> >> > +#ifdef CONFIG_CORESIGHT_PANIC_DUMP
>> >> > +extern int coresight_dump_add(struct coresight_device *csdev, int cpu);
>> >> > +extern void coresight_dump_del(struct coresight_device *csdev);
>> >> > +extern int coresight_dump_update(struct coresight_device *csdev,
>> >> > +                            char *buf, unsigned int buf_size);
>> >> > +#else
>> >> > +static inline int coresight_dump_add(struct coresight_device *csdev, int cpu)
>> >> > +{ return 0; }
>> >>
>> >> static inline int
>> >> coresight_dump_add(struct coresight_device *csdev, int cpu) { return 0; }
>> >>
>> >> > +static inline void coresight_dump_del(struct coresight_device *csdev)
>> >> > +{ return; }
>> >>
>> >> static inline void coresight_dump_del(struct coresight_device *csdev) {}
>> >
>> > Will fix them.
>>
>> There is a lot of variables to take into account and it is quite
>> possible (and normal) that we adjust the solution as things go along,
>> based on new things we find.  This is work in progress and I think
>> it's coming a long well.
>
> Good to know this ahead.  Will mature the patch set step by step
> according to comments and suggestions.
>
> Thanks,
> Leo Yan
