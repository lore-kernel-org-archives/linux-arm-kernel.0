From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Jul 2012 14:41:31 +0100
Subject: [Xen-devel] [PATCH 02/24] xen/arm: hypercalls
In-Reply-To: <1343395134.6812.162.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120726163352.GC9222@phenom.dumpdata.com>
 <1343380659.6812.106.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1207271350370.26163@kaball.uk.xensource.com>
 <1343395134.6812.162.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1207271431320.26163@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jul 2012, Ian Campbell wrote:
> > > > Should this comment be by 'privcmd_call'?
> > > 
> > > When we add a 5 argument hypercall I suppose we'll see the required
> > > push/pop of r4 added to this macro too.
> > 
> > For performance and simplicity I would add a second macro that push/pop
> > r4, only required for hypercalls with more than 4 arguments.
> 
> For clarity / documentation purposes it might actually be worthwhile to
> define all of HYPERCALL{0,1,2,3,4} even if the {0,1,2,3} cases are all
> just:
>         #define HYPERCALL0(x) HYPERCALL_SIMPLE(x)

I agree

> > > > > +#define HYPERCALL(hypercall)			\
> > > > > +ENTRY(HYPERVISOR_##hypercall)			\
> > > > > +	mov r12, #__HYPERVISOR_##hypercall;	\
> > > > > +	xen_hvc;							\
> > > > > +	mov pc, lr;							\
> > > > > +ENDPROC(HYPERVISOR_##hypercall)
> > > > > +
> > > > > +                .text
> > > > > +
> > > > > +HYPERCALL(xen_version);
> > > > > +HYPERCALL(console_io);
> > > > > +HYPERCALL(grant_table_op);
> > > > > +HYPERCALL(sched_op);
> > > > > +HYPERCALL(event_channel_op);
> > > > > +HYPERCALL(hvm_op);
> > > > > +HYPERCALL(memory_op);
> > > > > +HYPERCALL(physdev_op);
> > > > > +
> > > > > +ENTRY(privcmd_call)
> > > > > +	stmdb	sp!, {r4}
> > > > > +	mov r12, r0
> > > > > +	mov r0, r1
> > > > > +	mov r1, r2
> > > > > +	mov r2, r3
> > > > > +	ldr r3, [sp, #8]
> > > > > +	ldr r4, [sp, #4]
> > > > > +	xen_hvc
> > > > > +	pop {r4}
> > > 
> > > Why not ldmdb for symmetry?
> > 
> > Yep, I can do that.

Actually it is just ldm or ldmia
