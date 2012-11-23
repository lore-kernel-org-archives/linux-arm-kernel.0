From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 22:50:02 -0800
Subject: [PATCH 10/10] ARM: FIQ: Get rid of init_FIQ()
In-Reply-To: <1353652071.755665772@f76.mail.ru>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
 <1353642030.851395840@f20.mail.ru> <20121123055328.GA21566@lizard>
 <1353652071.755665772@f76.mail.ru>
Message-ID: <20121123065002.GB27827@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 10:27:51AM +0400, Alexander Shiyan wrote:
> > On Fri, Nov 23, 2012 at 07:40:30AM +0400, Alexander Shiyan wrote:
> > [...]
> > > >  static unsigned long no_fiq_insn;
> > > > +static int got_no_fiq_insn;
> > > > @@ -78,11 +79,14 @@ void show_fiq_list(struct seq_file *p, int prec)
> > > >  
> > > >  void set_fiq_handler(void *start, unsigned int length)
> > > >  {
> > > > -#if defined(CONFIG_CPU_USE_DOMAINS)
> > > > -	memcpy((void *)0xffff001c, start, length);
> > > > -#else
> > > > -	memcpy(vectors_page + 0x1c, start, length);
> > > > +	unsigned long *addr = (void *)0xffff001c;
> > > > +
> > > > +#ifndef CONFIG_CPU_USE_DOMAINS
> > > > +	addr = vectors_page + 0x1c;
> > > >  #endif
> > > > +	if (!cmpxchg(&got_no_fiq_insn, 0, 1))
> > > > +		no_fiq_insn = *addr;
> > > > +	memcpy(addr, start, length);
> > > >  	flush_icache_range(0xffff001c, 0xffff001c + length);
> > > >  	if (!vectors_high())
> > > >  		flush_icache_range(0x1c, 0x1c + length);
> > > > @@ -126,8 +130,3 @@ EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
> > > > -
> > > > -void __init init_FIQ(void)
> > > > -{
> > > > -	no_fiq_insn = *(unsigned long *)0xffff001c;
> > > 
> > > it seems that this is wrong. In this case we have an uninitialized variable and
> > > sequential call claim_fiq and release_fiq could be fatal. FIXME please.
> > 
> > Um... I don't think I understand, can you please elaborate?
> 
> OK, I'll try to explain it.
> At the end of the release_fiq function we have a call fiq_op. For the default
> handler - is a fiq_def_op function, and we call this function with the option
> "relinquish = 0", i.e. we want to restore old fiq_handler. But if we do not call
> set_fiq_handler never before, we will have an uninitialized no_fiq_insn variable.

It should not matter when or in what order anyone calls the
set_fiq_handler(), since it stores "no FIQ instruction" into no_fiq_insn
at its first invocation:

	if (!cmpxchg(&got_no_fiq_insn, 0, 1))
		no_fiq_insn = *addr;

If we never called set_fiq_handler() before, during release_fiq() we'll:

1. Copy the initial instruction from the vector page to 'no_fiq_insn';
2. Copy the initial instruction from 'no_fiq_insn' to the vector page;

So no_fiq_insn gets initialized, then we just instantly write the same
value back.

Thanks,
Anton.
