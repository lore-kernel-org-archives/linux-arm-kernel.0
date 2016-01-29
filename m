From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Fri, 29 Jan 2016 15:39:10 +0800
Subject: [RFC 3/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <CAGS+omBjD1pXKY_6bFbiGxa5bttvqg5zEvKevzSfoiMOy7ys6Q@mail.gmail.com>
References: <1453266881-16849-1-git-send-email-hs.liao@mediatek.com>
 <1453266881-16849-4-git-send-email-hs.liao@mediatek.com>
 <CAGS+omBjD1pXKY_6bFbiGxa5bttvqg5zEvKevzSfoiMOy7ys6Q@mail.gmail.com>
Message-ID: <1454053150.32413.52.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

Many thanks for your comments and time.
I reply my plan inline.


On Thu, 2016-01-28 at 12:49 +0800, Daniel Kurtz wrote:
> Hi HS,
> 
> Sorry for the delay.  It is hard to find time to review a >3700 line
> driver :-o in detail....
> 
> Some review comments inline, although I still do not completely
> understand how all that this driver does and how it works.
> I'll try to find time to go through this driver in detail again next
> time you post it for review.
> 
> On Tue, Jan 19, 2016 at 9:14 PM,  <hs.liao@mediatek.com> wrote:
> > From: HS Liao <hs.liao@mediatek.com>
> >
> > This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> > CMDQ is used to help read/write registers with critical time limitation,
> > such as updating display configuration during the vblank. It controls
> > Global Command Engine (GCE) hardware to achieve this requirement.
> > Currently, CMDQ only supports display related hardwares, but we expect
> > it can be extended to other hardwares for future requirements.
> >
> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> 
> [snip]
> 
> > diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
> > new file mode 100644
> > index 0000000..7570f00
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-cmdq.c
> 
> [snip]
> 
> > +/*
> > + * Maximum prefetch buffer size.
> > + * Unit is instructions.
> > + */
> > +#define CMDQ_MAX_PREFETCH_INSTUCTION   240
> 
> INSTRUCTION

will fix

> [snip]
> 
> > +
> > +/* get lsb for subsys encoding in arg_a (range: 0 - 31) */
> > +
> > +enum cmdq_eng {
> > +       CMDQ_ENG_DISP_UFOE = 0,
> > +       CMDQ_ENG_DISP_AAL,
> > +       CMDQ_ENG_DISP_COLOR0,
> > +       CMDQ_ENG_DISP_COLOR1,
> > +       CMDQ_ENG_DISP_RDMA0,
> > +       CMDQ_ENG_DISP_RDMA1,
> > +       CMDQ_ENG_DISP_RDMA2,
> > +       CMDQ_ENG_DISP_WDMA0,
> > +       CMDQ_ENG_DISP_WDMA1,
> > +       CMDQ_ENG_DISP_OVL0,
> > +       CMDQ_ENG_DISP_OVL1,
> > +       CMDQ_ENG_DISP_GAMMA,
> > +       CMDQ_ENG_DISP_DSI0_CMD,
> > +       CMDQ_ENG_DISP_DSI1_CMD,
> 
> Why do these last two have "_CMD" at the end?

will remove

> > +       CMDQ_MAX_ENGINE_COUNT   /* ALWAYS keep at the end */
> > +};
> > +
> > +struct cmdq_command {
> > +       struct cmdq             *cqctx;
> > +       u32                     scenario;
> > +       /* task priority (NOT HW thread priority) */
> > +       u32                     priority;
> > +       /* bit flag of used engines */
> > +       u64                     engine_flag;
> > +       /*
> > +        * pointer of instruction buffer
> > +        * This must point to an 64-bit aligned u32 array
> > +        */
> > +       u32                     *va_base;
> 
> All of your "va" and "va_base" should be void *, not u32 *.

will do

> > +       /* size of instruction buffer, in bytes. */
> > +       u32                     block_size;
> 
> Better to use size_t for "size in bytes".

will fix

> > +};
> > +
> > +enum cmdq_code {
> > +       /* These are actual HW op code. */
> > +       CMDQ_CODE_MOVE = 0x02,
> > +       CMDQ_CODE_WRITE = 0x04,
> > +       CMDQ_CODE_JUMP = 0x10,
> > +       CMDQ_CODE_WFE = 0x20,   /* wait for event (and clear) */
> > +       CMDQ_CODE_CLEAR_EVENT = 0x21,   /* clear event */
> > +       CMDQ_CODE_EOC = 0x40,   /* end of command */
> > +};
> > +
> > +enum cmdq_task_state {
> > +       TASK_STATE_IDLE,        /* free task */
> > +       TASK_STATE_BUSY,        /* task running on a thread */
> > +       TASK_STATE_KILLED,      /* task process being killed */
> > +       TASK_STATE_ERROR,       /* task execution error */
> > +       TASK_STATE_DONE,        /* task finished */
> > +       TASK_STATE_WAITING,     /* allocated but waiting for available thread */
> > +};
> > +
> > +struct cmdq_cmd_buf {
> > +       atomic_t                used;
> > +       void                    *va;
> > +       dma_addr_t              pa;
> > +};
> > +
> > +struct cmdq_task_cb {
> > +       /* called by isr */
> > +       cmdq_async_flush_cb     isr_cb;
> > +       void                    *isr_data;
> > +       /* called by releasing task */
> > +       cmdq_async_flush_cb     done_cb;
> > +       void                    *done_data;
> > +};
> > +
> > +struct cmdq_task {
> > +       struct cmdq             *cqctx;
> > +       struct list_head        list_entry;
> > +
> > +       /* state for task life cycle */
> > +       enum cmdq_task_state    task_state;
> > +       /* virtual address of command buffer */
> > +       u32                     *va_base;
> > +       /* physical address of command buffer */
> > +       dma_addr_t              mva_base;
> > +       /* size of allocated command buffer */
> > +       u32                     buf_size;
> 
> size_t

will fix

> > +       /* It points to a cmdq_cmd_buf if this task use command buffer pool. */
> > +       struct cmdq_cmd_buf     *cmd_buf;
> > +
> > +       int                     scenario;
> > +       int                     priority;
> > +       u64                     engine_flag;
> > +       u32                     command_size;
> > +       u32                     num_cmd;
> > +       int                     reorder;
> > +       /* HW thread ID; CMDQ_INVALID_THREAD if not running */
> > +       int                     thread;
> 
> I think this driver will be a lot more clear if you do this:
> 
> struct cmdq_thread *thread;
> 
> And then use "NULL" for "invalid thread" instead of CMDQ_INVALID_THREAD.

I will try to use cmdq_thread instead of thread id if possible.
If CMDQ_INVALID_THREAD id is not necessary any more, I will remove it.

> > +       /* flag of IRQ received */
> > +       int                     irq_flag;
> > +       /* callback functions */
> > +       struct cmdq_task_cb     cb;
> > +       /* work item when auto release is used */
> > +       struct work_struct      auto_release_work;
> > +
> > +       unsigned long long      submit; /* submit time */
> > +
> > +       pid_t                   caller_pid;
> > +       char                    caller_name[TASK_COMM_LEN];
> > +};
> > +
> > +struct cmdq_thread {
> > +       u32                     task_count;
> > +       u32                     wait_cookie;
> > +       u32                     next_cookie;
> > +       struct cmdq_task        *cur_task[CMDQ_MAX_TASK_IN_THREAD];
> > +};
> > +
> > +struct cmdq {
> > +       struct device           *dev;
> > +       struct notifier_block   pm_notifier;
> > +
> > +       void __iomem            *base_va;
> > +       unsigned long           base_pa;
> 
> I think we can remove base_pa (it is only used in a debug print), and just call
> "base_va" as "base".

will do

> > +       u32                     irq;
> > +
> > +       /*
> > +        * task information
> > +        * task_cache: struct cmdq_task object cache
> > +        * task_free_list: unused free tasks
> > +        * task_active_list: active tasks
> > +        * task_consume_wait_queue_item: task consumption work item
> > +        * task_auto_release_wq: auto-release workqueue
> > +        * task_consume_wq: task consumption workqueue (for queued tasks)
> > +        */
> > +       struct kmem_cache       *task_cache;
> > +       struct list_head        task_free_list;
> > +       struct list_head        task_active_list;
> > +       struct list_head        task_wait_list;
> > +       struct work_struct      task_consume_wait_queue_item;
> > +       struct workqueue_struct *task_auto_release_wq;
> > +       struct workqueue_struct *task_consume_wq;
> > +       u16                     task_count[CMDQ_MAX_THREAD_COUNT];
> 
> AFAICT, this task_count is not used?

will remove

> > +
> > +       struct cmdq_thread      thread[CMDQ_MAX_THREAD_COUNT];
> > +
> > +       /* mutex, spinlock, flag */
> > +       struct mutex            task_mutex;     /* for task list */
> > +       struct mutex            clock_mutex;    /* for clock operation */
> > +       spinlock_t              thread_lock;    /* for cmdq hardware thread */
> > +       int                     thread_usage;
> > +       spinlock_t              exec_lock;      /* for exec task */
> > +
> > +       /* suspend */
> > +       bool                    suspended;
> > +
> > +       /* command buffer pool */
> > +       struct cmdq_cmd_buf     cmd_buf_pool[CMDQ_CMD_BUF_POOL_BUF_NUM];
> > +
> > +       /*
> > +        * notification
> > +        * wait_queue: for task done
> > +        * thread_dispatch_queue: for thread acquiring
> > +        */
> > +       wait_queue_head_t       wait_queue[CMDQ_MAX_THREAD_COUNT];
> > +       wait_queue_head_t       thread_dispatch_queue;
> > +
> > +       /* ccf */
> > +       struct clk              *clock;
> > +};
> > +
> > +struct cmdq_event_name {
> > +       enum cmdq_event event;
> > +       char            *name;
> 
> const char *

will do

> > +};
> > +
> > +struct cmdq_subsys {
> > +       u32     base_addr;
> > +       int     id;
> > +       char    *grp_name;
> 
> const char *

will do

> > +};
> > +
> > +static const struct cmdq_event_name g_event_name[] = {
> > +       /* Display start of frame(SOF) events */
> > +       {CMDQ_EVENT_DISP_OVL0_SOF, "CMDQ_EVENT_DISP_OVL0_SOF",},
> 
> You can drop the "," inside "}".

will do

> > +       {CMDQ_EVENT_DISP_OVL1_SOF, "CMDQ_EVENT_DISP_OVL1_SOF",},
> > +       {CMDQ_EVENT_DISP_RDMA0_SOF, "CMDQ_EVENT_DISP_RDMA0_SOF",},
> > +       {CMDQ_EVENT_DISP_RDMA1_SOF, "CMDQ_EVENT_DISP_RDMA1_SOF",},
> > +       {CMDQ_EVENT_DISP_RDMA2_SOF, "CMDQ_EVENT_DISP_RDMA2_SOF",},
> > +       {CMDQ_EVENT_DISP_WDMA0_SOF, "CMDQ_EVENT_DISP_WDMA0_SOF",},
> > +       {CMDQ_EVENT_DISP_WDMA1_SOF, "CMDQ_EVENT_DISP_WDMA1_SOF",},
> > +       /* Display end of frame(EOF) events */
> > +       {CMDQ_EVENT_DISP_OVL0_EOF, "CMDQ_EVENT_DISP_OVL0_EOF",},
> > +       {CMDQ_EVENT_DISP_OVL1_EOF, "CMDQ_EVENT_DISP_OVL1_EOF",},
> > +       {CMDQ_EVENT_DISP_RDMA0_EOF, "CMDQ_EVENT_DISP_RDMA0_EOF",},
> > +       {CMDQ_EVENT_DISP_RDMA1_EOF, "CMDQ_EVENT_DISP_RDMA1_EOF",},
> > +       {CMDQ_EVENT_DISP_RDMA2_EOF, "CMDQ_EVENT_DISP_RDMA2_EOF",},
> > +       {CMDQ_EVENT_DISP_WDMA0_EOF, "CMDQ_EVENT_DISP_WDMA0_EOF",},
> > +       {CMDQ_EVENT_DISP_WDMA1_EOF, "CMDQ_EVENT_DISP_WDMA1_EOF",},
> > +       /* Mutex end of frame(EOF) events */
> > +       {CMDQ_EVENT_MUTEX0_STREAM_EOF, "CMDQ_EVENT_MUTEX0_STREAM_EOF",},
> > +       {CMDQ_EVENT_MUTEX1_STREAM_EOF, "CMDQ_EVENT_MUTEX1_STREAM_EOF",},
> > +       {CMDQ_EVENT_MUTEX2_STREAM_EOF, "CMDQ_EVENT_MUTEX2_STREAM_EOF",},
> > +       {CMDQ_EVENT_MUTEX3_STREAM_EOF, "CMDQ_EVENT_MUTEX3_STREAM_EOF",},
> > +       {CMDQ_EVENT_MUTEX4_STREAM_EOF, "CMDQ_EVENT_MUTEX4_STREAM_EOF",},
> > +       /* Display underrun events */
> > +       {CMDQ_EVENT_DISP_RDMA0_UNDERRUN, "CMDQ_EVENT_DISP_RDMA0_UNDERRUN",},
> > +       {CMDQ_EVENT_DISP_RDMA1_UNDERRUN, "CMDQ_EVENT_DISP_RDMA1_UNDERRUN",},
> > +       {CMDQ_EVENT_DISP_RDMA2_UNDERRUN, "CMDQ_EVENT_DISP_RDMA2_UNDERRUN",},
> > +       /* Keep this at the end of HW events */
> > +       {CMDQ_MAX_HW_EVENT_COUNT, "CMDQ_MAX_HW_EVENT_COUNT",},
> > +       /* GPR events */
> 
> What are "GPR" events?

They are events of General Purpose Register of GCE.
I will remove them if driver doesn't need to take care of them.

> > +       {CMDQ_SYNC_TOKEN_GPR_SET_0, "CMDQ_SYNC_TOKEN_GPR_SET_0",},
> > +       {CMDQ_SYNC_TOKEN_GPR_SET_1, "CMDQ_SYNC_TOKEN_GPR_SET_1",},
> > +       {CMDQ_SYNC_TOKEN_GPR_SET_2, "CMDQ_SYNC_TOKEN_GPR_SET_2",},
> > +       {CMDQ_SYNC_TOKEN_GPR_SET_3, "CMDQ_SYNC_TOKEN_GPR_SET_3",},
> > +       {CMDQ_SYNC_TOKEN_GPR_SET_4, "CMDQ_SYNC_TOKEN_GPR_SET_4",},
> > +       /* This is max event and also can be used as mask. */
> > +       {CMDQ_SYNC_TOKEN_MAX, "CMDQ_SYNC_TOKEN_MAX",},
> > +       /* Invalid event */
> > +       {CMDQ_SYNC_TOKEN_INVALID, "CMDQ_SYNC_TOKEN_INVALID",},
> > +};
> > +
> > +static const struct cmdq_subsys g_subsys[] = {
> > +       {0x1400, 1, "MMSYS"},
> > +       {0x1401, 2, "DISP"},
> > +       {0x1402, 3, "DISP"},
> 
> This isn't going to scale.  These addresses could be different on
> different chips.
> Instead of a static table like this, we probably need specify to the
> connection between gce and other devices via devicetree phandles, and
> then use the phandles to lookup the corresponding device address
> range.

I will define them in device tree.
E.g.
cmdq {
  reg_domain = 0x14000000, 0x14010000, 0x14020000
}

> > +};
> > +
> > +static const char *cmdq_event_get_name(enum cmdq_event event)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(g_event_name); i++)
> > +               if (g_event_name[i].event == event)
> > +                       return g_event_name[i].name;
> > +
> > +       return "CMDQ_EVENT_UNKNOWN";
> > +}
> > +
> > +static void cmdq_event_set(void __iomem *gce_base_va, enum cmdq_event event)
> > +{
> > +       writel(CMDQ_SYNC_TOKEN_SET | event,
> > +              gce_base_va + CMDQ_SYNC_TOKEN_UPD_OFFSET);
> > +}
> > +
> 
> For any cmdq helper like this, just pass cmdq, and extract base in the
> helper, eg:
> 
> static void cmdq_event_set(struct cmdq *cmdq, enum cmdq_event event)
> {
> writel(CMDQ_SYNC_TOKEN_SET | event,
> cqctx->base + CMDQ_SYNC_TOKEN_UPD_OFFSET);
> }

