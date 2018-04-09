From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 9 Apr 2018 12:26:00 +0100
Subject: [PATCH] arm64: avoid race condition issue in dump_backtrace
In-Reply-To: <1523174328.26617.91.camel@mtksdccf07>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
 <20180322055929.z25brvwlmdighz66@salmiak>
 <1521711329.26617.31.camel@mtksdccf07>
 <20180326113932.2i6qp3776jtmcqk4@lakrids.cambridge.arm.com>
 <1522229612.26617.47.camel@mtksdccf07>
 <20180328101240.moo44g5qd3qjuxgn@lakrids.cambridge.arm.com>
 <1522397292.26617.63.camel@mtksdccf07>
 <20180404090431.rqwtaqovipxa5gta@lakrids.cambridge.arm.com>
 <1523174328.26617.91.camel@mtksdccf07>
Message-ID: <20180409112559.uh76jpiytznymw6w@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 08, 2018 at 03:58:48PM +0800, Ji.Zhang wrote:
> Yes, I see where the loop is, I have missed that the loop may cross
> different stacks.
> Define a nesting order and check against is a good idea, and it can
> resolve the issue exactly, but as you mentioned before, we have no idea
> how to handle with overflow and sdei stack, and the nesting order is
> strongly related with the scenario of the stack, which means if someday
> we add another stack, we should consider the relationship of the new
> stack with other stacks. From the perspective of your experts, is that
> suitable for doing this in unwind?
> 
> Or could we just find some way easier but not so accurate, eg.
> Proposal 1: 
> When we do unwind and detect that the stack spans, record the last fp of
> previous stack and next time if we get into the same stack, compare it
> with that last fp, the new fp should still smaller than last fp, or
> there should be potential loop.
> For example, when we unwind from irq to task, we record the last fp in
> irq stack such as last_irq_fp, and if it unwind task stack back to irq
> stack, no matter if it is the same irq stack with previous, just let it
> go and compare the new irq fp with last_irq_fp, although the process may
> be wrong since from task stack it could not unwind to irq stack, but the
> whole process will eventually stop.

I agree that saving the last fp per-stack could work.

> Proposal 2:
> So far we have four types of stack: task, irq, overflow and sdei, could
> we just assume that the MAX number of stack spanning is just 3
> times?(task->irq->overflow->sdei or task->irq->sdei->overflow), if yes,
> we can just check the number of stack spanning when we detect the stack
> spans.

I also agree that counting the number of stack transitions will prevent
an inifinite loop, even if less accurately than proposal 1.

I don't have a strong preference either way.

Thanks,
Mark.
