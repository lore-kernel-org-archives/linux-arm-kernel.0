From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Dec 2017 17:40:03 +0000
Subject: [PATCH v2 13/18] arm64: entry: Hook up entry trampoline to
 exception vectors
In-Reply-To: <20171201135300.novwsr5yxveeeq7m@lakrids.cambridge.arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-14-git-send-email-will.deacon@arm.com>
 <20171201135300.novwsr5yxveeeq7m@lakrids.cambridge.arm.com>
Message-ID: <20171201174002.GA8826@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 01:53:01PM +0000, Mark Rutland wrote:
> On Thu, Nov 30, 2017 at 04:39:41PM +0000, Will Deacon wrote:
> >  	.macro kernel_ventry, el, label, regsize = 64
> >  	.align 7
> > +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> > +	.if	\el == 0
> > +	.if	\regsize == 64
> > +	mrs	x30, tpidrro_el0
> > +	msr	tpidrro_el0, xzr
> > +	.else
> > +	mov	x30, xzr
> 
> I guess that's just to prevent acccidental leaks if we dump registers
> somewhere, since we used x30 as a scratch register?

Indeed. I don't have a concrete example, but I was worried about things
like perf and ptrace, which might allow you to get at the AArch64 register
state for a compat task so it felt like a good idea to zero this.

Will
