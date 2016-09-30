From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Fri, 30 Sep 2016 16:56:18 +0800
Subject: [PATCH v14 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1475204778.13398.28.camel@mtksdaap41>
References: <1473039885-24009-1-git-send-email-hs.liao@mediatek.com>
 <1473039885-24009-3-git-send-email-hs.liao@mediatek.com>
 <1475204778.13398.28.camel@mtksdaap41>
Message-ID: <1475225778.25044.35.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi CK,

Please see my inline reply.

On Fri, 2016-09-30 at 11:06 +0800, CK Hu wrote:
> Hi, HS:
> 
> On Mon, 2016-09-05 at 09:44 +0800, HS Liao wrote:
> > This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> > CMDQ is used to help write registers with critical time limitation,
> > such as updating display configuration during the vblank. It controls
> > Global Command Engine (GCE) hardware to achieve this requirement.
> > Currently, CMDQ only supports display related hardwares, but we expect
> > it can be extended to other hardwares for future requirements.
> > 
> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > ---
> 
> [snip...]
> 
> > +
> > +struct cmdq_task {
> > +	struct cmdq		*cmdq;
> > +	struct list_head	list_entry;
> > +	void			*va_base;
> > +	dma_addr_t		pa_base;
> > +	size_t			cmd_buf_size; /* command occupied size */
> > +	size_t			buf_size; /* real buffer size */
> > +	bool			finalized;
> > +	struct cmdq_thread	*thread;
> 
> I think thread info could be removed from cmdq_task. Only
> cmdq_task_handle_error() and cmdq_task_insert_into_thread() use
> task->thread and caller of both function has the thread info. So you
> could just pass thread info into these two function and remove thread
> info in cmdq_task.

This modification will remove 1 pointer but add 2 pointers. Moreover,
more pointers will need to be delivered between functions for future
extension. IMHO, it would be better to keep thread pointer inside
cmdq_task.

> > +	struct cmdq_task_cb	cb;
> 
> I think this callback function is equal to mailbox client tx_done
> callback. It's better to use already-defined interface rather than
> creating your own.

This is because CMDQ driver allows different callback functions for
different tasks, but mailbox only allows one callback function per
channel. But, I think I can add a wrapper for tx_done to call CMDQ
callback functions. So, I will use tx_done in CMDQ v15.

> > +};
> > +
> 
> [snip...]
> 
> > +
> > +static int cmdq_suspend(struct device *dev)
> > +{
> > +	struct cmdq *cmdq = dev_get_drvdata(dev);
> > +	struct cmdq_thread *thread;
> > +	int i;
> > +	bool task_running = false;
> > +
> > +	mutex_lock(&cmdq->task_mutex);
> > +	cmdq->suspended = true;
> > +	mutex_unlock(&cmdq->task_mutex);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
> > +		thread = &cmdq->thread[i];
> > +		if (!list_empty(&thread->task_busy_list)) {
> > +			mod_timer(&thread->timeout, jiffies + 1);
> > +			task_running = true;
> > +		}
> > +	}
> > +
> > +	if (task_running) {
> > +		dev_warn(dev, "exist running task(s) in suspend\n");
> > +		msleep(20);
> 
> Why sleep here? It looks like a recovery but could 20ms recovery
> something? I think warning message is enough because you see the warning
> message, and you fix the bug, so no need to recovery anything.

My purpose is context switch to finish timer's work.
I will replace it by schedule().

> > +	}
> > +
> > +	clk_unprepare(cmdq->clock);
> > +	return 0;
> > +}
> > +
> 
> Regards,
> CK

Thanks,
HS
