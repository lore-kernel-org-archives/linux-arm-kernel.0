From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 28 Jun 2018 09:57:39 +0800
Subject: [PATCH v21 2/4] mailbox: mediatek: Add Mediatek CMDQ driver
In-Reply-To: <1530100416.31725.15.camel@mhfsdcap03>
References: <1517383693-25591-1-git-send-email-houlong.wei@mediatek.com>
 <1517383693-25591-3-git-send-email-houlong.wei@mediatek.com>
 <1519185212.8716.32.camel@mtksdaap41>
 <1530100416.31725.15.camel@mhfsdcap03>
Message-ID: <1530151059.6193.27.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Houlong:

On Wed, 2018-06-27 at 19:53 +0800, houlong wei wrote:
> On Wed, 2018-02-21 at 11:53 +0800, CK Hu wrote:
> > Hi, Houlong:
> > 
> > I've one inline comment.
> > 
> > On Wed, 2018-01-31 at 15:28 +0800, houlong.wei at mediatek.com wrote:
> > > From: "hs.liao at mediatek.com" <hs.liao@mediatek.com>
> > > 
> > > This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> > > CMDQ is used to help write registers with critical time limitation,
> > > such as updating display configuration during the vblank. It controls
> > > Global Command Engine (GCE) hardware to achieve this requirement.
> > > Currently, CMDQ only supports display related hardwares, but we expect
> > > it can be extended to other hardwares for future requirements.
> > > 
> > > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > > ---
> > >  drivers/mailbox/Kconfig                  |   10 +
> > >  drivers/mailbox/Makefile                 |    2 +
> > >  drivers/mailbox/mtk-cmdq-mailbox.c       |  594 ++++++++++++++++++++++++++++++
> > >  include/linux/mailbox/mtk-cmdq-mailbox.h |   77 ++++
> > >  4 files changed, 683 insertions(+)
> > >  create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
> > >  create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
> > > 
> > > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > > index ba2f152..43bb26f 100644
> > > --- a/drivers/mailbox/Kconfig
> > > +++ b/drivers/mailbox/Kconfig
> > > @@ -171,4 +171,14 @@ config BCM_FLEXRM_MBOX
> > >  	  Mailbox implementation of the Broadcom FlexRM ring manager,
> > >  	  which provides access to various offload engines on Broadcom
> > >  	  SoCs. Say Y here if you want to use the Broadcom FlexRM.
> > > +

[...]

