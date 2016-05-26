From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 26 May 2016 15:28:28 +0800
Subject: [PATCH v7 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1464092829.19894.16.camel@mtksdaap41>
References: <1464006190-344-1-git-send-email-hs.liao@mediatek.com>
 <1464006190-344-3-git-send-email-hs.liao@mediatek.com>
 <1464059159.7425.6.camel@mtksdaap41> <1464092829.19894.16.camel@mtksdaap41>
Message-ID: <1464247708.13536.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, HS:

Replay inline.

On Tue, 2016-05-24 at 20:27 +0800, Horng-Shyang Liao wrote:
> Hi CK,
> 
> Reply in line.
> 
> On Tue, 2016-05-24 at 11:05 +0800, CK Hu wrote:
> > Hi, HS:
> > 
> > Some comments below.
> > 
> ...
> > > +static void cmdq_thread_irq_handler(struct cmdq *cmdq, int tid)
> > > +{
> > > +	struct cmdq_thread *thread = &cmdq->thread[tid];
> > > +	unsigned long flags = 0L;
> > > +	int value;
> > > +
> > > +	spin_lock_irqsave(&cmdq->exec_lock, flags);
> > > +
> > > +	/*
> > > +	 * it is possible for another CPU core
> > > +	 * to run "release task" right before we acquire the spin lock
> > > +	 * and thus reset / disable this HW thread
> > > +	 * so we check both the IRQ flag and the enable bit of this thread
> > > +	 */
> > > +	value = cmdq_thread_readl(thread, CMDQ_THR_IRQ_STATUS);
> > > +	if (!(value & CMDQ_THR_IRQ_MASK)) {
> > > +		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > > +		return;
> > > +	}
> > 
> > If this case happen and just return without clearing irq status, the irq
> > would keep triggering and system hang up. So just remove this checking
> > and go down to clear irq status.
> 
> This case is safe because irq status is cleared.
> But, next if condition has the problem which you mentioned.
> 
> I will change it as below.
> 
> 	if (!(cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK) &
> 	      CMDQ_THR_ENABLED)) {
> 		cmdq_thread_writel(thread, ~value, CMDQ_THR_IRQ_STATUS);
> 		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> 		return;
> 	}
> 
> If thread is disabled, tasks must be all finished.
> Therefore, just clear irq status and return.
> 

For irq status checking part, if irq status & irq mask is zero, remove
this checking and let it go down, it still do nothing because value &
CMDQ_THR_IRQ_ERROR is zero and value & CMDQ_THR_IRQ_DONE is zero. So you
can just remove this checking and get the same result.

In general HW design, once a HW is not enable, it does not trigger
interrupt any more. Be sure that it's necessary to clear irq status even
though thread is disable.


> > > +
> > > +	if (!(cmdq_thread_readl(thread, CMDQ_THR_ENABLE_TASK) &
> > > +	      CMDQ_THR_ENABLED)) {
> > > +		spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > > +		return;
> > > +	}
> > > +
> > > +	cmdq_thread_writel(thread, ~value, CMDQ_THR_IRQ_STATUS);
> > > +
> > > +	if (value & CMDQ_THR_IRQ_ERROR)
> > > +		cmdq_handle_error_done(cmdq, thread, true);
> > > +	else if (value & CMDQ_THR_IRQ_DONE)
> > > +		cmdq_handle_error_done(cmdq, thread, false);
> > 
> > These irq status checking and clearing code here is the same as those in
> > cmdq_task_handle_error_result(). To move the checking and clearing code
> > into cmdq_handle_error_done() and here just to call
> > cmdq_handle_error_done(cmdq, thread) would reduce duplicated code.
> 
> Will do.
> 
> > > +
> > > +	spin_unlock_irqrestore(&cmdq->exec_lock, flags);
> > > +}
> ...
> ...
> > 
> > Regards,
> > CK
> 
> Thanks,
> HS
> 

Regards,
CK
