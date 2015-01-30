From: geoff@infradead.org (Geoff Levand)
Date: Fri, 30 Jan 2015 13:47:11 -0800
Subject: [PATCH 4/8] arm64: Add EL2 switch to soft_restart
In-Reply-To: <20150127175740.GK3226@e104818-lin.cambridge.arm.com>
References: <cover.1421449714.git.geoff@infradead.org>
 <bb44d4eee4fab15278e4a8829a0981878bc9acd7.1421449714.git.geoff@infradead.org>
 <20150127175740.GK3226@e104818-lin.cambridge.arm.com>
Message-ID: <1422654431.21823.33.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, 2015-01-27 at 17:57 +0000, Catalin Marinas wrote:
> On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> >  ENTRY(cpu_reset)
> > -	mrs	x1, sctlr_el1
> > -	bic	x1, x1, #1
> > -	msr	sctlr_el1, x1			// disable the MMU
> > +	mrs	x2, sctlr_el1
> > +	bic	x2, x2, #1
> > +	msr	sctlr_el1, x2			// disable the MMU
> >  	isb
> > -	ret	x0
> > +
> > +	cbz	x0, 1f				// el2_switch?
> > +	mov	x0, x1
> > +	mov	x1, xzr
> > +	mov	x2, xzr
> > +	mov	x3, xzr
> > +	hvc	#HVC_CALL_FUNC			// no return
> 
> If that's the only user of HVC_CALL_FUNC, why do we bother with
> arguments, calling convention?

It was intended that HVC_CALL_FUNC be a mechanism to call a generic
function in hyp mode.  cpu_reset() is the only user of it now.

As Mark explained in another post, the use of x18 by the hyp stub
is to avoid the complication of setting up a stack for EL2.  We
thought this solution was acceptable since there are relatively
few HVC_CALL_FUNC calls and we could assure they would do the
right thing.

-Geoff 
