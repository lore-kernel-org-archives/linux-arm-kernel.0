From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Sep 2015 16:03:02 +0100
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <6A6F7BF2-D75E-4D8D-B0F7-45294C4C4426@gmail.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150917111735.GN25444@e104818-lin.cambridge.arm.com>
 <3C2C78B3-4669-4DBA-98DC-362EB762FD9C@gmail.com>
 <CFF333D1-E771-4C50-902A-444DAE76C163@gmail.com>
 <20150917162110.GO25444@e104818-lin.cambridge.arm.com>
 <6A6F7BF2-D75E-4D8D-B0F7-45294C4C4426@gmail.com>
Message-ID: <20150918150302.GA24449@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 09:57:56PM +0900, Jungseok Lee wrote:
> On Sep 18, 2015, at 1:21 AM, Catalin Marinas wrote:
> > So, without any better suggestion for current_thread_info(), I'm giving
> > up the idea of using SPSel == 0 in the kernel. I'll look at your patch
> > in more detail. BTW, I don't think we need the any count for the irq
> > stack as we don't re-enter the same IRQ stack.
> 
> Another interrupt could come in since IRQ is enabled when handling softirq
> according to the following information which are self-evident.
> 
> (Am I missing something?)

No. I had the wrong impression that we switch to the softirqd stack for
softirqs but you are right, if we run them on the same stack the IRQs
are enabled and they can be re-entered before we return from this
exception handler.

I've seen other architectures implementing a dedicated softirq stack but
for now we should just re-use the current IRQ stack.

> In my first approach using SPSel = 0, current_thread_info function was inefficient
> in order to handle this case correctly.

I agree. And we don't have any other scratch register left as we use
tpidr_el1 for per-cpu areas.

> BTW, in this context, it is only meaningful to decide whether a current interrupt
> is re-enterrant or not. Its actual value is not important, but I could not figure
> out a better implementation than this one yet. Any suggestions are welcome!

James' idea of checking the lower SP bits instead of a count may work.

-- 
Catalin