> > > +
> > > +static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
> > > +{
> > > +	struct cmdq *cmdq;
> > > +	struct cmdq_task *task;
> > > +	unsigned long curr_pa, end_pa;
> > > +
> > > +	cmdq = dev_get_drvdata(thread->chan->mbox->dev);
> > > +
> > > +	/* Client should not flush new tasks if suspended. */
> > > +	WARN_ON(cmdq->suspended);
> > > +
> > > +	task = kzalloc(sizeof(*task), GFP_ATOMIC);
> > > +	task->cmdq = cmdq;
> > > +	INIT_LIST_HEAD(&task->list_entry);
> > > +	task->pa_base = pkt->pa_base;
> > > +	task->thread = thread;
> > > +	task->pkt = pkt;
> > > +
> > > +	if (list_empty(&thread->task_busy_list)) {
> > > +		WARN_ON(clk_enable(cmdq->clock) < 0);
> > > +		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
> > > +
> > > +		writel(task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
> > > +		writel(task->pa_base + pkt->cmd_buf_size,
> > > +		       thread->base + CMDQ_THR_END_ADDR);
> > > +		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
> > > +		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
> > > +
> > > +		mod_timer(&thread->timeout,
> > > +			  jiffies + msecs_to_jiffies(CMDQ_TIMEOUT_MS));
> > > +	} else {
> > > +		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> > > +		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
> > > +		end_pa = readl(thread->base + CMDQ_THR_END_ADDR);
> > > +
> > > +		/*
> > > +		 * Atomic execution should remove the following wfe, i.e. only
> > > +		 * wait event at first task, and prevent to pause when running.
> > > +		 */
> > > +		if (thread->atomic_exec) {
> > > +			/* GCE is executing if command is not WFE */
> > > +			if (!cmdq_thread_is_in_wfe(thread)) {
> > > +				cmdq_thread_resume(thread);
> > > +				cmdq_thread_wait_end(thread, end_pa);
> > > +				WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> > > +				/* set to this task directly */
> > > +				writel(task->pa_base,
> > > +				       thread->base + CMDQ_THR_CURR_ADDR);
> > > +			} else {
> > > +				cmdq_task_insert_into_thread(task);
> > > +				cmdq_task_remove_wfe(task);
> > > +				smp_mb(); /* modify jump before enable thread */
> > > +			}
> > > +		} else {
> > > +			/* check boundary */
> > > +			if (curr_pa == end_pa - CMDQ_INST_SIZE ||
> > > +			    curr_pa == end_pa) {
> > > +				/* set to this task directly */
> > > +				writel(task->pa_base,
> > > +				       thread->base + CMDQ_THR_CURR_ADDR);
> > > +			} else {
> > > +				cmdq_task_insert_into_thread(task);
> > > +				smp_mb(); /* modify jump before enable thread */
> > > +			}
> > > +		}
> > > +		writel(task->pa_base + pkt->cmd_buf_size,
> > > +		       thread->base + CMDQ_THR_END_ADDR);
> > > +		cmdq_thread_resume(thread);
> > > +	}
> > > +	list_move_tail(&task->list_entry, &thread->task_busy_list);
> > 
> > You implement a list to queue command because you need to execute
> > multiple packet in the same vblank period. I've a suggestion that you
> > need not to implement a list. Once cmdq driver receive two packet as
> > below:
> > 
> > Packet 1:
> > (1) clear vblank event
> > (2) wait vblank event
> > (3) write register setting 1
> > (4) no operation
> > 
> > Packet 2:
> > (1) clear vblank event
> > (2) wait vblank event
> > (3) write register setting 2
> > (4) no operation
> > 
> > In your current design, you modify these two packet as:
> > 
> > Packet 1:
> > (1) clear vblank event
> > (2) wait vblank event
> > (3) write register setting 1
> > (4) Jump to packet 2 (modified)
> > 
> > Packet 2:
> > (1) no operation (modified)
> > (2) no operation (modified)
> > (3) write register setting 2
> > (4) no operation
> > 
> > So the register setting 1 and register setting 2 could be executed in
> > the same vblank period.
> > 
> > My suggestion is: when the client want to send packet 2, it 'abort'
> > packet 1 at first. The 'abort' means remove it from channel. In current
> > mailbox interface, mbox_free_channel() is most like abort function, but
> > my abort would keep the channel. So maybe you need to implement a new
> > mailbox interface which could remove packet in the channel. So the step
> > would be:
> > 
> > (1) Client generate packet 1 which include write register setting 1
> > (2) Client send packet 1 to channel A
> > 
> > When client want to send register setting 2,
> > 
> > (3) Client abort channel A
> > (4) Client generate packet 2 which include write register setting 1 & 2
> > (5) Client send packet 2 to channel A
> > 
> > Once you have the abort function, you could use the queue mechanism in
> > mailbox core instead of implementing your own.
> > 
> > For the client which have the atomic requirement, it also need not to
> > implement a list to keep what command have not executed. So the abort
> > interface would make client and controller much simpler.
> > 
> > Regards,
> > CK
> > 
> 
> Hi CK, thanks for you suggestion. Since current mailbox framework has
> no 'abort' function and need add new interface. It may be complicated
> to do this. Could we keep current solution?
> 

I imagine that 'abort' is a simple function. Is my imagination
incorrect? So you would like choose implementing a complicated queue
mechanism in mtk_cmdq driver rather than implementing abort function.
Maybe both are complicated.

I think the more important thing is that do you and maintainer agree to
implement abort function which could reduce mtk-self-queue in mtk_cmdq
driver. If the answer is yes, there could be two patch sequence A and B,
the patch sequence A is

A.1 mtk_cmdq driver with mtk-self-queue.
A.2 mtk display driver use mtk_cmdq without abort function.
A.3 add mailbox abort function
A.4 mtk_cmdq driver support abort function and remove mtk-self-queue.
A.5 mtk display driver use mtk_cmdq with abort function

And the patch sequence B is

B.1 add mailbox abort function
B.2 mtk_cmdq driver with abort function and no mtk-self-queue
B.3 mtk display driver use mtk_cmdq with abort function

Which one do you think is complicated?

So let's back to the more important thing: 'do you agree to implement
abort function which could reduce mtk-self-queue in mtk_cmdq driver?'

Regards,
CK

> > > +}
> > > +

[...]

> 
