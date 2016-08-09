From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 9 Aug 2016 19:50:59 +0800
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <57A9ABB1.6060109@arm.com>
References: <20160808134842.GE12649@leverpostej>
 <20160808145916.0924e868@arm.com> <20160809034613.GB31105@shlinux2>
 <20160809063401.3117dc94@arm.com> <20160809055701.GC31105@shlinux2>
 <20160809075930.529f98ca@arm.com> <20160809071821.GD31105@shlinux2>
 <57A99A4A.6010301@arm.com> <20160809093942.GA10803@shlinux2>
 <57A9ABB1.6060109@arm.com>
Message-ID: <20160809115059.GB10803@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 11:08:49AM +0100, Marc Zyngier wrote:
> On 09/08/16 10:39, Peter Chen wrote:
> > 
> > Your patch can work for my case. Below is objdump for gic_raise_softirq,
> > the code with your patch seems have more instructions.
> 
> Well, I've added code to the function, so that's hardly surprising. The
> important thing is that the hot path is kept relatively fast.
> 
> > 
> > - With your patch:
> > 00000c44 <gic_raise_softirq>:
> >      c44:	e1a0c00d 	mov	ip, sp
> >      c48:	e92ddbf0 	push	{r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
> >      c4c:	e24cb004 	sub	fp, ip, #4
> >      c50:	e59f908c 	ldr	r9, [pc, #140]	; ce4 <gic_raise_softirq+0xa0>
> >      c54:	e1a06000 	mov	r6, r0
> >      c58:	e1a07001 	mov	r7, r1
> >      c5c:	e5993000 	ldr	r3, [r9]
> >      c60:	e3530001 	cmp	r3, #1
> >      c64:	0a000019 	beq	cd0 <gic_raise_softirq+0x8c>
> 
> So the overhead is two loads, one comparison and a branch. Can you
> actually measure the difference? If you can, I'd like to see some cycle
> numbers, not just instruction counts. If you can consistently measure
> something that is not just noise, we can then turn this into a static key.
> 

Sorry, the context was in interrupt at mind when I wrote the last emails.
But in fact, it wasn't. Thanks for help it.

You can add: Tested-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
