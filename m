From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 29 Jan 2016 16:42:59 +0800
Subject: [RFC 3/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1454053150.32413.52.camel@mtksdaap41>
References: <1453266881-16849-1-git-send-email-hs.liao@mediatek.com>
 <1453266881-16849-4-git-send-email-hs.liao@mediatek.com>
 <CAGS+omBjD1pXKY_6bFbiGxa5bttvqg5zEvKevzSfoiMOy7ys6Q@mail.gmail.com>
 <1454053150.32413.52.camel@mtksdaap41>
Message-ID: <CAGS+omBrEE21Xxh8hjcf32qfHJE0jJYvxGP6L1ihS6jcNbLvLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 3:39 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
> Hi Dan,
>
> Many thanks for your comments and time.
> I reply my plan inline.
>
>
> On Thu, 2016-01-28 at 12:49 +0800, Daniel Kurtz wrote:
>> Hi HS,
>>
>> Sorry for the delay.  It is hard to find time to review a >3700 line
>> driver :-o in detail....
>>
>> Some review comments inline, although I still do not completely
>> understand how all that this driver does and how it works.
>> I'll try to find time to go through this driver in detail again next
>> time you post it for review.
>>
>> On Tue, Jan 19, 2016 at 9:14 PM,  <hs.liao@mediatek.com> wrote:
>> > From: HS Liao <hs.liao@mediatek.com>
>> >
>> > This patch is first version of Mediatek Command Queue(CMDQ) driver. The
>> > CMDQ is used to help read/write registers with critical time limitation,
>> > such as updating display configuration during the vblank. It controls
>> > Global Command Engine (GCE) hardware to achieve this requirement.
>> > Currently, CMDQ only supports display related hardwares, but we expect
>> > it can be extended to other hardwares for future requirements.
>> >
>> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
>>
>> [snip]
>>
>> > diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
>> > new file mode 100644
>> > index 0000000..7570f00
>> > --- /dev/null
>> > +++ b/drivers/soc/mediatek/mtk-cmdq.c
>>
>> [snip]
>>
>> > +/*
>> > + * Maximum prefetch buffer size.
>> > + * Unit is instructions.
>> > + */
>> > +#define CMDQ_MAX_PREFETCH_INSTUCTION   240
>>
>> INSTRUCTION
>
> will fix
>
>> [snip]
>>
>> > +
>> > +/* get lsb for subsys encoding in arg_a (range: 0 - 31) */
>> > +
>> > +enum cmdq_eng {
>> > +       CMDQ_ENG_DISP_UFOE = 0,
>> > +       CMDQ_ENG_DISP_AAL,
>> > +       CMDQ_ENG_DISP_COLOR0,
>> > +       CMDQ_ENG_DISP_COLOR1,
>> > +       CMDQ_ENG_DISP_RDMA0,
>> > +       CMDQ_ENG_DISP_RDMA1,
>> > +       CMDQ_ENG_DISP_RDMA2,
>> > +       CMDQ_ENG_DISP_WDMA0,
>> > +       CMDQ_ENG_DISP_WDMA1,
>> > +       CMDQ_ENG_DISP_OVL0,
>> > +       CMDQ_ENG_DISP_OVL1,
>> > +       CMDQ_ENG_DISP_GAMMA,
>> > +       CMDQ_ENG_DISP_DSI0_CMD,
>> > +       CMDQ_ENG_DISP_DSI1_CMD,
>>
>> Why do these last two have "_CMD" at the end?
>
> will remove
>
>> > +       CMDQ_MAX_ENGINE_COUNT   /* ALWAYS keep at the end */
>> > +};
>> > +
>> > +struct cmdq_command {
>> > +       struct cmdq             *cqctx;
>> > +       u32                     scenario;
>> > +       /* task priority (NOT HW thread priority) */
>> > +       u32                     priority;
>> > +       /* bit flag of used engines */
>> > +       u64                     engine_flag;
>> > +       /*
>> > +        * pointer of instruction buffer
>> > +        * This must point to an 64-bit aligned u32 array
>> > +        */
>> > +       u32                     *va_base;
>>
>> All of your "va" and "va_base" should be void *, not u32 *.
>
> will do
>
>> > +       /* size of instruction buffer, in bytes. */
>> > +       u32                     block_size;
>>
>> Better to use size_t for "size in bytes".
>
> will fix
>
>> > +};
>> > +
>> > +enum cmdq_code {
>> > +       /* These are actual HW op code. */
>> > +       CMDQ_CODE_MOVE = 0x02,
>> > +       CMDQ_CODE_WRITE = 0x04,
>> > +       CMDQ_CODE_JUMP = 0x10,
>> > +       CMDQ_CODE_WFE = 0x20,   /* wait for event (and clear) */
>> > +       CMDQ_CODE_CLEAR_EVENT = 0x21,   /* clear event */
>> > +       CMDQ_CODE_EOC = 0x40,   /* end of command */
>> > +};
>> > +
>> > +enum cmdq_task_state {
>> > +       TASK_STATE_IDLE,        /* free task */
>> > +       TASK_STATE_BUSY,        /* task running on a thread */
>> > +       TASK_STATE_KILLED,      /* task process being killed */
>> > +       TASK_STATE_ERROR,       /* task execution error */
>> > +       TASK_STATE_DONE,        /* task finished */
>> > +       TASK_STATE_WAITING,     /* allocated but waiting for available thread */
>> > +};
>> > +
>> > +struct cmdq_cmd_buf {
>> > +       atomic_t                used;
>> > +       void                    *va;
>> > +       dma_addr_t              pa;
>> > +};
>> > +
>> > +struct cmdq_task_cb {
>> > +       /* called by isr */
>> > +       cmdq_async_flush_cb     isr_cb;
>> > +       void                    *isr_data;
>> > +       /* called by releasing task */
>> > +       cmdq_async_flush_cb     done_cb;
>> > +       void                    *done_data;
>> > +};
>> > +
>> > +struct cmdq_task {
>> > +       struct cmdq             *cqctx;
>> > +       struct list_head        list_entry;
>> > +
>> > +       /* state for task life cycle */
>> > +       enum cmdq_task_state    task_state;
>> > +       /* virtual address of command buffer */
>> > +       u32                     *va_base;
>> > +       /* physical address of command buffer */
>> > +       dma_addr_t              mva_base;
>> > +       /* size of allocated command buffer */
>> > +       u32                     buf_size;
>>
>> size_t
>
> will fix
>
>> > +       /* It points to a cmdq_cmd_buf if this task use command buffer pool. */
>> > +       struct cmdq_cmd_buf     *cmd_buf;
>> > +
>> > +       int                     scenario;
>> > +       int                     priority;
>> > +       u64                     engine_flag;
>> > +       u32                     command_size;
>> > +       u32                     num_cmd;
>> > +       int                     reorder;
>> > +       /* HW thread ID; CMDQ_INVALID_THREAD if not running */
>> > +       int                     thread;
>>
>> I think this driver will be a lot more clear if you do this:
>>
>> struct cmdq_thread *thread;
>>
>> And then use "NULL" for "invalid thread" instead of CMDQ_INVALID_THREAD.
>
> I will try to use cmdq_thread instead of thread id if possible.
> If CMDQ_INVALID_THREAD id is not necessary any more, I will remove it.
>
>> > +       /* flag of IRQ received */
>> > +       int                     irq_flag;
>> > +       /* callback functions */
>> > +       struct cmdq_task_cb     cb;
>> > +       /* work item when auto release is used */
>> > +       struct work_struct      auto_release_work;
>> > +
>> > +       unsigned long long      submit; /* submit time */
>> > +
>> > +       pid_t                   caller_pid;
>> > +       char                    caller_name[TASK_COMM_LEN];
>> > +};
>> > +
>> > +struct cmdq_thread {
>> > +       u32                     task_count;
>> > +       u32                     wait_cookie;
>> > +       u32                     next_cookie;
>> > +       struct cmdq_task        *cur_task[CMDQ_MAX_TASK_IN_THREAD];
>> > +};
>> > +
>> > +struct cmdq {
>> > +       struct device           *dev;
>> > +       struct notifier_block   pm_notifier;
>> > +
>> > +       void __iomem            *base_va;
>> > +       unsigned long           base_pa;
>>
>> I think we can remove base_pa (it is only used in a debug print), and just call
>> "base_va" as "base".
>
> will do
>
>> > +       u32                     irq;
>> > +
>> > +       /*
>> > +        * task information
>> > +        * task_cache: struct cmdq_task object cache
>> > +        * task_free_list: unused free tasks
>> > +        * task_active_list: active tasks
>> > +        * task_consume_wait_queue_item: task consumption work item
>> > +        * task_auto_release_wq: auto-release workqueue
>> > +        * task_consume_wq: task consumption workqueue (for queued tasks)
>> > +        */
>> > +       struct kmem_cache       *task_cache;
>> > +       struct list_head        task_free_list;
>> > +       struct list_head        task_active_list;
>> > +       struct list_head        task_wait_list;
>> > +       struct work_struct      task_consume_wait_queue_item;
>> > +       struct workqueue_struct *task_auto_release_wq;
>> > +       struct workqueue_struct *task_consume_wq;
>> > +       u16                     task_count[CMDQ_MAX_THREAD_COUNT];
>>
>> AFAICT, this task_count is not used?
>
> will remove
>
>> > +
>> > +       struct cmdq_thread      thread[CMDQ_MAX_THREAD_COUNT];
>> > +
>> > +       /* mutex, spinlock, flag */
>> > +       struct mutex            task_mutex;     /* for task list */
>> > +       struct mutex            clock_mutex;    /* for clock operation */
>> > +       spinlock_t              thread_lock;    /* for cmdq hardware thread */
>> > +       int                     thread_usage;
>> > +       spinlock_t              exec_lock;      /* for exec task */
>> > +
>> > +       /* suspend */
>> > +       bool                    suspended;
>> > +
>> > +       /* command buffer pool */
>> > +       struct cmdq_cmd_buf     cmd_buf_pool[CMDQ_CMD_BUF_POOL_BUF_NUM];
>> > +
>> > +       /*
>> > +        * notification
>> > +        * wait_queue: for task done
>> > +        * thread_dispatch_queue: for thread acquiring
>> > +        */
>> > +       wait_queue_head_t       wait_queue[CMDQ_MAX_THREAD_COUNT];
>> > +       wait_queue_head_t       thread_dispatch_queue;
>> > +
>> > +       /* ccf */
>> > +       struct clk              *clock;
>> > +};
>> > +
>> > +struct cmdq_event_name {
>> > +       enum cmdq_event event;
>> > +       char            *name;
>>
>> const char *
>
> will do
>
>> > +};
>> > +
>> > +struct cmdq_subsys {
>> > +       u32     base_addr;
>> > +       int     id;
>> > +       char    *grp_name;
>>
>> const char *
>
> will do
>
>> > +};
>> > +
>> > +static const struct cmdq_event_name g_event_name[] = {
>> > +       /* Display start of frame(SOF) events */
>> > +       {CMDQ_EVENT_DISP_OVL0_SOF, "CMDQ_EVENT_DISP_OVL0_SOF",},
>>
>> You can drop the "," inside "}".
>
> will do
>
>> > +       {CMDQ_EVENT_DISP_OVL1_SOF, "CMDQ_EVENT_DISP_OVL1_SOF",},
>> > +       {CMDQ_EVENT_DISP_RDMA0_SOF, "CMDQ_EVENT_DISP_RDMA0_SOF",},
>> > +       {CMDQ_EVENT_DISP_RDMA1_SOF, "CMDQ_EVENT_DISP_RDMA1_SOF",},
>> > +       {CMDQ_EVENT_DISP_RDMA2_SOF, "CMDQ_EVENT_DISP_RDMA2_SOF",},
>> > +       {CMDQ_EVENT_DISP_WDMA0_SOF, "CMDQ_EVENT_DISP_WDMA0_SOF",},
>> > +       {CMDQ_EVENT_DISP_WDMA1_SOF, "CMDQ_EVENT_DISP_WDMA1_SOF",},
>> > +       /* Display end of frame(EOF) events */
>> > +       {CMDQ_EVENT_DISP_OVL0_EOF, "CMDQ_EVENT_DISP_OVL0_EOF",},
>> > +       {CMDQ_EVENT_DISP_OVL1_EOF, "CMDQ_EVENT_DISP_OVL1_EOF",},
>> > +       {CMDQ_EVENT_DISP_RDMA0_EOF, "CMDQ_EVENT_DISP_RDMA0_EOF",},
>> > +       {CMDQ_EVENT_DISP_RDMA1_EOF, "CMDQ_EVENT_DISP_RDMA1_EOF",},
>> > +       {CMDQ_EVENT_DISP_RDMA2_EOF, "CMDQ_EVENT_DISP_RDMA2_EOF",},
>> > +       {CMDQ_EVENT_DISP_WDMA0_EOF, "CMDQ_EVENT_DISP_WDMA0_EOF",},
>> > +       {CMDQ_EVENT_DISP_WDMA1_EOF, "CMDQ_EVENT_DISP_WDMA1_EOF",},
>> > +       /* Mutex end of frame(EOF) events */
>> > +       {CMDQ_EVENT_MUTEX0_STREAM_EOF, "CMDQ_EVENT_MUTEX0_STREAM_EOF",},
>> > +       {CMDQ_EVENT_MUTEX1_STREAM_EOF, "CMDQ_EVENT_MUTEX1_STREAM_EOF",},
>> > +       {CMDQ_EVENT_MUTEX2_STREAM_EOF, "CMDQ_EVENT_MUTEX2_STREAM_EOF",},
>> > +       {CMDQ_EVENT_MUTEX3_STREAM_EOF, "CMDQ_EVENT_MUTEX3_STREAM_EOF",},
>> > +       {CMDQ_EVENT_MUTEX4_STREAM_EOF, "CMDQ_EVENT_MUTEX4_STREAM_EOF",},
>> > +       /* Display underrun events */
>> > +       {CMDQ_EVENT_DISP_RDMA0_UNDERRUN, "CMDQ_EVENT_DISP_RDMA0_UNDERRUN",},
>> > +       {CMDQ_EVENT_DISP_RDMA1_UNDERRUN, "CMDQ_EVENT_DISP_RDMA1_UNDERRUN",},
>> > +       {CMDQ_EVENT_DISP_RDMA2_UNDERRUN, "CMDQ_EVENT_DISP_RDMA2_UNDERRUN",},
>> > +       /* Keep this at the end of HW events */
>> > +       {CMDQ_MAX_HW_EVENT_COUNT, "CMDQ_MAX_HW_EVENT_COUNT",},
>> > +       /* GPR events */
>>
>> What are "GPR" events?
>
> They are events of General Purpose Register of GCE.
> I will remove them if driver doesn't need to take care of them.
>
>> > +       {CMDQ_SYNC_TOKEN_GPR_SET_0, "CMDQ_SYNC_TOKEN_GPR_SET_0",},
>> > +       {CMDQ_SYNC_TOKEN_GPR_SET_1, "CMDQ_SYNC_TOKEN_GPR_SET_1",},
>> > +       {CMDQ_SYNC_TOKEN_GPR_SET_2, "CMDQ_SYNC_TOKEN_GPR_SET_2",},
>> > +       {CMDQ_SYNC_TOKEN_GPR_SET_3, "CMDQ_SYNC_TOKEN_GPR_SET_3",},
>> > +       {CMDQ_SYNC_TOKEN_GPR_SET_4, "CMDQ_SYNC_TOKEN_GPR_SET_4",},
>> > +       /* This is max event and also can be used as mask. */
>> > +       {CMDQ_SYNC_TOKEN_MAX, "CMDQ_SYNC_TOKEN_MAX",},
>> > +       /* Invalid event */
>> > +       {CMDQ_SYNC_TOKEN_INVALID, "CMDQ_SYNC_TOKEN_INVALID",},
>> > +};
>> > +
>> > +static const struct cmdq_subsys g_subsys[] = {
>> > +       {0x1400, 1, "MMSYS"},
>> > +       {0x1401, 2, "DISP"},
>> > +       {0x1402, 3, "DISP"},
>>
>> This isn't going to scale.  These addresses could be different on
>> different chips.
>> Instead of a static table like this, we probably need specify to the
>> connection between gce and other devices via devicetree phandles, and
>> then use the phandles to lookup the corresponding device address
>> range.
>
> I will define them in device tree.
> E.g.
> cmdq {
>   reg_domain = 0x14000000, 0x14010000, 0x14020000
> }

The devicetree should only model hardware relationships, not software
considerations.

Is the hardware constraint here for using gce with various other
hardware blocks?  I think we already model this by only providing a
gce phandle in the device tree nodes for those devices that can use
gce.

Looking at the driver closer, as far as I can tell, the whole subsys
concept is a purely software abstraction, and only used to debug the
CMDQ_CODE_WRITE command.  In fact, AFAICT, everything would work fine
if we just completely removed the 'subsys' concept, and just passed
through the raw address provided by the driver.

So, I recommend just removing 'subsys' completely from the driver -
from this array, and in the masks.

Instead, if there is an error on the write command, just print the
address that fails.  There are other ways to deduce the subsystem from
a physical address.

Thanks,

-Dan