will do

> [snip]
> 
> > +
> > +static bool cmdq_scenario_is_prefetch(enum cmdq_scenario scenario)
> > +{
> > +       switch (scenario) {
> > +       case CMDQ_SCENARIO_PRIMARY_DISP:
> > +               /*
> > +                * Primary DISP HW should enable prefetch.
> > +                * Since thread 0/1 shares one prefetch buffer,
> > +                * we allow only PRIMARY path to use prefetch.
> > +                */
> 
> I don't do think we want to hard code this policy in the cmdq driver.
> There are systems that will only use the "sub" display channel, these systems
> should be able to do prefetch for the "SUB" display if it is the only
> one in use.

After discussed with Mediatek display owner,
we think prefetch function can be removed.
If we really need it in the future,
I will add back it and give controllable interfaces.

> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +
> > +       return false;
> > +}
> 
> [snip]
> 
> > +static u64 cmdq_scenario_get_flag(struct cmdq *cqctx,
> > +                                 enum cmdq_scenario scenario)
> > +{
> > +       struct device *dev = cqctx->dev;
> > +       u64 flag;
> > +
> > +       switch (scenario) {
> > +       case CMDQ_SCENARIO_PRIMARY_DISP:
> > +               flag = ((1LL << CMDQ_ENG_DISP_OVL0) |
> > +                       (1LL << CMDQ_ENG_DISP_COLOR0) |
> > +                       (1LL << CMDQ_ENG_DISP_AAL) |
> > +                       (1LL << CMDQ_ENG_DISP_RDMA0) |
> > +                       (1LL << CMDQ_ENG_DISP_UFOE) |
> > +                       (1LL << CMDQ_ENG_DISP_DSI0_CMD));
> > +               break;
> > +       case CMDQ_SCENARIO_SUB_DISP:
> > +               flag = ((1LL << CMDQ_ENG_DISP_OVL1) |
> > +                       (1LL << CMDQ_ENG_DISP_COLOR1) |
> > +                       (1LL << CMDQ_ENG_DISP_GAMMA) |
> > +                       (1LL << CMDQ_ENG_DISP_RDMA1) |
> > +                       (1LL << CMDQ_ENG_DISP_DSI1_CMD));
> > +               break;
> 
> Instead of encoding policy (these arbitrary "scenarios"), perhaps the
> cmdq driver should just provide these flag bits, and the display
> subsystem can use them to build the "flag" parameter itself.
> 
> After all, the exact configuration of mmsys components is somewhat flexible.

I will remove scenario and provide flags for display driver.

> > +       default:
> > +               dev_err(dev, "unknown scenario type %d\n", scenario);
> > +               flag = 0LL;
> > +               break;
> > +       }
> > +
> > +       return flag;
> > +}
> 
> [snip]
> 
> > +static void cmdq_task_release_unlocked(struct cmdq_task *task)
> > +{
> > +       struct cmdq *cqctx = task->cqctx;
> > +
> > +       /* This func should be inside cqctx->task_mutex mutex */
> > +       lockdep_assert_held(&cqctx->task_mutex);
> > +
> > +       task->task_state = TASK_STATE_IDLE;
> > +       task->thread = CMDQ_INVALID_THREAD;
> > +
> > +       cmdq_task_free_command_buffer(task);
> > +
> > +       /* remove from active/waiting list */
> > +       list_del_init(&task->list_entry);
> > +       /* insert into free list. Currently we don't shrink free list. */
> > +       list_add_tail(&task->list_entry, &cqctx->task_free_list);
> 
> list_move_tail()

will do

> > +}
> 
> [snip]
> 
> > +static struct cmdq_task *cmdq_core_acquire_task(struct cmdq_command *cmd_desc,
> > +                                               struct cmdq_task_cb *cb)
> > +{
> > +       struct cmdq *cqctx = cmd_desc->cqctx;
> > +       struct device *dev = cqctx->dev;
> > +       int status;
> > +       struct cmdq_task *task;
> > +
> > +       task = cmdq_core_find_free_task(cqctx);
> > +       if (!task) {
> > +               dev_err(dev, "can't acquire task info\n");
> > +               return NULL;
> > +       }
> > +
> > +       /* initialize field values */
> > +       task->scenario = cmd_desc->scenario;
> > +       task->priority = cmd_desc->priority;
> > +       task->engine_flag = cmd_desc->engine_flag;
> > +       task->task_state = TASK_STATE_WAITING;
> > +       task->reorder = 0;
> > +       task->thread = CMDQ_INVALID_THREAD;
> > +       task->irq_flag = 0x0;
> > +       memcpy(&task->cb, cb, sizeof(*cb));
> 
> task->cb = *cb;

will do

> > +       task->command_size = cmd_desc->block_size;
> > +
> > +       /* store caller info for debug */
> > +       if (current) {
> > +               task->caller_pid = current->pid;
> > +               memcpy(task->caller_name, current->comm, sizeof(current->comm));
> > +       }
> > +
> > +       status = cmdq_core_sync_command(task, cmd_desc);
> > +       if (status < 0) {
> > +               dev_err(dev, "fail to sync command\n");
> > +               cmdq_task_release_internal(task);
> > +               return NULL;
> > +       }
> > +
> > +       /* insert into waiting list to process */
> > +       mutex_lock(&cqctx->task_mutex);
> > +       if (task) {
> > +               struct list_head *in_item = &cqctx->task_wait_list;
> > +               struct cmdq_task *wait_task = NULL;
> > +               struct list_head *p = NULL;
> > +
> > +               task->submit = sched_clock();
> > +
> > +               /*
> > +                * add to waiting list, keep it sorted by priority
> > +                * so that we add high-priority tasks first.
> > +                */
> > +               list_for_each(p, &cqctx->task_wait_list) {
> > +                       wait_task = list_entry(p, struct cmdq_task, list_entry);
> > +                       /*
> > +                        * keep the list sorted.
> > +                        * higher priority tasks are inserted
> > +                        * in front of the queue
> > +                        */
> > +                       if (wait_task->priority < task->priority)
> > +                               break;
> > +
> > +                       in_item = p;
> > +               }
> > +
> > +               list_add(&task->list_entry, in_item);
> > +       }
> > +       mutex_unlock(&cqctx->task_mutex);
> > +
> > +       return task;
> > +}
> > +
> > +static int cmdq_clk_enable(struct cmdq *cqctx)
> > +{
> > +       struct device *dev = cqctx->dev;
> > +       int ret = 0;
> > +
> > +       if (!cqctx->thread_usage) {
> > +               ret = clk_prepare_enable(cqctx->clock);
> > +               if (ret) {
> > +                       dev_err(dev, "prepare and enable clk:%s fail\n",
> > +                               CMDQ_CLK_NAME);
> > +                       return ret;
> > +               }
> > +               cmdq_event_reset(cqctx);
> 
> AFAICT, we only need to reset the device when it power cycles, not
> whenever we re-enable its clock.
> I think cmdq_event_reset() here should really be a pm_runtime resume handler,
> and "cmdq_clk_enable()" should just do a clk_prepare_enable() and
> pm_runtime_get().
> 
> Then you won't need your own custom refcounting (thread_usage).
> You won't need clock_mutex, either.

I will remove it and let display driver to control clear event.

> > +       }
> > +       cqctx->thread_usage++;
> > +
> > +       return ret;
> > +}
> > +
> > +static void cmdq_clk_disable(struct cmdq *cqctx)
> > +{
> > +       cqctx->thread_usage--;
> > +       if (cqctx->thread_usage <= 0)
> > +               clk_disable_unprepare(cqctx->clock);
> > +}
> > +
> > +static int cmdq_core_find_free_thread(struct cmdq *cqctx, u32 scenario)
> > +{
> > +       struct device *dev = cqctx->dev;
> > +       struct cmdq_thread *thread;
> > +       int tid;
> > +       u32 next_cookie;
> > +
> > +       thread = cqctx->thread;
> > +       tid = cmdq_scenario_get_thread(scenario);
> 
> cmdq_core_acquire_thread() and cmdq_scenario_get_thread() should take
> cmdq, and return a struct cmdq_thread * instead of tid.
> 
> On error, they should either return a standard linux error
> (-EBUSY/-EINVAL, etc) as ERR_PTR(), or if fine-grained error detection
> is not required, they can just return NULL.

will do

> > +
> > +       /*
> > +        * Currently, we only support disp,
> > +        * so it's error if tid is CMDQ_INVALID_THREAD.
> > +        */
> > +       if (tid == CMDQ_INVALID_THREAD) {
> > +               dev_err(dev, "got CMDQ_INVALID_THREAD!!!\n");
> > +               return tid;
> > +       }
> > +
> > +       /*
> > +        * make sure the found thread has enough space for the task;
> > +        * cmdq_thread->cur_task has size limitation.
> > +        */
> > +       if (thread[tid].task_count >= CMDQ_MAX_TASK_IN_THREAD)
> > +               tid = CMDQ_INVALID_THREAD;
> > +
> > +       next_cookie = thread[tid].next_cookie % CMDQ_MAX_TASK_IN_THREAD;
> > +       if (thread[tid].cur_task[next_cookie])
> > +               tid = CMDQ_INVALID_THREAD;
> > +
> > +       return tid;
> > +}
> 
> [snip]
> 
> > +static int cmdq_thread_suspend(struct cmdq *cqctx, int tid)
> > +{
> > +       struct device *dev = cqctx->dev;
> > +       void __iomem *gce_base_va = cqctx->base_va;
> > +       u32 enabled;
> > +       u32 status;
> > +
> > +       /* write suspend bit */
> > +       writel(CMDQ_THR_SUSPEND,
> > +              gce_base_va + CMDQ_THR_SUSPEND_TASK_OFFSET +
> > +              CMDQ_THR_SHIFT * tid);
> 
> All of these per-thread register accesses would be cleaner if we just
> they were in helper functions on the struct cmdq_thread *:
> 
> 
> First, when initializing cmdq->thread, save the thread's base:
> 
> thread->base = cmdq->base + cmdq_thread_to_tid(cmdq, thread) * CMDQ_THR_SHIFT;
> 
> Then, use these simple helper functions:
> 
> static void cmdq_thread_writel(struct cmdq_thread *thread, u32 value,
>       unsigned offset)
> {
> writel(value, thread->base + offset);
> }
> 
> static u32 cmdq_thread_readl(struct cmdq_thread *thread, unsigned offset)
> {
> return readl(thread->base + offset);
> }
> 
> cmdq_thread_writel(thread, CMDQ_THR_SUSPEND, CMDQ_THR_SUSPEND_TASK_OFFSET);
> enable = cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK_OFFSET);

will do

> > +
> > +       /* If already disabled, treat as suspended successful. */
> > +       enabled = readl(gce_base_va + CMDQ_THR_ENABLE_TASK_OFFSET +
> > +                       CMDQ_THR_SHIFT * tid);
> > +       if (!(enabled & CMDQ_THR_ENABLED))
> > +               return 0;
> > +
> > +       /* poll suspended status */
> > +       if (readl_poll_timeout_atomic(gce_base_va +
> > +                                     CMDQ_THR_CURR_STATUS_OFFSET +
> > +                                     CMDQ_THR_SHIFT * tid,
> > +                                     status,
> > +                                     status & CMDQ_THR_STATUS_SUSPENDED,
> > +                                     0, 10)) {
> > +               dev_err(dev, "Suspend HW thread %d failed\n", tid);
> > +               return -EFAULT;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> [snip]
> 
> > +static void cmdq_core_parse_error(struct cmdq_task *task, int tid,
> > +                                 const char **module_name, int *flag,
> > +                                 u32 *inst_a, u32 *inst_b)
> 
> Hmm. Instead of back calculating details of the failing task, I think it might
> be more natural to record these details when creating the command

Because CMDQ needs to deal with time critical situation,
we only parse command into human readable log if failed.

>  shouldn't you be
> able to use the task's cookie to look it up on the list of tasks to
> get its details?

We have known task here, so we don't need to get task from cookie.

> > +{
> > +       int irq_flag = task->irq_flag;
> > +       u32 insts[2] = { 0 };
> > +       const char *module;
> > +
> > +       /*
> > +        * other cases, use instruction to judge
> > +        * because scenario / HW flag are not sufficient
> > +        */
> > +       if (cmdq_task_get_pc_and_inst(task, tid, insts)) {
> > +               u32 op, arg_a, arg_b;
> > +
> > +               op = insts[1] >> CMDQ_OP_CODE_SHIFT;
> > +               arg_a = insts[1] & CMDQ_ARG_A_MASK;
> > +               arg_b = insts[0];
> > +
> > +               switch (op) {
> > +               case CMDQ_CODE_WRITE:
> > +                       module = cmdq_core_parse_module_from_subsys(arg_a);
> > +                       break;
> > +               case CMDQ_CODE_WFE:
> > +                       /* arg_a is the event id */
> > +                       module = cmdq_event_get_module((enum cmdq_event)arg_a);
> > +                       break;
> > +               case CMDQ_CODE_MOVE:
> > +               case CMDQ_CODE_JUMP:
> > +               case CMDQ_CODE_EOC:
> > +               default:
> > +                       module = "CMDQ";
> > +                       break;
> > +               }
> > +       } else {
> > +               module = "CMDQ";
> > +       }
> > +
> > +       /* fill output parameter */
> > +       *module_name = module;
> > +       *flag = irq_flag;
> > +       *inst_a = insts[1];
> > +       *inst_b = insts[0];
> > +}
> 
> [snip]
> 
> > +static int cmdq_task_insert_into_thread(struct cmdq_task *last,
> > +                                       struct cmdq_task *task,
> > +                                       int tid, int loop)
> > +{
> > +       struct cmdq *cqctx = task->cqctx;
> > +       struct device *dev = cqctx->dev;
> > +       void __iomem *gce_base_va = cqctx->base_va;
> > +       int status = 0;
> > +       struct cmdq_thread *thread;
> > +       struct cmdq_task *prev_task;
> > +       int index;
> > +       int prev;
> > +       int cookie;
> > +
> > +       thread = &cqctx->thread[tid];
> > +       cookie = thread->next_cookie;
> > +
> > +       /*
> > +        * Traverse forward to adjust tasks' order
> > +        * according to their priorities.
> > +        */
> 
> AFAICT, this driver does not actually use priorities, so this can all
> be simplified.
> If we ever implement priorities, we can add this back, since there
> will then be a way
> to test it.

will remove

> > +       for (prev = (cookie % CMDQ_MAX_TASK_IN_THREAD); loop > 0; loop--) {
> > +               index = prev;
> > +               if (index < 0)
> > +                       index = CMDQ_MAX_TASK_IN_THREAD - 1;
> > +
> > +               prev = index - 1;
> > +               if (prev < 0)
> > +                       prev = CMDQ_MAX_TASK_IN_THREAD - 1;
> > +
> > +               prev_task = thread->cur_task[prev];
> > +
> > +               /* maybe the job is killed, search a new one */
> > +               for (; !prev_task && loop > 1; loop--) {
> > +                       dev_err(dev,
> > +                               "prev_task is NULL, prev:%d, loop:%d, index:%d\n",
> > +                               prev, loop, index);
> > +
> > +                       prev--;
> > +                       if (prev < 0)
> > +                               prev = CMDQ_MAX_TASK_IN_THREAD - 1;
> > +
> > +                       prev_task = thread->cur_task[prev];
> > +               }
> > +
> > +               if (!prev_task) {
> > +                       dev_err(dev,
> > +                               "invalid task state for reorder %d %d\n",
> > +                               index, loop);
> > +                       status = -EFAULT;
> > +                       break;
> > +               }
> > +
> > +               /* insert this task */
> > +               if (loop <= 1) {
> > +                       thread->cur_task[index] = task;
> > +                       /* Jump: Absolute */
> > +                       prev_task->va_base[prev_task->num_cmd - 1] =
> > +                                       CMDQ_JUMP_BY_PA;
> > +                       /* Jump to here */
> > +                       prev_task->va_base[prev_task->num_cmd - 2] =
> > +                                       task->mva_base;
> > +
> > +                       /* re-fetch command buffer again. */
> > +                       cmdq_core_invalidate_hw_fetched_buffer(
> > +                                       gce_base_va, tid);
> > +
> > +                       break;
> > +               }
> > +
> > +               if (prev_task->priority < task->priority) {
> > +                       /* new task has higher priority */
> > +
> > +                       thread->cur_task[index] = prev_task;
> > +                       prev_task->va_base[prev_task->num_cmd - 1] =
> > +                                       task->va_base[task->num_cmd - 1];
> > +                       prev_task->va_base[prev_task->num_cmd - 2] =
> > +                                       task->va_base[task->num_cmd - 2];
> > +
> > +                       /* Boot priority for the task */
> > +                       prev_task->priority += CMDQ_MIN_AGE_VALUE;
> > +                       prev_task->reorder++;
> > +
> > +                       thread->cur_task[prev] = task;
> > +                       /* Jump: Absolute */
> > +                       task->va_base[task->num_cmd - 1] = CMDQ_JUMP_BY_PA;
> > +                       /* Jump to here */
> > +                       task->va_base[task->num_cmd - 2] = prev_task->mva_base;
> > +
> > +                       /* re-fetch command buffer again. */
> > +                       cmdq_core_invalidate_hw_fetched_buffer(
> > +                                       gce_base_va, tid);
> > +
> > +                       if (last == task)
> > +                               last = prev_task;
> > +               } else {
> > +                       /* previous task has higher priority */
> > +
> > +                       thread->cur_task[index] = task;
> > +                       /* Jump: Absolute */
> > +                       prev_task->va_base[prev_task->num_cmd - 1] =
> > +                                       CMDQ_JUMP_BY_PA;
> > +                       /* Jump to here */
> > +                       prev_task->va_base[prev_task->num_cmd - 2] =
> > +                                       task->mva_base;
> > +
> > +                       /* re-fetch command buffer again. */
> > +                       cmdq_core_invalidate_hw_fetched_buffer(
> > +                                       gce_base_va, tid);
> > +
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return status;
> > +}
> > +
> > +static int cmdq_task_exec_async_impl(struct cmdq_task *task, int tid)
> > +{
> > +       struct cmdq *cqctx = task->cqctx;
> > +       struct device *dev = cqctx->dev;
> > +       void __iomem *gce_base_va = cqctx->base_va;
> > +       int status;
> > +       struct cmdq_thread *thread;
> > +       struct cmdq_task *last_task;
> > +       unsigned long flags;
> > +       int loop;
> > +       int minimum;
> > +       int cookie;
> > +       int thread_prio;
> > +
> > +       status = 0;
> > +       thread = &cqctx->thread[tid];
> > +
> > +       spin_lock_irqsave(&cqctx->exec_lock, flags);
> > +
> > +       /* update task's thread info */
> > +       task->thread = tid;
> > +       task->irq_flag = 0;
> > +       task->task_state = TASK_STATE_BUSY;
> > +
> > +       if (thread->task_count <= 0) {
> > +               bool is_prefetch;
> > +
> > +               if (cmdq_thread_reset(cqctx, tid) < 0) {
> 
> Do we really have to reset with the spin lock held and irqs disabled?
> This could take a while, right?

About exec_lock spinlock, I will rewrite it,
but need more time to make sure the correctness of new method.

> > +                       spin_unlock_irqrestore(&cqctx->exec_lock, flags);
> > +                       return -EFAULT;
> > +               }
> > +
> > +               writel(CMDQ_THR_NO_TIMEOUT,
> > +                      gce_base_va + CMDQ_THR_INST_CYCLES_OFFSET +
> > +                      CMDQ_THR_SHIFT * tid);
> > +
> > +               is_prefetch = cmdq_scenario_is_prefetch(task->scenario);
> > +               if (is_prefetch) {
> > +                       writel(CMDQ_THR_PREFETCH_EN,
> > +                              gce_base_va + CMDQ_THR_PREFETCH_OFFSET +
> > +                              CMDQ_THR_SHIFT * tid);
> > +               }
> > +
> > +               thread_prio = CMDQ_THR_PRIO_DISPLAY_CONFIG;
> > +               writel(task->mva_base,
> > +                      gce_base_va + CMDQ_THR_CURR_ADDR_OFFSET +
> > +                      CMDQ_THR_SHIFT * tid);
> > +               writel(task->mva_base + task->command_size,
> > +                      gce_base_va + CMDQ_THR_END_ADDR_OFFSET +
> > +                      CMDQ_THR_SHIFT * tid);
> > +               writel(thread_prio & CMDQ_THR_PRIORITY_MASK,
> > +                      gce_base_va + CMDQ_THR_CFG_OFFSET +
> > +                      CMDQ_THR_SHIFT * tid);
> > +
> > +               writel(CMDQ_THR_IRQ_EN,
> > +                      gce_base_va + CMDQ_THR_IRQ_ENABLE_OFFSET +
> > +                      CMDQ_THR_SHIFT * tid);
> > +
> > +               minimum = cmdq_thread_get_cookie(gce_base_va, tid);
> > +               cmdq_thread_insert_task_by_cookie(
> > +                               thread, task, (minimum + 1), true);
> > +
> > +               /* verify that we don't corrupt EOC + JUMP pattern */
> > +               cmdq_core_verfiy_task_command_end(task);
> > +
> > +               /* enable HW thread */
> > +               writel(CMDQ_THR_ENABLED,
> > +                      gce_base_va + CMDQ_THR_ENABLE_TASK_OFFSET +
> > +                      CMDQ_THR_SHIFT * tid);
> > +       } else {
> > +               unsigned long curr_pa, end_pa;
> > +
> > +               status = cmdq_thread_suspend(cqctx, tid);
> > +               if (status < 0) {
> > +                       spin_unlock_irqrestore(&cqctx->exec_lock, flags);
> > +                       return status;
> > +               }
> > +
> > +               writel(CMDQ_THR_NO_TIMEOUT,
> > +                      gce_base_va + CMDQ_THR_INST_CYCLES_OFFSET +
> > +                      CMDQ_THR_SHIFT * tid);
> > +
> > +               cookie = thread->next_cookie;
> > +
> > +               /*
> > +                * Boundary case tested: EOC have been executed,
> > +                *                       but JUMP is not executed
> > +                * Thread PC: 0x9edc0dd8, End: 0x9edc0de0,
> > +                * Curr Cookie: 1, Next Cookie: 2
> > +                * PC = END - 8, EOC is executed
> > +                * PC = END - 0, All CMDs are executed
> > +                */
> > +
> > +               curr_pa = (unsigned long)readl(gce_base_va +
> > +                                              CMDQ_THR_CURR_ADDR_OFFSET +
> > +                                              CMDQ_THR_SHIFT * tid);
> > +               end_pa = (unsigned long)readl(gce_base_va +
> > +                                             CMDQ_THR_END_ADDR_OFFSET +
> > +                                             CMDQ_THR_SHIFT * tid);
> > +               if ((curr_pa == end_pa - 8) || (curr_pa == end_pa - 0)) {
> > +                       /* set to task directly */
> > +                       writel(task->mva_base,
> > +                              gce_base_va + CMDQ_THR_CURR_ADDR_OFFSET +
> > +                              CMDQ_THR_SHIFT * tid);
> > +                       writel(task->mva_base + task->command_size,
> > +                              gce_base_va + CMDQ_THR_END_ADDR_OFFSET +
> > +                              CMDQ_THR_SHIFT * tid);
> > +                       thread->cur_task[cookie % CMDQ_MAX_TASK_IN_THREAD] = task;
> > +                       thread->task_count++;
> > +               } else {
> > +                       /* Current task that shuld be processed */
> > +                       minimum = cmdq_thread_get_cookie(gce_base_va, tid) + 1;
> > +                       if (minimum > CMDQ_MAX_COOKIE_VALUE)
> > +                               minimum = 0;
> > +
> > +                       /* Calculate loop count to adjust the tasks' order */
> > +                       if (minimum <= cookie)
> > +                               loop = cookie - minimum;
> > +                       else
> > +                               /* Counter wrapped */
> > +                               loop = (CMDQ_MAX_COOKIE_VALUE - minimum + 1) +
> > +                                      cookie;
> > +
> > +                       if (loop < 0) {
> > +                               dev_err(dev, "reorder fail:\n");
> > +                               dev_err(dev, "  task count=%d\n", loop);
> > +                               dev_err(dev, "  thread=%d\n", tid);
> > +                               dev_err(dev, "  next cookie=%d\n",
> > +                                       thread->next_cookie);
> > +                               dev_err(dev, "  (HW) next cookie=%d\n",
> > +                                       minimum);
> > +                               dev_err(dev, "  task=0x%p\n", task);
> > +
> > +                               spin_unlock_irqrestore(&cqctx->exec_lock,
> > +                                                      flags);
> > +                               return -EFAULT;
> > +                       }
> > +
> > +                       if (loop > CMDQ_MAX_TASK_IN_THREAD)
> > +                               loop %= CMDQ_MAX_TASK_IN_THREAD;
> > +
> > +                       /*
> > +                        * By default, task is the last task,
> > +                        * and insert [cookie % CMDQ_MAX_TASK_IN_THREAD]
> > +                        */
> > +                       last_task = task;       /* Default last task */
> > +
> > +                       status = cmdq_task_insert_into_thread(
> > +                                       last_task, task, tid, loop);
> > +                       if (status < 0) {
> > +                               spin_unlock_irqrestore(
> > +                                               &cqctx->exec_lock, flags);
> > +                               dev_err(dev,
> > +                                       "invalid task state for reorder.\n");
> > +                               return status;
> > +                       }
> > +
> > +                       smp_mb(); /* modify jump before enable thread */
> > +
> > +                       writel(task->mva_base + task->command_size,
> > +                              gce_base_va + CMDQ_THR_END_ADDR_OFFSET +
> > +                              CMDQ_THR_SHIFT * tid);
> > +                       thread->task_count++;
> > +               }
> > +
> > +               thread->next_cookie += 1;
> > +               if (thread->next_cookie > CMDQ_MAX_COOKIE_VALUE)
> > +                       thread->next_cookie = 0;
> > +
> > +               /* verify that we don't corrupt EOC + JUMP pattern */
> > +               cmdq_core_verfiy_task_command_end(task);
> > +
> > +               /* resume HW thread */
> > +               cmdq_thread_resume(cqctx, tid);
> > +       }
> > +
> > +       spin_unlock_irqrestore(&cqctx->exec_lock, flags);
> > +
> > +       return status;
> > +}
> 
> [snip]
> 
> > +static int cmdq_core_resumed_notifier(struct cmdq *cqctx)
> > +{
> > +       /*
> > +        * Note:
> > +        * delay resume timing until process-unfreeze done in order to
> > +        * ensure M4U driver had restore M4U port setting
> > +        */
> > +
> > +       unsigned long flags = 0L;
> > +
> > +       spin_lock_irqsave(&cqctx->thread_lock, flags);
> > +       cqctx->suspended = false;
> > +
> > +       /*
> > +        * during suspending, there may be queued tasks.
> > +        * we should process them if any.
> > +        */
> > +       if (!work_pending(&cqctx->task_consume_wait_queue_item))
> > +               /* we use system global work queue (kernel thread kworker/n) */
> > +               queue_work(cqctx->task_consume_wq,
> > +                          &cqctx->task_consume_wait_queue_item);
> > +
> > +       spin_unlock_irqrestore(&cqctx->thread_lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> > +static int cmdq_task_exec_async_with_retry(struct cmdq_task *task, int tid)
> 
> Why do we want to automatically retry cmds that failed?

will remove

> > +{
> > +       struct device *dev = task->cqctx->dev;
> > +       int retry;
> > +       int status;
> > +
> > +       retry = 0;
> > +       status = -EFAULT;
> > +       do {
> > +               cmdq_core_verfiy_task_command_end(task);
> > +
> > +               status = cmdq_task_exec_async_impl(task, tid);
> > +
> > +               if (status >= 0)
> > +                       break;
> > +
> > +               if ((task->task_state == TASK_STATE_KILLED) ||
> > +                   (task->task_state == TASK_STATE_ERROR)) {
> > +                       dev_err(dev, "cmdq_task_exec_async_impl fail\n");
> > +                       status = -EFAULT;
> > +                       break;
> > +               }
> > +
> > +               retry++;
> > +       } while (retry < CMDQ_MAX_RETRY_COUNT);
> > +
> > +       return status;
> > +}
> > +
> > +static int cmdq_core_get_time_in_ms(unsigned long long start,
> > +                                   unsigned long long end)
> > +{
> > +       unsigned long long _duration = end - start;
> > +
> > +       do_div(_duration, 1000000);
> > +       return (int)_duration;
> > +}
> > +
> > +static void cmdq_core_consume_waiting_list(struct work_struct *work)
> > +{
> > +       struct list_head *p, *n = NULL;
> > +       bool thread_acquired;
> > +       unsigned long long consume_time;
> > +       int waiting_time_ms;
> > +       bool need_log;
> > +       struct cmdq *cqctx;
> > +       struct device *dev;
> > +
> > +       cqctx = container_of(work, struct cmdq,
> > +                            task_consume_wait_queue_item);
> > +       dev = cqctx->dev;
> > +
> > +       /*
> > +        * when we're suspending,
> > +        * do not execute any tasks. delay & hold them.
> > +        */
> > +       if (cqctx->suspended)
> > +               return;
> > +
> > +       consume_time = sched_clock();
> > +
> > +       mutex_lock(&cqctx->task_mutex);
> > +
> > +       thread_acquired = false;
> > +
> > +       /* scan and remove (if executed) waiting tasks */
> > +       list_for_each_safe(p, n, &cqctx->task_wait_list) {
> > +               struct cmdq_task *task;
> > +               struct cmdq_thread *thread = NULL;
> > +               int tid;
> > +               int status;
> > +               enum cmdq_hw_thread_priority thread_prio;
> > +
> > +               task = list_entry(p, struct cmdq_task, list_entry);
> > +
> > +               thread_prio = CMDQ_THR_PRIO_DISPLAY_CONFIG;
> > +
> > +               waiting_time_ms = cmdq_core_get_time_in_ms(
> > +                               task->submit, consume_time);
> > +               need_log = waiting_time_ms >= CMDQ_PREALARM_TIMEOUT_MS;
> > +               /* allocate hw thread */
> > +               tid = cmdq_core_acquire_thread(cqctx, task->scenario);
> > +               if (tid != CMDQ_INVALID_THREAD)
> > +                       thread = &cqctx->thread[tid];
> > +
> > +               if (tid == CMDQ_INVALID_THREAD || !thread) {
> 
> Move computation of consume_time, waiting_time_ms & need_log here, when
> printing a warning message, since this is the only place you need them.
> Also, why bother converting to ms?  Just leave time in unsigned long long.

will remove converting

> BTW, why sched_clock() instead of ktime?

will use ktime

> > +                       /* have to wait, remain in wait list */
> > +                       dev_warn(dev, "acquire thread fail, need to wait\n");
> > +                       if (need_log) /* task wait too long */
> > +                               dev_warn(dev, "waiting:%dms, task:0x%p\n",
> > +                                        waiting_time_ms, task);
> > +                       continue;
> > +               }
> > +
> > +               /* some task is ready to run */
> > +               thread_acquired = true;
> > +
> > +               /*
> > +                * start execution
> > +                * remove from wait list and put into active list
> > +                */
> > +               list_del_init(&task->list_entry);
> > +               list_add_tail(&task->list_entry,
> > +                             &cqctx->task_active_list);
> 
> list_move_tail(&task->list_entry, &cqctx->task_active_list);

will do

> > +
> > +               /* run task on thread */
> > +               status = cmdq_task_exec_async_with_retry(task, tid);
> > +               if (status < 0) {
> > +                       dev_err(dev, "%s fail, release task 0x%p\n",
> > +                               __func__, task);
> > +                       cmdq_task_remove_thread(task);
> > +                       cmdq_task_release_unlocked(task);
> > +                       task = NULL;
> > +               }
> > +       }
> > +
> > +       if (thread_acquired) {
> > +               /*
> > +                * notify some task's sw thread to change their waiting state.
> > +                * (if they have already called cmdq_task_wait_and_release())
> > +                */
> > +               wake_up_all(&cqctx->thread_dispatch_queue);
> > +       }
> > +
> > +       mutex_unlock(&cqctx->task_mutex);
> > +}
> 
> [snip]
> 
> 
> > +static int cmdq_task_wait_result(struct cmdq_task *task, int tid, int wait_q)
> > +{
> > +       struct cmdq *cqctx = task->cqctx;
> > +       struct cmdq_thread *thread = &cqctx->thread[tid];
> > +       int status = 0;
> > +       unsigned long flags;
> > +       struct cmdq_task_error_report error_report = {
> > +               .throw_err = false,
> > +               .module = NULL,
> > +               .inst_a = 0,
> > +               .inst_b = 0,
> > +               .irq_flag = 0,
> > +       };
> 
> This should be sufficient:
>  struct cmdq_task_error_report error_report = { 0 };

will do

> > +
> > +       /*
> > +        * Note that although we disable IRQ, HW continues to execute
> > +        * so it's possible to have pending IRQ
> > +        */
> > +       spin_lock_irqsave(&cqctx->exec_lock, flags);
> > +
> > +       if (task->task_state != TASK_STATE_DONE)
> > +               status = cmdq_task_handle_error_result(
> > +                               task, tid, wait_q, &error_report);
> 
> This error handling does too much with the spin lock held and irqs disabled.

About exec_lock spinlock, I will rewrite it.

> > +
> > +       if (thread->task_count <= 0)
> > +               cmdq_thread_disable(cqctx, tid);
> > +       else
> > +               cmdq_thread_resume(cqctx, tid);
> > +
> > +       spin_unlock_irqrestore(&cqctx->exec_lock, flags);
> > +
> > +       if (error_report.throw_err) {
> > +               u32 op = error_report.inst_a >> CMDQ_OP_CODE_SHIFT;
> > +
> > +               switch (op) {
> > +               case CMDQ_CODE_WFE:
> > +                       dev_err(cqctx->dev,
> > +                               "%s in CMDQ IRQ:0x%02x, INST:(0x%08x, 0x%08x), OP:WAIT EVENT:%s\n",
> > +                               error_report.module, error_report.irq_flag,
> > +                               error_report.inst_a, error_report.inst_b,
> > +                               cmdq_event_get_name(error_report.inst_a &
> > +                                                   CMDQ_ARG_A_MASK));
> > +                       break;
> > +               default:
> > +                       dev_err(cqctx->dev,
> > +                               "%s in CMDQ IRQ:0x%02x, INST:(0x%08x, 0x%08x), OP:%s\n",
> > +                               error_report.module, error_report.irq_flag,
> > +                               error_report.inst_a, error_report.inst_b,
> > +                               cmdq_core_parse_op(op));
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return status;
> > +}
> > +
> > +static int cmdq_task_wait_done(struct cmdq_task *task)
> > +{
> > +       struct cmdq *cqctx = task->cqctx;
> > +       struct device *dev = cqctx->dev;
> > +       int wait_q;
> > +       int tid;
> > +       unsigned long timeout = msecs_to_jiffies(
> > +                       CMDQ_ACQUIRE_THREAD_TIMEOUT_MS);
> > +
> > +       tid = task->thread;
> > +       if (tid == CMDQ_INVALID_THREAD) {
> 
> You don't need this first "if" check.
> Just do the wait_event_timeout() here.
> If tid != CMDQ_INVALID_THREAD, it will return immediately.

will do

> > +               /*
> > +                * wait for acquire thread
> > +                * (this is done by cmdq_core_consume_waiting_list);
> > +                */
> > +               wait_q = wait_event_timeout(
> > +                               cqctx->thread_dispatch_queue,
> > +                               (task->thread != CMDQ_INVALID_THREAD), timeout);
> > +
> > +               if (!wait_q || task->thread == CMDQ_INVALID_THREAD) {
> 
> Why "task->thread == CMDQ_INVALID_THREAD" check here?  It is either
> not needed or racy.

will remove

> > +                       mutex_lock(&cqctx->task_mutex);
> > +
> > +                       /*
> > +                        * it's possible that the task was just consumed now.
> > +                        * so check again.
> > +                        */
> > +                       if (task->thread == CMDQ_INVALID_THREAD) {
> > +                               /*
> > +                                * Task may have released,
> > +                                * or starved to death.
> > +                                */
> > +                               dev_err(dev,
> > +                                       "task(0x%p) timeout with invalid thread\n",
> > +                                       task);
> > +
> > +                               /*
> > +                                * remove from waiting list,
> > +                                * so that it won't be consumed in the future
> > +                                */
> > +                               list_del_init(&task->list_entry);
> > +
> > +                               mutex_unlock(&cqctx->task_mutex);
> > +                               return -EINVAL;
> > +                       }
> > +
> > +                       /* valid thread, so we keep going */
> > +                       mutex_unlock(&cqctx->task_mutex);
> > +               }
> > +       }
> > +
> > +       tid = task->thread;
> > +       if (tid < 0 || tid >= CMDQ_MAX_THREAD_COUNT) {
> > +               dev_err(dev, "invalid thread %d in %s\n", tid, __func__);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* start to wait */
> > +       wait_q = wait_event_timeout(task->cqctx->wait_queue[tid],
> > +                                   (task->task_state != TASK_STATE_BUSY &&
> > +                                    task->task_state != TASK_STATE_WAITING),
> > +                                   msecs_to_jiffies(CMDQ_DEFAULT_TIMEOUT_MS));
> > +       if (!wait_q)
> > +               dev_dbg(dev, "timeout!\n");
> > +
> > +       /* wake up and continue */
> > +       return cmdq_task_wait_result(task, tid, wait_q);
> > +}
> > +
> > +static int cmdq_task_wait_and_release(struct cmdq_task *task)
> > +{
> > +       struct cmdq *cqctx;
> > +       int status;
> > +       int tid;
> > +
> > +       if (!task) {
> > +               pr_err("%s err ptr=0x%p\n", __func__, task);
> > +               return -EFAULT;
> > +       }
> > +
> > +       if (task->task_state == TASK_STATE_IDLE) {
> > +               pr_err("%s task=0x%p is IDLE\n", __func__, task);
> > +               return -EFAULT;
> > +       }
> > +
> > +       cqctx = task->cqctx;
> > +
> > +       /* wait for task finish */
> > +       tid = task->thread;
> 
> tid is not used.

will remove

> > +       status = cmdq_task_wait_done(task);
> > +
> > +       /* release */
> > +       cmdq_task_remove_thread(task);
> > +       cmdq_task_release_internal(task);
> > +
> > +       return status;
> > +}
> > +
> > +static void cmdq_core_auto_release_work(struct work_struct *work_item)
> > +{
> > +       struct cmdq_task *task;
> > +       int status;
> > +       struct cmdq_task_cb cb;
> > +
> > +       task = container_of(work_item, struct cmdq_task, auto_release_work);
> > +       memcpy(&cb, &task->cb, sizeof(cb));
> 
> Just:
>   cb = task->cb;

will do

> But, why do you need to make a copy?
> Can't you just access task->cb directly?

This is because task will be released before cb is called.

> > +       status = cmdq_task_wait_and_release(task);
> > +       task = NULL;
> 
> task is not used again, don't set to NULL.

will do

> > +
> > +       /* isr fail, so call isr_cb here to prevent lock */
> > +       if (status && cb.isr_cb)
> > +               cb.isr_cb(cb.isr_data);
> > +
> > +       if (cb.done_cb)
> > +               cb.done_cb(cb.done_data);
> > +}
> 
> [snip]
> 
> 
> > +static irqreturn_t cmdq_irq_handler(int irq, void *dev)
> > +{
> > +       struct cmdq *cqctx = dev;
> > +       int i;
> > +       u32 irq_status;
> > +       bool handled = false;
> > +
> > +       if (cqctx->irq == irq) {
> > +               irq_status = readl(cqctx->base_va +
> > +                                  CMDQ_CURR_IRQ_STATUS_OFFSET);
> > +               irq_status &= CMDQ_IRQ_MASK;
> > +               for (i = 0;
> > +                    (irq_status != CMDQ_IRQ_MASK) && i < CMDQ_MAX_THREAD_COUNT;
> > +                    i++) {
> > +                       /* STATUS bit set to 0 means IRQ asserted */
> > +                       if (irq_status & BIT(i))
> > +                               continue;
> > +
> > +                       /*
> > +                        * We mark irq_status to 1 to denote finished
> > +                        * processing, and we can early-exit if no more
> > +                        * threads being asserted.
> > +                        */
> > +                       irq_status |= BIT(i);
> > +
> > +                       cmdq_core_handle_irq(cqctx, i);
> > +                       handled = true;
> > +               }
> > +       }
> > +
> > +       if (handled) {
> > +               queue_work(cqctx->task_consume_wq,
> > +                          &cqctx->task_consume_wait_queue_item);
> 
> Since you need to queue work anyway, why no just do this all in a threaded irq
> and use a mutex instead of spinlock for exec_lock.

I will take care of this issue with exec_lock spinlock issue together.

> > +               return IRQ_HANDLED;
> > +       }
> > +
> > +       return IRQ_NONE;
> > +}
> > +
> > +static int cmdq_core_initialize(struct platform_device *pdev,
> > +                               struct cmdq **cqctx)
> > +{
> > +       struct cmdq *lcqctx; /* local cmdq context */
> > +       int i;
> > +       int ret = 0;
> > +
> > +       lcqctx = devm_kzalloc(&pdev->dev, sizeof(*lcqctx), GFP_KERNEL);
> > +
> > +       /* save dev */
> > +       lcqctx->dev = &pdev->dev;
> > +
> > +       /* initial cmdq device related data */
> > +       ret = cmdq_dev_init(pdev, lcqctx);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to init cmdq device\n");
> > +               goto fail_dev;
> > +       }
> > +
> > +       /* initial mutex, spinlock */
> > +       mutex_init(&lcqctx->task_mutex);
> > +       mutex_init(&lcqctx->clock_mutex);
> > +       spin_lock_init(&lcqctx->thread_lock);
> > +       spin_lock_init(&lcqctx->exec_lock);
> > +
> > +       /* initial wait queue for notification */
> > +       for (i = 0; i < ARRAY_SIZE(lcqctx->wait_queue); i++)
> > +               init_waitqueue_head(&lcqctx->wait_queue[i]);
> > +       init_waitqueue_head(&lcqctx->thread_dispatch_queue);
> > +
> > +       /* create task pool */
> > +       lcqctx->task_cache = kmem_cache_create(
> > +                       CMDQ_DRIVER_DEVICE_NAME "_task",
> > +                       sizeof(struct cmdq_task),
> > +                       __alignof__(struct cmdq_task),
> > +                       SLAB_POISON | SLAB_HWCACHE_ALIGN | SLAB_RED_ZONE,
> > +                       &cmdq_task_ctor);
> > +
> > +       /* initialize task lists */
> > +       INIT_LIST_HEAD(&lcqctx->task_free_list);
> > +       INIT_LIST_HEAD(&lcqctx->task_active_list);
> > +       INIT_LIST_HEAD(&lcqctx->task_wait_list);
> > +       INIT_WORK(&lcqctx->task_consume_wait_queue_item,
> > +                 cmdq_core_consume_waiting_list);
> > +
> > +       /* initialize command buffer pool */
> > +       ret = cmdq_cmd_buf_pool_init(lcqctx);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to init command buffer pool\n");
> > +               goto fail_cmd_buf_pool;
> > +       }
> > +
> > +       lcqctx->task_auto_release_wq = alloc_ordered_workqueue(
> > +                       "%s", WQ_MEM_RECLAIM | WQ_HIGHPRI, "cmdq_auto_release");
> > +       lcqctx->task_consume_wq = alloc_ordered_workqueue(
> > +                       "%s", WQ_MEM_RECLAIM | WQ_HIGHPRI, "cmdq_task");
> > +
> > +       *cqctx = lcqctx;
> > +       return ret;
> > +
> > +fail_cmd_buf_pool:
> > +       destroy_workqueue(lcqctx->task_auto_release_wq);
> > +       destroy_workqueue(lcqctx->task_consume_wq);
> > +       kmem_cache_destroy(lcqctx->task_cache);
> > +
> > +fail_dev:
> > +       return ret;
> > +}
> > +
> > +static int cmdq_rec_realloc_cmd_buffer(struct cmdq_rec *handle, u32 size)
> > +{
> > +       void *new_buf;
> > +
> > +       new_buf = krealloc(handle->buf_ptr, size, GFP_KERNEL | __GFP_ZERO);
> > +       if (!new_buf)
> > +               return -ENOMEM;
> > +       handle->buf_ptr = new_buf;
> > +       handle->buf_size = size;
> > +       return 0;
> > +}
> > +
> > +static struct cmdq *cmdq_rec_get_valid_ctx(struct cmdq_rec *handle)
> > +{
> 
> Make the caller for all cmdq_rec() APIs pass in struct cmdq *, also, and get rid
> of all of this NULL checking.

We may have multiple cmdq_rec, but only one cmdq.
If we use cmdq as parameter, we still need to pass an ID or index to
identify current used cmdq_rec.
Furthermore, we need to maintain an array or list in cmdq.
So, I think use cmdq_rec is a better way for interface.

I will remove all of this NULL checking.

> > +       if (!handle) {
> > +               WARN_ON(1);
> > +               return NULL;
> > +       }
> > +
> > +       WARN_ON(!handle->cqctx);
> > +       return handle->cqctx;
> > +}
> > +
> > +static int cmdq_rec_stop_running_task(struct cmdq_rec *handle)
> > +{
> > +       int status;
> > +
> > +       status = cmdq_core_release_task(handle->running_task_ptr);
> > +       handle->running_task_ptr = NULL;
> > +       return status;
> > +}
> > +
> > +int cmdq_rec_create(struct platform_device *pdev,
> 
> Use struct device *, not struct platform_device *.

will do

> Although, I think it would be better if this API was:
> 
> struct cmdq_rec *cmdq_rec_create(struct cmdq *cmdq, enum cmdq_scenario scenario)

Please see previous explanation.

> > +                   enum cmdq_scenario scenario,
> > +                   struct cmdq_rec **handle_ptr)
> > +{
> > +       struct cmdq *cqctx;
> > +       struct device *dev = &pdev->dev;
> > +       struct cmdq_rec *handle;
> > +       int ret;
> > +
> > +       cqctx = platform_get_drvdata(pdev);
> > +       if (!cqctx) {
> > +               dev_err(dev, "cmdq context is NULL\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (scenario < 0 || scenario >= CMDQ_MAX_SCENARIO_COUNT) {
> > +               dev_err(dev, "unknown scenario type %d\n", scenario);
> > +               return -EINVAL;
> > +       }
> > +
> > +       handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > +       if (!handle)
> > +               return -ENOMEM;
> > +
> > +       handle->cqctx = platform_get_drvdata(pdev);
> > +       handle->scenario = scenario;
> > +       handle->engine_flag = cmdq_scenario_get_flag(cqctx, scenario);
> > +       handle->priority = CMDQ_THR_PRIO_NORMAL;
> > +
> > +       ret = cmdq_rec_realloc_cmd_buffer(handle, CMDQ_INITIAL_CMD_BLOCK_SIZE);
> > +       if (ret) {
> > +               kfree(handle);
> > +               return ret;
> > +       }
> > +
> > +       *handle_ptr = handle;
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_rec_create);
> 
> [snip]
> 
> > +static int cmdq_suspend(struct device *dev)
> > +{
> > +       struct cmdq *cqctx;
> > +       void __iomem *gce_base_va;
> > +       unsigned long flags = 0L;
> > +       u32 exec_threads;
> > +       int ref_count;
> > +       bool kill_tasks = false;
> > +       struct cmdq_task *task;
> > +       struct list_head *p;
> > +       int i;
> > +
> > +       cqctx = dev_get_drvdata(dev);
> > +       gce_base_va = cqctx->base_va;
> > +       exec_threads = readl(gce_base_va + CMDQ_CURR_LOADED_THR_OFFSET);
> > +       ref_count = cqctx->thread_usage;
> > +
> > +       if ((ref_count > 0) || (exec_threads & CMDQ_THR_EXECUTING)) {
> > +               dev_err(dev,
> > +                       "[SUSPEND] other running, kill tasks. threads:0x%08x, ref:%d\n",
> > +                       exec_threads, ref_count);
> > +               kill_tasks = true;
> > +       }
> > +
> > +       /*
> > +        * We need to ensure the system is ready to suspend,
> > +        * so kill all running CMDQ tasks
> > +        * and release HW engines.
> > +        */
> > +       if (kill_tasks) {
> > +               /* remove all active task from thread */
> > +               dev_err(dev, "[SUSPEND] remove all active tasks\n");
> > +               list_for_each(p, &cqctx->task_active_list) {
> > +                       task = list_entry(p, struct cmdq_task, list_entry);
> > +                       if (task->thread != CMDQ_INVALID_THREAD) {
> > +                               spin_lock_irqsave(&cqctx->exec_lock, flags);
> > +                               cmdq_thread_force_remove_task(
> > +                                               task, task->thread);
> > +                               task->task_state = TASK_STATE_KILLED;
> > +                               spin_unlock_irqrestore(
> > +                                               &cqctx->exec_lock, flags);
> > +
> > +                               /*
> > +                                * release all thread and
> > +                                * mark all active tasks as "KILLED"
> > +                                * (so that thread won't release again)
> > +                                */
> > +                               dev_err(dev,
> > +                                       "[SUSPEND] release all threads and HW clocks\n");
> > +                               cmdq_task_remove_thread(task);
> > +                       }
> > +               }
> > +
> > +               /* disable all HW thread */
> > +               dev_err(dev, "[SUSPEND] disable all HW threads\n");
> > +               for (i = 0; i < CMDQ_MAX_THREAD_COUNT; i++)
> > +                       cmdq_thread_disable(cqctx, i);
> > +
> > +               /* reset all cmdq_thread */
> > +               memset(&cqctx->thread[0], 0, sizeof(cqctx->thread));
> 
> This is actually confusing, because this actually sets the tids to 0,
> which is a valid thread.  Do you really want this?:
> 
> memset(cqctx->thread, -1, sizeof(cqctx->thread));
> 
> Which would all the threads to CMDQ_INVALID_THREAD ?

This is cmdq_thread but thread ID.
I will align to use cmdq_thread to prevent confusing.

> > +       }
> > +
> > +       spin_lock_irqsave(&cqctx->thread_lock, flags);
> > +       cqctx->suspended = true;
> > +       spin_unlock_irqrestore(&cqctx->thread_lock, flags);
> > +
> > +       /* ALWAYS allow suspend */
> > +       return 0;
> > +}
> 
> [snip]
> 
> > diff --git a/include/soc/mediatek/cmdq.h b/include/soc/mediatek/cmdq.h
> > new file mode 100644
> > index 0000000..2ec349f
> > --- /dev/null
> > +++ b/include/soc/mediatek/cmdq.h
> > @@ -0,0 +1,225 @@
> > +/*
> > + * Copyright (c) 2015 MediaTek Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __MTK_CMDQ_H__
> > +#define __MTK_CMDQ_H__
> > +
> > +#include <linux/platform_device.h>
> > +#include <linux/types.h>
> > +
> > +enum cmdq_scenario {
> > +       CMDQ_SCENARIO_PRIMARY_DISP,
> > +       CMDQ_SCENARIO_SUB_DISP,
> > +       CMDQ_MAX_SCENARIO_COUNT
> > +};
> > +
> > +enum cmdq_hw_thread_priority {
> > +       CMDQ_THR_PRIO_NORMAL = 0, /* nomral (low) priority */
> > +       CMDQ_THR_PRIO_DISPLAY_CONFIG = 3, /* display config (high) priority */
> > +       CMDQ_THR_PRIO_MAX = 7, /* maximum possible priority */
> > +};
> 
> We only ever use CMDQ_THR_PRIO_DISPLAY_CONFIG.
> I suggest you add support for priorities later in a follow-up patch when/if they
> are useful.

will remove

> > +
> > +/* events for CMDQ and display */
> > +enum cmdq_event {
> > +       /* Display start of frame(SOF) events */
> > +       CMDQ_EVENT_DISP_OVL0_SOF = 11,
> > +       CMDQ_EVENT_DISP_OVL1_SOF = 12,
> > +       CMDQ_EVENT_DISP_RDMA0_SOF = 13,
> > +       CMDQ_EVENT_DISP_RDMA1_SOF = 14,
> > +       CMDQ_EVENT_DISP_RDMA2_SOF = 15,
> > +       CMDQ_EVENT_DISP_WDMA0_SOF = 16,
> > +       CMDQ_EVENT_DISP_WDMA1_SOF = 17,
> > +       /* Display end of frame(EOF) events */
> > +       CMDQ_EVENT_DISP_OVL0_EOF = 39,
> > +       CMDQ_EVENT_DISP_OVL1_EOF = 40,
> > +       CMDQ_EVENT_DISP_RDMA0_EOF = 41,
> > +       CMDQ_EVENT_DISP_RDMA1_EOF = 42,
> > +       CMDQ_EVENT_DISP_RDMA2_EOF = 43,
> > +       CMDQ_EVENT_DISP_WDMA0_EOF = 44,
> > +       CMDQ_EVENT_DISP_WDMA1_EOF = 45,
> > +       /* Mutex end of frame(EOF) events */
> > +       CMDQ_EVENT_MUTEX0_STREAM_EOF = 53,
> > +       CMDQ_EVENT_MUTEX1_STREAM_EOF = 54,
> > +       CMDQ_EVENT_MUTEX2_STREAM_EOF = 55,
> > +       CMDQ_EVENT_MUTEX3_STREAM_EOF = 56,
> > +       CMDQ_EVENT_MUTEX4_STREAM_EOF = 57,
> > +       /* Display underrun events */
> > +       CMDQ_EVENT_DISP_RDMA0_UNDERRUN = 63,
> > +       CMDQ_EVENT_DISP_RDMA1_UNDERRUN = 64,
> > +       CMDQ_EVENT_DISP_RDMA2_UNDERRUN = 65,
> > +       /* Keep this at the end of HW events */
> > +       CMDQ_MAX_HW_EVENT_COUNT = 260,
> > +       /* GPR events */
> > +       CMDQ_SYNC_TOKEN_GPR_SET_0 = 400,
> > +       CMDQ_SYNC_TOKEN_GPR_SET_1 = 401,
> > +       CMDQ_SYNC_TOKEN_GPR_SET_2 = 402,
> > +       CMDQ_SYNC_TOKEN_GPR_SET_3 = 403,
> > +       CMDQ_SYNC_TOKEN_GPR_SET_4 = 404,
> > +       /* This is max event and also can be used as mask. */
> > +       CMDQ_SYNC_TOKEN_MAX = (0x1ff),
> > +       /* Invalid event */
> > +       CMDQ_SYNC_TOKEN_INVALID = (-1),
> > +};
> > +
> > +/* called after isr done or task done */
> > +typedef int (*cmdq_async_flush_cb)(void *data);
> > +
> > +struct cmdq_task;
> > +struct cmdq;
> > +
> > +struct cmdq_rec {
> > +       struct cmdq             *cqctx;
> > +       u64                     engine_flag;
> > +       int                     scenario;
> > +       u32                     block_size; /* command size */
> > +       void                    *buf_ptr;
> > +       u32                     buf_size;
> > +       /* running task after flush */
> > +       struct cmdq_task        *running_task_ptr;
> > +       /*
> > +        * HW thread priority
> > +        * high priority implies prefetch
> > +        */
> > +       enum cmdq_hw_thread_priority    priority;
> > +       bool                    finalized;
> > +       u32                     prefetch_count;
> > +};
> > +
> > +/**
> > + * cmdq_rec_create() - create command queue recorder handle
> 
> For all of these comments, I think you mean "command queue record",
> not recorder.

will rename to "record"

> Thanks,
> -Dan

Thanks,
HS Liao
