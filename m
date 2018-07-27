From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 27 Jul 2018 09:56:44 +0200
Subject: [PATCH RT v3] arm64: fpsimd: use preemp_disable in addition to
 local_bh_disable()
In-Reply-To: <1532661443.10554.5.camel@gmx.de>
References: <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180724094623.37430032@gandalf.local.home>
 <20180726150634.cl3wccqur6qhle6p@linutronix.de>
 <1532661443.10554.5.camel@gmx.de>
Message-ID: <20180727075644.lapmhyxxdb6jbaqr@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-27 05:17:23 [+0200], Mike Galbraith wrote:
> On Thu, 2018-07-26 at 17:06 +0200, Sebastian Andrzej Siewior wrote:
> > 
> > @@ -1115,6 +1139,7 @@ void kernel_neon_begin(void)
> >  
> >  	BUG_ON(!may_use_simd());
> >  
> > +	preempt_disable();
> >  	local_bh_disable();
> >  
> >  	__this_cpu_write(kernel_neon_busy, true);
> > @@ -1131,6 +1156,7 @@ void kernel_neon_begin(void)
> >  	preempt_disable();
> 
> Nit: this preempt_disable() could be removed...
>  
> >  	local_bh_enable();
> > +	preempt_enable();
> >  }
> >  EXPORT_SYMBOL(kernel_neon_begin);
> 
> ...instead of adding this one.

It could. I have currently no idea for the long term solution and this
keeps track what is intended to do. It might get replaced with
preempt_.*_rt()?

> 	-Mike

Sebastian
